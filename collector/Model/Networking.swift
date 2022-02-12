//
//  Networking.swift
//  collector
//
//  Created by Brian on 8/4/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation
import UIKit
import SwiftSoup
import CoreData



protocol NetworkingDelegate: AnyObject {
    func checkForGameInLibrary(name: String, id: Int, platformID: Int) -> Bool
}


class Networking {
    //test push
    var persistenceManager = PersistenceManager.shared
    var initialFetchComplete = false
    var gameFetchDidFail = false
    var genreFetchDidFail = false
    var platformFetchDidFail = false
    var gameFetchSuccess = false
    var genreFetchSuccess = false
    var platformFetchSuccess = false
    var lastRequestedPlatformID = 18
    var endOfResults = false
    var fetchingMore = false
    var sourceTag = 0
    var gameGenreData : [String: Genre] = [:]
    var gameArray = [GameObject]()
    var searchResultsData = [GameObject]()
    var initialOffset = 0
    var currentOffset = 0
    var owned : Bool?
    weak var delegate: NetworkingDelegate?
    var tempArray = [GameObject]()
    var platforms = [IGDBPlatform]()
    var genres = [IGDBGenre]()
    var userImageArray : [UIImage] = []
    var consolePlatforms: [String] = []
    var portablePlatforms: [String] = []
    var searchIsActive = false
    var searchFilter = ""
    var searchText = ""
    var comingSoonArray = [GameObject]()
    var recentlyReleasedArray = [GameObject]()
    var topTwentyArray = [GameObject]()
    var scannedGameResults = [GameObject]()
    var resultsReceived : Bool = true
    var scrapedURL = ""
    var previousDataCount = 0
    var currentDataCount = 0
    var newDataCount = 0
    var currentTask : URLSessionTask?
    var totalRequestCount = 0
    var priceInfo = PriceInfo()
    
    
    
    
    init() {}
    static let shared = Networking()
    
    
    
    
    
    
    func scrapePriceCharting(platformID: Int, gameName: String, uneditedGameName: String, completed: @escaping (PriceInfo) -> () ) {

        //Scrapes pricecharting.com to get a games value.  If only a single value is returned, there is an exact match to our game.  If there is no value returned, there are no matches to our game.  If there are multiple results returned the method uses Levenshtein distance score to assign a score of how similar each result is to the requested game name.  If a match is above 60%, it has a good likelihood of being our game.  We then take the highest scoring match of those above 60% to be the game we are looking for.  Not perfect but it does provide the correct game most of the time.
        
        let consoleUID = formatPlatformIDToPriceChartingID(ID: platformID)
        let priceObject = PriceInfo()
        
        var name = gameName.replacingOccurrences(of: " ", with: "-")
        name = name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        name = name.replacingOccurrences(of: "'", with: "%27")

        
        let url = URL(string:"https://www.pricecharting.com/search-products?q=\(name)&type=prices&sort=popularity&broad-category=video-games&console-uid=\(consoleUID)&region-name=ntsc&exclude-variants=false")!
        network.scrapedURL = url.absoluteString

        let content = (try? String(contentsOf: url))
        
        
        if let htmlContent = content {
            
            
            do {
                let doc : Document = try SwiftSoup.parse(htmlContent)

                let docTitle = try! doc.title()
                
                if docTitle.contains("Game List") {
                    
                    //scrape result returned no results
                    
                    if try! doc.select("table#games_table.hoverable-rows.sortable").first() == nil {
                        
                        
                        priceObject.title = "N/A"
                        priceObject.loosePrice = "N/A"
                        priceObject.cibPrice = "N/A"
                        priceObject.newPrice = "N/A"
                        
                        
                        DispatchQueue.main.async {
                            completed(priceObject)
                        }

                    } else {
                        
                        
                        //scrape result is returning multiple games, identifying needed properties and then taking most relavent result
                        
                        
                        let table = try! doc.select("table#games_table.hoverable-rows.sortable").first()!
                        let rows = try! table.select("tr")
                        
                        let titles = try! rows.compactMap { row throws -> String? in
                            let cells = try! row.select("td.title")
                            guard cells.count == 1, let link = try cells[0].select("a").first() else {
                                return nil // wrong row
                            }
                            
                            return try link.text()
                        }
                        
                        let platforms = try! rows.compactMap { row throws -> String? in
                            
                            let link = try row.select("td.console").first()
                            return try link?.text()
                            
                            
                        }
                        
                        let loosePrices = try! rows.compactMap { row throws -> String? in
                            let cells = try! row.select("td.price.numeric.used_price")
                            guard cells.count == 1, let link = try cells[0].select("span.js-price").first() else {
                                return nil // wrong row
                            }
                            
                            return try link.text()
                        }
                        
                        
                        let cibPrices = try! rows.compactMap { row throws -> String? in
                            let cells = try! row.select("td.price.numeric.cib_price")
                            guard cells.count == 1, let link = try cells[0].select("span.js-price").first() else {
                                return nil // wrong row
                            }
                            
                            return try link.text()
                        }
                        
                        let newPrices = try! rows.compactMap { row throws -> String? in
                            let cells = try! row.select("td.price.numeric.new_price")
                            guard cells.count == 1, let link = try cells[0].select("span.js-price").first() else {
                                return nil // wrong row
                            }
                            
                            return try link.text()
                        }
                        
                        let currentPlatform = formatPlatformIDToPlatformName(ID: platformID)

                        var matchingIndexArray : [Int] = []
                        
                        var index = 0
                        
                        for platform in platforms {
                            if platform.caseInsensitiveCompare(currentPlatform) == .orderedSame {

                                matchingIndexArray.append(index)
                            }
                            index += 1
                        }
                        
                        
                        if matchingIndexArray.count > 0 {
                            var titleScoreArray : [Double] = []
                            for index in matchingIndexArray {
                                let title = titles[index]
                                let score = title.levenshteinDistanceScore(to: uneditedGameName, ignoreCase: true, trimWhiteSpacesAndNewLines: true)

                                titleScoreArray.append(score)
                                
                            }
                            
                            var bestMatchIndex : Int?
                            let location = titleScoreArray.firstIndex(of: titleScoreArray.max()!)
                            let topScore = titleScoreArray.max()!
                            if topScore > 0.6 {
                                if let location = location {
                                    bestMatchIndex = Int(location)
                                }
                            }
                            var winningIndex : Int?
                            if let index = bestMatchIndex {
                                winningIndex = index
                            }
                            
                            if let index = winningIndex {
                                priceObject.title = titles[index]
                                priceObject.loosePrice = loosePrices[index]
                                priceObject.cibPrice = cibPrices[index]
                                priceObject.newPrice = newPrices[index]
                                
                            } else {
                                priceObject.title = "N/A"
                                priceObject.loosePrice = "N/A"
                                priceObject.cibPrice = "N/A"
                                priceObject.newPrice = "N/A"
                                
                            }
                            
                            
                        } else {
                            priceObject.title = "N/A"
                            priceObject.loosePrice = "N/A"
                            priceObject.cibPrice = "N/A"
                            priceObject.newPrice = "N/A"
                        }
                        
                        DispatchQueue.main.async {
                            completed(priceObject)
                        }
                    }

                } else {
                        //single match
                    let table = try! doc.select("table#price_data.info_box").first()!
                    let rows = try! table.select("tr")
                    let gamePage = try! doc.select("div#game-page").first()!
                    let gameText = try! gamePage.select("h1#product_name.chart_title")

                    var titles = try! gameText.compactMap { row throws -> String? in
                        
                        let link = gameText[0]

                        return try link.text()
                    }
                    
                    let platforms = try! gameText.compactMap { row throws -> String? in
                        
                        guard gameText.count == 1, let console = try gameText[0].select("a").first() else {
                            return nil // wrong row
                        }
                        return try console.text()
                    }
                    
                    let loosePrices = try! rows.compactMap { row throws -> String? in
                        let cells = try! row.select("td#used_price")
                        guard cells.count == 1, let link = try cells[0].select("span.js-price").first() else {
                            return nil // wrong row
                        }
                        
                        return try link.text()
                    }
                    
                    
                    let cibPrices = try! rows.compactMap { row throws -> String? in
                        let cells = try! row.select("td#complete_price")
                        guard cells.count == 1, let link = try cells[0].select("span.js-price").first() else {
                            return nil // wrong row
                        }
                        
                        return try link.text()
                    }
                    
                    let newPrices = try! rows.compactMap { row throws -> String? in
                        let cells = try! row.select("td#new_price")
                        guard cells.count == 1, let link = try cells[0].select("span.js-price").first() else {
                            return nil // wrong row
                        }
                        
                        return try link.text()
                        
                    }
                    
                    var scoreArray : [Double] = []
                    titles[0] = titles[0].replacingOccurrences(of: " " + platforms[0], with: "")
                    
                    for title in titles {
                        let score = title.levenshteinDistanceScore(to: uneditedGameName, ignoreCase: true, trimWhiteSpacesAndNewLines: true)

                        scoreArray.append(score)
                    }
                    var bestMatchIndex : Int?
                    let location = scoreArray.firstIndex(of: scoreArray.max()!)
                    let topScore = scoreArray.max()!
                    if topScore > 0.5 {
                        if let location = location {
                            bestMatchIndex = Int(location)
                        }
                    }

                    if let index = bestMatchIndex {
                        priceObject.title = titles[index]
                        priceObject.loosePrice = loosePrices[index]
                        priceObject.cibPrice = cibPrices[index]
                        priceObject.newPrice = newPrices[index]
                    } else {
                        priceObject.title = "N/A"
                        priceObject.loosePrice = "N/A"
                        priceObject.cibPrice = "N/A"
                        priceObject.newPrice = "N/A"
                    }
                    DispatchQueue.main.async {
                        completed(priceObject)
                    }
                    
                }
                
                
            }
            
            
            catch {
                print("fail")
            }
            
        }

        
    }
    
    
    func fetchGameFromUPC(gameName: String, platformID: [Int], completed: @escaping (Error?) -> () ) {
        //method is used when the barcode scanner comes up with no matching results.  This allows the user to manually enter the games name, and then it will search IGDB and return an array of matching results similar to the name entered.
        
        scannedGameResults.removeAll()
        
        let allowedPlatforms : [Int] = [50,114,59,66,60,62,61,68,127,67,88,11,12,49,169,80,136,119,120,307,18,19,87,4,21,5,41,130,33,22,24,20,159,37,137,166,42,122,86,128,117,84,64,29,78,30,32,23,35,339,7,8,9,48,167,38,46,70,57,123,240]
        let fields = "fields age_ratings.*, genres.*, name, first_release_date, summary, involved_companies.company.name, involved_companies.publisher, total_rating, total_rating_count, platforms.*, cover.*, platforms.versions.platform_logo.*, platforms.platform_logo.*, screenshots.*, game_modes.name, rating, status, videos.video_id;"

        var filter = ""
        var platforms = ""
        
        let platformCount = platformID.count
        
        var currentIndex = 0
        for platform in platformID {
            if currentIndex == platformCount - 1 {
                //last index
                
                platforms += String(platform)
                
            } else {
                currentIndex += 1
                
                platforms += String(platform)
                platforms += ","
            }
        }

        
        if platformID.count < 1 {
            filter = " where themes != (42) & status = n & category != (1,2,5,6,7);"
        } else {
            
            filter = " where themes != (42) & status = n & category != (1,2,5,6,7) & platforms = (\(platforms));"
        }
        
        let search = "search \"\(gameName)\";"
        let httpBodyString = fields + search + filter
        let url = URL(string: "https://30kn8ciec4.execute-api.us-west-2.amazonaws.com/production/v4/games")!
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpBody = httpBodyString.data(using: .utf8, allowLossyConversion: false)
        if let key = Data(base64Encoded: Secret.apiKey!, options: []).map( {String(data: $0, encoding: .utf8) }) {
            requestHeader.addValue(key!, forHTTPHeaderField: "X-Api-Key")
        }
        requestHeader.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: requestHeader) { [self] (data, response, error) in
            
            do {
                
                var array = [GameObject]()
             

                if let decodedGameData = try JSONDecoder().decode(IGDBGames?.self, from: data!) {

                    if decodedGameData.count == 0 {
                        resultsReceived = false
                        DispatchQueue.main.async {
                            completed(nil)
                        }
                    }
                    
                    resultsReceived = true
                    for gameData in decodedGameData {
                        var game = GameObject()
 
                        if platformID.count > 0 {
                            
                            for platform in platformID {
                                
                                
                                if allowedPlatforms.contains(platform) {
                                    
                                    game.id = gameData.id
                                    game.title = gameData.name
                                    if let date = gameData.firstReleaseDate {
                                        let releaseDate = NSDate(timeIntervalSince1970: TimeInterval(date))
                                        
                                        
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "MM-dd-yyyy"
                                        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                                        let formattedDate = dateFormatter.string(from: releaseDate as Date)

                                        game.releaseDate = "\(formattedDate)"
                                    }
                                    
                                    var genreArray : [String] = []
                                    if let genreData = gameData.genres {
                                        for genre in genreData {

                                            genreArray.append(genre.name!)
                                        }
                                        game.genres = genreArray
                                    }
                                    game.genreDescriptions = genreArray.joined(separator: " | ")
                                    
                                    if let gameModes = gameData.gameModes {
                                        var modeArray : [String] = []
                                        
                                        for mode in gameModes {
                                            modeArray.append(mode.name!)
                                        }
                                        
                                        if modeArray.count > 0 {
                                            game.maxPlayers = modeArray.joined(separator: " | ")
                                        } else {
                                            game.maxPlayers = ""
                                        }
                                        
                                    } else {
                                        game.maxPlayers = ""
                                    }
                                    if let totalRating = gameData.totalRating {
                                        game.totalRating = Int(totalRating)
                                    }
                                    
                                    if let userRating = gameData.rating {
                                        game.userRating = Int(userRating)
                                    }
                                    
                                    
                                    
                                    game.overview = gameData.summary
                                    
                                    if let ageRatings = gameData.ageRatings {
                                        
                                        
                                        let esrbRatings = ageRatings.filter { $0.category == 1 }
                                        let pegiRatings = ageRatings.filter { $0.category == 2 }

                                        if esrbRatings.count > 0 {
                                            
                                            let rating = esrbRatings[0].rating!

                                            game.rating = fetchAgeRatingString(rating: rating)

                                        } else {
                                            if esrbRatings.count == 0 {
                                                if pegiRatings.count > 0 {
                                                    let rating = pegiRatings[0].rating!
                                                    game.rating = fetchAgeRatingString(rating: rating)
                                                }
                                            }
                                        }

                                        
                                    } else {
                                        game.rating = "ESRB NR"
                                    }
                                    
                                    
                                    
                                    game.screenshots = gameData.screenshots
                                    
                                    
                                    
                                    game.youtubePath = gameData.videos?[0].videoID
                                    
                                    
                                    game.platformID = platform
                                    
                                    
                                    
                                    if let genres = gameData.genres {
                                        for genre in genres {
                                            if let genreName = genre.name {
                                                game.genres?.append(genreName)
                                            }
                                        }
                                    } else {
                                        game.genres?.append("")
                                    }
                                    
                                    
                                    if let involvedCompanies = gameData.involvedCompanies {
                                        for company in involvedCompanies {
                                            
                                            if company.publisher == true {
                                                
                                                
                                                game.developer = fetchCompanyName(companyID: company.id!, game: gameData
                                                )
                                                
                                                
                                            }
                                        }
                                    }
                                    game.boxartInfo = gameData.cover
                                    
                                    if let imageID = gameData.cover?.imageID {
                                        game.boxartFrontImage = imageID + ".jpg"
                                    }
                                    
                                    
                                    guard let name = game.title else { return }
                                    guard let id = game.id else { return }
                                    guard let platformID = game.platformID else { return }
                                    game.owned = delegate?.checkForGameInLibrary(name: name, id: id, platformID: platformID)
                                    array.append(game)
                                    self.scannedGameResults = array
                                    
                                    
                                    DispatchQueue.main.async {
                                        completed(nil)
                                    }
                                    
                                }
                            }
                            
                        }
                        
                        else {
                            
                            
                            if let platforms = gameData.platforms {
                                
                                
                                for platform in platforms {
                                    if allowedPlatforms.contains(platform.id) {
                                        
                                        game.id = gameData.id
                                        game.title = gameData.name
                                        if let date = gameData.firstReleaseDate {
                                            let releaseDate = NSDate(timeIntervalSince1970: TimeInterval(date))
                                            
                                            
                                            let dateFormatter = DateFormatter()
                                            dateFormatter.dateFormat = "MM-dd-yyyy"
                                            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                                            let formattedDate = dateFormatter.string(from: releaseDate as Date)
                                            
                                            game.releaseDate = "\(formattedDate)"
                                        }
                                        
                                        var genreArray : [String] = []
                                        if let genreData = gameData.genres {
                                            for genre in genreData {
                                                
                                                genreArray.append(genre.name!)
                                            }
                                            game.genres = genreArray
                                        }
                                        game.genreDescriptions = genreArray.joined(separator: " | ")
                                        
                                        if let gameModes = gameData.gameModes {
                                            var modeArray : [String] = []
                                            
                                            for mode in gameModes {
                                                modeArray.append(mode.name!)
                                            }
                                            
                                            if modeArray.count > 0 {
                                                game.maxPlayers = modeArray.joined(separator: " | ")
                                            } else {
                                                game.maxPlayers = ""
                                            }
                                            
                                        } else {
                                            game.maxPlayers = ""
                                        }
                                        if let totalRating = gameData.totalRating {
                                            game.totalRating = Int(totalRating)
                                        }
                                        
                                        if let userRating = gameData.rating {
                                            game.userRating = Int(userRating)
                                        }
                                        
                                        
                                        
                                        game.overview = gameData.summary
                                        
                                        if let ageRatings = gameData.ageRatings {
                                            
                                            
                                            let esrbRatings = ageRatings.filter { $0.category == 1 }
                                            let pegiRatings = ageRatings.filter { $0.category == 2 }
                                            
                                            
                                            if esrbRatings.count > 0 {
                                                
                                                let rating = esrbRatings[0].rating!
                                                
                                                game.rating = fetchAgeRatingString(rating: rating)
                                                
                                                
                                            } else {
                                                if esrbRatings.count == 0 {
                                                    if pegiRatings.count > 0 {
                                                        let rating = pegiRatings[0].rating!
                                                        game.rating = fetchAgeRatingString(rating: rating)
                                                    }
                                                }
                                            }
                                            
                                            
                                            
                                            
                                        } else {
                                            game.rating = "ESRB NR"
                                        }
                                        
                                        
                                        
                                        game.screenshots = gameData.screenshots
                                        
                                        game.youtubePath = gameData.videos?[0].videoID
                                        
                                        
                                        game.platformID = platform.id
                                        
                                        
                                        
                                        
                                        if let genres = gameData.genres {
                                            for genre in genres {
                                                if let genreName = genre.name {
                                                    game.genres?.append(genreName)
                                                }
                                            }
                                        } else {
                                            game.genres?.append("")
                                        }
                                        
                                        
                                        if let involvedCompanies = gameData.involvedCompanies {
                                            for company in involvedCompanies {
                                                
                                                if company.publisher == true {
                                                    
                                                    
                                                    game.developer = fetchCompanyName(companyID: company.id!, game: gameData
                                                    )
                                                    
                                                    
                                                }
                                            }
                                        }
                                        game.boxartInfo = gameData.cover
                                        
                                        if let imageID = gameData.cover?.imageID {
                                            game.boxartFrontImage = imageID + ".jpg"
                                        }
                                        
                                        guard let name = game.title else { return }
                                        guard let id = game.id else { return }
                                        guard let platformID = game.platformID else { return }
                                        game.owned = delegate?.checkForGameInLibrary(name: name, id: id, platformID: platformID)
                                        array.append(game)
                                        self.scannedGameResults = array
                                        
                                        
                                        
                                        DispatchQueue.main.async {
                                            completed(nil)
                                        }
                                        
                                    }
                                }
                                
                            }
                        }
                        
                        
                        
                    }
                    
                }
                
                
                
            }
            
            catch {

                DispatchQueue.main.async {
                    completed(error)
                }
                
            }
            
        }.resume()
        
    }
    
    
    
    func fetchIGDBTop20Data(platformID: Int, completed: @escaping (Error?) -> () ) {
        topTwentyArray.removeAll()
        
        
        let fields = "fields age_ratings.*, genres.*, name, first_release_date, summary, involved_companies.company.name, involved_companies.publisher, total_rating, total_rating_count, platforms.*, cover.*, platforms.versions.platform_logo.*, platforms.platform_logo.*, screenshots.*, game_modes.name, rating, status, videos.video_id;"
        let filter = " where themes != (42) & status = n & total_rating != n & total_rating_count > 5 &category != (1,2,5,6,7) & platforms = (\(platformID)) & platforms != (19); limit 20; sort total_rating desc;"
        
        
        
        let httpBodyString = fields + filter
        
        let url = URL(string: "https://30kn8ciec4.execute-api.us-west-2.amazonaws.com/production/v4/games")!
        var requestHeader = URLRequest.init(url: url)
        if let key = Data(base64Encoded: Secret.apiKey!, options: []).map( {String(data: $0, encoding: .utf8) }) {
            requestHeader.addValue(key!, forHTTPHeaderField: "X-Api-Key")
        }
        requestHeader.httpBody = httpBodyString.data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "POST"
        
        
        URLSession.shared.dataTask(with: requestHeader) { [self] (data, response, error) in
            
            if error == nil {
                
                do {
                    
                    var array = [GameObject]()
                    
                    
                    if let decodedGameData = try JSONDecoder().decode(IGDBGames?.self, from: data!) {
                        
                        
                        
                        if decodedGameData.count == 0 {
                            endOfResults = true
                            
                        } else {
                            endOfResults = false
                            
                        }
                        for gameData in decodedGameData {
                            var game = GameObject()
                            
                            game.id = gameData.id
                            game.title = gameData.name
                            if let date = gameData.firstReleaseDate {
                                let releaseDate = NSDate(timeIntervalSince1970: TimeInterval(date))
                                
                                
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "MM-dd-yyyy"
                                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                                let formattedDate = dateFormatter.string(from: releaseDate as Date)
                                
                                game.releaseDate = "\(formattedDate)"
                            }
                            
                            var genreArray : [String] = []
                            if let genreData = gameData.genres {
                                for genre in genreData {
                                   
                                    genreArray.append(genre.name!)
                                }
                                game.genres = genreArray
                            }
                            game.genreDescriptions = genreArray.joined(separator: " | ")
                            
                            if let gameModes = gameData.gameModes {
                                var modeArray : [String] = []
                                
                                for mode in gameModes {
                                    modeArray.append(mode.name!)
                                }
                                
                                if modeArray.count > 0 {
                                    game.maxPlayers = modeArray.joined(separator: " | ")
                                } else {
                                    game.maxPlayers = ""
                                }
                                
                            } else {
                                game.maxPlayers = ""
                            }
                            if let totalRating = gameData.totalRating {
                                game.totalRating = Int(totalRating)
                            }
                            
                            if let userRating = gameData.rating {
                                game.userRating = Int(userRating)
                            }
                            
                            
                            
                            game.overview = gameData.summary
                            
                            if let ageRatings = gameData.ageRatings {
                                
                                
                                let esrbRatings = ageRatings.filter { $0.category == 1 }
                                let pegiRatings = ageRatings.filter { $0.category == 2 }
                                
                                
                                if esrbRatings.count > 0 {
                                    
                                    let rating = esrbRatings[0].rating!
                                    
                                    game.rating = fetchAgeRatingString(rating: rating)
                                    
                                    
                                } else {
                                    if esrbRatings.count == 0 {
                                        if pegiRatings.count > 0 {
                                            let rating = pegiRatings[0].rating!
                                            game.rating = fetchAgeRatingString(rating: rating)
                                        }
                                    }
                                }
                                
                                
                                
                            } else {
                                game.rating = "ESRB NR"
                            }
                            
                            
                            
                            game.screenshots = gameData.screenshots
                            
                            game.youtubePath = gameData.videos?[0].videoID
                            
                            
                            if let platforms = gameData.platforms {
                                for platform in platforms {
                                    if platform.id == platformID {
                                        game.platformID = platformID
                                    }
                                }
                            }
                            
                            
                            if let genres = gameData.genres {
                                for genre in genres {
                                    if let genreName = genre.name {
                                        game.genres?.append(genreName)
                                    }
                                }
                            } else {
                                game.genres?.append("")
                            }
                            
                            
                            if let involvedCompanies = gameData.involvedCompanies {
                                for company in involvedCompanies {
                                    
                                    if company.publisher == true {
                                        
                                        
                                        game.developer = fetchCompanyName(companyID: company.id!, game: gameData
                                        )
                                        
                                    }
                                }
                            }
                            game.boxartInfo = gameData.cover
                            
                            if let imageID = gameData.cover?.imageID {
                                game.boxartFrontImage = imageID + ".jpg"
                            }
                            
                            guard let name = game.title else { return }
                            guard let id = game.id else { return }
                            guard let platformID = game.platformID else { return }
                            game.owned = delegate?.checkForGameInLibrary(name: name, id: id, platformID: platformID)
                            array.append(game)
                            self.tempArray = array
                            
                            
                        }
                        
                        
                        let newData = self.tempArray
                        var oldData = self.topTwentyArray
                        
                        
                        oldData.append(contentsOf: newData)
                        let mergedData = oldData

                        if self.currentOffset < mergedData.count {
                            
                            self.topTwentyArray = mergedData
                  
                        } else {
                            self.topTwentyArray = mergedData
                        }
                        
                    }
                    
                    DispatchQueue.main.async {
                        completed(nil)
                    }
                    
                    
                }
                
                catch {
                    DispatchQueue.main.async {
                        completed(error)
                    }
                }
                
            }
        }.resume()
    }
    
    
    
    func fetchIGDBRecentlyReleasedData(platformID: Int, completed: @escaping (Error?) -> () ) {
        recentlyReleasedArray.removeAll()
        
        
        let today = Int(Calendar(identifier: .gregorian).startOfDay(for: Date()).timeIntervalSince1970)
        
        let todayMinusThirty = Int(Calendar.current.date(byAdding: .month, value: -1, to: Date())!.timeIntervalSince1970)
        
        let fields = "fields age_ratings.*, genres.*, name, first_release_date, summary, involved_companies.company.name, involved_companies.publisher, total_rating, total_rating_count, platforms.*, cover.*, platforms.versions.platform_logo.*, platforms.platform_logo.*, screenshots.*, game_modes.name, rating, status, videos.video_id;"
        let filter = " where themes != (42) & status = n & category != (1,2,5,6,7) & platforms = (\(platformID)) & first_release_date > \(todayMinusThirty) & first_release_date <= \(today); limit 500; sort first_release_date desc;"
        
        
        
        let httpBodyString = fields + filter

        let url = URL(string: "https://30kn8ciec4.execute-api.us-west-2.amazonaws.com/production/v4/games")!
        var requestHeader = URLRequest.init(url: url)
        
        
        if let key = Data(base64Encoded: Secret.apiKey!, options: []).map( {String(data: $0, encoding: .utf8) }) {
            requestHeader.addValue(key!, forHTTPHeaderField: "X-Api-Key")
        }
        
        requestHeader.httpBody = httpBodyString.data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "POST"
        
        
        URLSession.shared.dataTask(with: requestHeader) { [self] (data, response, error) in
            
            if error == nil {
                
                do {
                    
                    var array = [GameObject]()
                    
                    
                    if let decodedGameData = try JSONDecoder().decode(IGDBGames?.self, from: data!) {
                        
                        
                        if decodedGameData.count == 0 {
                            endOfResults = true
                            
                        } else {
                            endOfResults = false
                            
                            
                        }
                        for gameData in decodedGameData {
                            var game = GameObject()
                            
                            game.id = gameData.id
                            game.title = gameData.name
                            if let date = gameData.firstReleaseDate {
                                let releaseDate = NSDate(timeIntervalSince1970: TimeInterval(date))
                                
                                
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "MM-dd-yyyy"
                                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                                let formattedDate = dateFormatter.string(from: releaseDate as Date)
                                
                                game.releaseDate = "\(formattedDate)"
                            }
                            
                            var genreArray : [String] = []
                            if let genreData = gameData.genres {
                                for genre in genreData {
                                    
                                    genreArray.append(genre.name!)
                                }
                                game.genres = genreArray
                            }
                            game.genreDescriptions = genreArray.joined(separator: " | ")
                            
                            if let gameModes = gameData.gameModes {
                                var modeArray : [String] = []
                                
                                for mode in gameModes {
                                    modeArray.append(mode.name!)
                                }
                                
                                if modeArray.count > 0 {
                                    game.maxPlayers = modeArray.joined(separator: " | ")
                                } else {
                                    game.maxPlayers = ""
                                }
                                
                            } else {
                                game.maxPlayers = ""
                            }
                            
                            
                            game.overview = gameData.summary
                            
                            if let totalRating = game.totalRating {
                                game.totalRating = Int(totalRating)
                            }
                            
                            if let userRating = game.rating {
                                game.userRating = Int(userRating)
                            }
                            
                            if let ageRatings = gameData.ageRatings {
                                
                                
                                let esrbRatings = ageRatings.filter { $0.category == 1 }
                                let pegiRatings = ageRatings.filter { $0.category == 2 }
                                
                                
                                if esrbRatings.count > 0 {
                                    
                                    let rating = esrbRatings[0].rating!
                                    
                                    game.rating = fetchAgeRatingString(rating: rating)
                                    
                                } else {
                                    if esrbRatings.count == 0 {
                                        if pegiRatings.count > 0 {
                                            let rating = pegiRatings[0].rating!
                                            game.rating = fetchAgeRatingString(rating: rating)
                                        }
                                    }
                                }
                                
                                
                                
                            } else {
                                game.rating = "ESRB NR"
                            }
                            
                            
                            
                            game.screenshots = gameData.screenshots
                            
                            
                            game.youtubePath = gameData.videos?[0].videoID
                            
                            
                            if let platforms = gameData.platforms {
                                for platform in platforms {
                                    if platform.id == platformID {
                                        game.platformID = platformID
                                    }
                                }
                            }
                            
                            
                            if let genres = gameData.genres {
                                for genre in genres {
                                    if let genreName = genre.name {
                                        game.genres?.append(genreName)
                                    }
                                }
                            } else {
                                game.genres?.append("")
                            }
                            
                            
                            if let involvedCompanies = gameData.involvedCompanies {
                                for company in involvedCompanies {
                                    
                                    if company.publisher == true {
                                        game.developer = fetchCompanyName(companyID: company.id!, game: gameData
                                        )
                                    }
                                }
                            }
                            game.boxartInfo = gameData.cover
                            
                            if let imageID = gameData.cover?.imageID {
                                game.boxartFrontImage = imageID + ".jpg"
                            }
                            
                            guard let name = game.title else { return }
                            guard let id = game.id else { return }
                            guard let platformID = game.platformID else { return }
                            game.owned = delegate?.checkForGameInLibrary(name: name, id: id, platformID: platformID)
                            array.append(game)
                            self.tempArray = array
                            
                            
                        }
                        
                        
                        let newData = self.tempArray
                        var oldData = self.recentlyReleasedArray
                        
                        
                        oldData.append(contentsOf: newData)
                        let mergedData = oldData
                        
                        
                        if self.currentOffset < mergedData.count {
                            
                            self.recentlyReleasedArray = mergedData
                            
                        } else {
                            self.recentlyReleasedArray = mergedData
                        }
                        
                    }
                    
                    DispatchQueue.main.async {
                        completed(nil)
                    }
                    
                    
                }
                
                catch {
                    
                    DispatchQueue.main.async {
                        completed(error)
                    }
                }
                
            }
        }.resume()
    }
    
    
    func fetchIGDBComingSoonData(platformID: Int, completed: @escaping (Error?) -> () ) {
        comingSoonArray.removeAll()
        
        
        let today = Int(Calendar(identifier: .gregorian).startOfDay(for: Date()).timeIntervalSince1970)
        
        let todayPlusThirty = Int(Calendar.current.date(byAdding: .month, value: 1, to: Date())!.timeIntervalSince1970)
        
        
        let fields = "fields age_ratings.*, genres.*, name, first_release_date, summary, involved_companies.company.name, involved_companies.publisher, total_rating, total_rating_count, platforms.*, cover.*, platforms.versions.platform_logo.*, platforms.platform_logo.*, screenshots.*, game_modes.name, rating, status, videos.video_id;"
        let filter = " where themes != (42) & status = n & category != (1,2,5,6,7) & platforms = (\(platformID)) & first_release_date > \(today) & first_release_date < \(todayPlusThirty); limit 500; sort first_release_date asc;"
        
        
        
        let httpBodyString = fields + filter
        
        let url = URL(string: "https://30kn8ciec4.execute-api.us-west-2.amazonaws.com/production/v4/games")!
        var requestHeader = URLRequest.init(url: url)
        
        if let key = Data(base64Encoded: Secret.apiKey!, options: []).map( {String(data: $0, encoding: .utf8) }) {
            requestHeader.addValue(key!, forHTTPHeaderField: "X-Api-Key")
        }
        
        requestHeader.httpBody = httpBodyString.data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "POST"
        
        
        URLSession.shared.dataTask(with: requestHeader) { [self] (data, response, error) in

            
            
            if error == nil {
                
                do {
                    
                    var array = [GameObject]()
                    
                    
                    if let decodedGameData = try JSONDecoder().decode(IGDBGames?.self, from: data!) {
                        
                        
                        if decodedGameData.count == 0 {
                            endOfResults = true
                        } else {
                            endOfResults = false
                            
                        }
                        for gameData in decodedGameData {
                            var game = GameObject()
                            
                            game.id = gameData.id
                            game.title = gameData.name
                            if let date = gameData.firstReleaseDate {
                                let releaseDate = NSDate(timeIntervalSince1970: TimeInterval(date))
                                
                                
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "MM-dd-yyyy"
                                dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
                                let formattedDate = dateFormatter.string(from: releaseDate as Date)
                                
                                game.releaseDate = "\(formattedDate)"
                            }
                            
                            var genreArray : [String] = []
                            if let genreData = gameData.genres {
                                for genre in genreData {
                                    
                                    genreArray.append(genre.name!)
                                }
                                game.genres = genreArray
                            }
                            game.genreDescriptions = genreArray.joined(separator: " | ")
                            
                            if let gameModes = gameData.gameModes {
                                var modeArray : [String] = []
                                
                                for mode in gameModes {
                                    modeArray.append(mode.name!)
                                }
                                
                                if modeArray.count > 0 {
                                    game.maxPlayers = modeArray.joined(separator: " | ")
                                } else {
                                    game.maxPlayers = ""
                                }
                                
                            } else {
                                game.maxPlayers = ""
                            }
                            
                            
                            game.overview = gameData.summary
                            
                            if let totalRating = gameData.totalRating {
                                game.totalRating = Int(totalRating)
                            }
                            
                            if let userRating = gameData.rating {
                                game.userRating = Int(userRating)
                            }
                            
                            if let ageRatings = gameData.ageRatings {
                                
                                
                                let esrbRatings = ageRatings.filter { $0.category == 1 }
                                let pegiRatings = ageRatings.filter { $0.category == 2 }
                                
                                
                                if esrbRatings.count > 0 {
                                    
                                    let rating = esrbRatings[0].rating!
                                    
                                    game.rating = fetchAgeRatingString(rating: rating)
                                    
                                } else {
                                    if esrbRatings.count == 0 {
                                        if pegiRatings.count > 0 {
                                            let rating = pegiRatings[0].rating!
                                            game.rating = fetchAgeRatingString(rating: rating)
                                        }
                                    }
                                }
                                
                                
                                
                            } else {
                                game.rating = "ESRB NR"
                            }
                            
                            
                            
                            game.screenshots = gameData.screenshots
                            
                            
                            game.youtubePath = gameData.videos?[0].videoID
                            
                            
                            if let platforms = gameData.platforms {
                                for platform in platforms {
                                    if platform.id == platformID {
                                        game.platformID = platformID
                                    }
                                }
                            }
                            
                            
                            if let genres = gameData.genres {
                                for genre in genres {
                                    if let genreName = genre.name {
                                        game.genres?.append(genreName)
                                    }
                                }
                            } else {
                                game.genres?.append("")
                            }
                            
                            
                            if let involvedCompanies = gameData.involvedCompanies {
                                for company in involvedCompanies {
                                    
                                    if company.publisher == true {
                                        
                                        game.developer = fetchCompanyName(companyID: company.id!, game: gameData
                                        )
                                        
                                    }
                                }
                            }
                            game.boxartInfo = gameData.cover
                            
                            if let imageID = gameData.cover?.imageID {
                                game.boxartFrontImage = imageID + ".jpg"
                            }
                            
                            guard let name = game.title else { return }
                            guard let id = game.id else { return }
                            guard let platformID = game.platformID else { return }
                            game.owned = delegate?.checkForGameInLibrary(name: name, id: id, platformID: platformID)
                            array.append(game)
                            self.tempArray = array
                            
                            
                        }
                        
                        
                        let newData = self.tempArray
                        var oldData = self.comingSoonArray
                        
                        
                        oldData.append(contentsOf: newData)
                        let mergedData = oldData
                        
                        
                        if self.currentOffset < mergedData.count {
                            
                            self.comingSoonArray = mergedData
                            
                            
                            
                        } else {
                            self.comingSoonArray = mergedData
                        }
                        
                    }
                    
                    DispatchQueue.main.async {
                        completed(nil)
                    }
                    
                    
                }
                
                catch {
                    DispatchQueue.main.async {
                        completed(error)
                    }
                }
                
            } else {
                DispatchQueue.main.async {
                    completed(error)
                }            }
        }.resume()
    }
    
    
    
    
    
    func fetchAdvancedSearchData(title: String?, platforms: [Int]?, genres: [Int]?, yearRange: [Int]?, completed: @escaping () -> () ) {
        //method is used in the advanced search controller to allow a user to search and filter by any parameter.
        
        let fields = "fields age_ratings.*, genres.*, name, first_release_date, summary, involved_companies.company.name, involved_companies.publisher, total_rating, platforms.*, cover.*, platforms.versions.platform_logo.*, platforms.platform_logo.*, screenshots.*, game_modes.name, rating, status, videos.video_id, release_dates.*;"
        var parameters = ""
        
        switch(title == "", platforms?.isEmpty, genres?.isEmpty, yearRange?.isEmpty) {
        case (true, true, true, true) :
            return
            
        default:

            parameters = createFilterParameters(title: title!, platforms: platforms!, genres: genres!, yearRange: yearRange!)

            let httpBodyString = fields + parameters
            let url = URL(string: "https://30kn8ciec4.execute-api.us-west-2.amazonaws.com/production/v4/games")!
            var requestHeader = URLRequest.init(url: url)
            if let key = Data(base64Encoded: Secret.apiKey!, options: []).map( {String(data: $0, encoding: .utf8) }) {
                requestHeader.addValue(key!, forHTTPHeaderField: "X-Api-Key")
            }
            requestHeader.httpBody = httpBodyString.data(using: .utf8, allowLossyConversion: false)
            requestHeader.httpMethod = "POST"
            
            URLSession.shared.dataTask(with: requestHeader) { [weak self] (data, response, error) in
                
                do {
                    var array : [GameObject] = []
                    
                    if let decodedGameData = try JSONDecoder().decode(IGDBGames?.self, from: data!) {
                        
                        if platforms?.count == 0 {
                            for gameData in decodedGameData {

                                for platform in gameData.platforms! {

                                    if let date = gameData.releaseDate {

                                        let game =  self?.addGameToArray(gameFromRegion: date, gameData: gameData, platform: platform.id)

                                        array.append(contentsOf: game!)
                                        
                                        
                                        
                                    }
                                    
                                    
                                }
                            }
                        } else {
                            
                            for gameData in decodedGameData {
                                for platform in platforms! {
                                    if let date = gameData.releaseDate {
                                        
                                        let game =  self?.addGameToArray(gameFromRegion: date, gameData: gameData, platform: platform)
                                        array.append(contentsOf: game!)
                                        
                                        
                                        
                                    }
                                    
                                    
                                }
                            }
                            
                        }
                        
                        self?.searchResultsData = array
                        
                        DispatchQueue.main.async {
                            completed()
                        }
                    }
                }
                
                catch {
                    
                    print("error, error = ", error)
                    
                }
                
                
                
                
            }.resume()
            
        }
        
    }
    
    
    
    
    
    func fetchIGDBGamesData(filterBy: String?, platformID: Int?, searchByName: String?, sortByField: String?, sortAscending: Bool?, offset: Int, resultsPerPage: Int?, completed: @escaping (Error?) -> () ) {
        
        if let platform = platformID {
            self.lastRequestedPlatformID = platform
        }
        
        let url = URL(string: "https://30kn8ciec4.execute-api.us-west-2.amazonaws.com/production/v4/games")!
        
        var requestHeader = URLRequest.init(url: url)
        
        let httpBody = createHTTPBody(sortByField: sortByField, sortAscending: sortAscending, filterBy: filterBy, platformID: platformID, searchByName: searchByName, offset: offset, resultsPerPage: resultsPerPage)
        
        
        if let key = Data(base64Encoded: Secret.apiKey!, options: []).map( {String(data: $0, encoding: .utf8) }) {
            requestHeader.addValue(key!, forHTTPHeaderField: "X-Api-Key")
        }
        
        requestHeader.httpBody = httpBody.data(using: .utf8, allowLossyConversion: false)
        
        requestHeader.httpMethod = "POST"
        
        self.currentTask = URLSession.shared.dataTask(with: requestHeader) {  (data, response, error) in
            
            
            do {
                
                if let httpResponse = response as? HTTPURLResponse {
                    if let xCount = httpResponse.allHeaderFields["x-count"] as? String {
                        self.totalRequestCount = Int(xCount)!
                    }
                    
                }
                
                self.gameFetchDidFail = false
                self.gameFetchSuccess = true
                
                if self.platformFetchSuccess == true && self.genreFetchSuccess == true && self.gameFetchSuccess == true {
                    self.initialFetchComplete = true
                    
                }
                
                var array = [GameObject]()
                
                func addGameToArray(gameFromRegion: [ReleaseDate], gameData: IGDBGame, platform: Int) {
                    
                    
                    let game = self.createGameWithPlatformDateFiltered(releaseDates: gameFromRegion, platformID: platform, gameData: gameData)
                    
                    array.append(contentsOf: game)
                    
                }
                
                guard let gameData = data else { return }
                if let decodedGameData = try JSONDecoder().decode(IGDBGames?.self, from: gameData) {
                    
                    if decodedGameData.count < 500 {
                        self.endOfResults = true
                        
                        
                    } else {
                        self.endOfResults = false
                        
                    }
                    
                    self.newDataCount = decodedGameData.count
                    
                    
                    self.tempArray.removeAll()
                    for gameData in decodedGameData {
                        
                        if let date = gameData.releaseDate {
                            if let platform = platformID {
                                //we are only interested in certain reigions with the order of priority being North American, then European, and finally world wide releases.  If the game exists in multiple regions, go with the top priority.
                                
                                
                                
                                addGameToArray(gameFromRegion: date, gameData: gameData, platform: platform)
                                
                                
                                
                            }
                        }
                        
                        self.tempArray = array
                        
                    }
                    
                    let newData = self.tempArray
                    let oldData = self.gameArray
                    
                    
                    self.currentDataCount = self.previousDataCount + self.newDataCount
                    self.previousDataCount = self.currentDataCount
                    
                    var mergedData = oldData
                    mergedData.append(contentsOf: newData)
                    
                    if self.currentOffset < self.currentDataCount {
                        
                        if !self.endOfResults {
                            self.gameArray = mergedData
                            
                        } else {
                            self.gameArray = mergedData
                        }
                        
                        
                    } else {
                        
                        self.gameArray = newData
                    }
                    
                    
                    DispatchQueue.main.async {
                        completed(error)
                    }
                    
                    
                }
                
                
                
            }
            catch {
                self.fetchingMore = false
                print("error= \(error)")
                DispatchQueue.main.async {
                    completed(error)
                }                }
            
            
        }
        currentTask?.resume()
    }
    
    
    
    
    func fetchIGDBGenreData(completed: @escaping (Error?) -> () ) {
        let url = URL(string: "https://30kn8ciec4.execute-api.us-west-2.amazonaws.com/production/v4/genres")!
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpBody = "fields *; limit 500;".data(using: .utf8, allowLossyConversion: false)
        
        
        if let key = Data(base64Encoded: Secret.apiKey!, options: []).map( {String(data: $0, encoding: .utf8) }) {
            requestHeader.addValue(key!, forHTTPHeaderField: "X-Api-Key")
        }
        
        
        requestHeader.httpMethod = "POST"
        URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
            
            
            
            do {
                guard let data = data else {
                    return
                }
                
                
                
                if let decodedGenres = try JSONDecoder().decode(IGDBGenres?.self, from: data) {
                    
                    self.genres = decodedGenres

                }
                self.genreFetchDidFail = false
                self.genreFetchSuccess = true
                if self.platformFetchSuccess == true && self.genreFetchSuccess == true && self.gameFetchSuccess == true {
                    self.initialFetchComplete = true
                    
                }
                DispatchQueue.main.async {
                    completed(nil)
                }
                
            }
            
            catch {
                
                print(error)
                self.genreFetchDidFail = true
                self.genreFetchSuccess = false
                DispatchQueue.main.async {
                    completed(error)
                }
            }
            
            
            
            
        } .resume()
        
    }
    
    
    func fetchIGDBPlatformData(completed: @escaping (Error?) -> () ) {
        
        let url = URL(string: "https://30kn8ciec4.execute-api.us-west-2.amazonaws.com/production/v4/platforms")!
        
        var requestHeader = URLRequest.init(url: url)
        
        requestHeader.httpBody = "fields *; limit 500;".data(using: .utf8, allowLossyConversion: false)
        
        
        if let key = Data(base64Encoded: Secret.apiKey!, options: []).map( {String(data: $0, encoding: .utf8) }) {
            requestHeader.addValue(key!, forHTTPHeaderField: "X-Api-Key")
        }
        
        requestHeader.httpMethod = "POST"
        URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
            
            if error == nil {
                
                do {
                    self.platformFetchSuccess = true
                    self.platformFetchDidFail = false
                    if self.platformFetchSuccess == true && self.genreFetchSuccess == true && self.gameFetchSuccess == true {
                        self.initialFetchComplete = true
                        
                    }
                
                    
                    if let decodedPlatforms = try JSONDecoder().decode(IGDBPlatforms?.self, from: data!) {
                        self.platforms = decodedPlatforms
                        
                        
                        for platform in decodedPlatforms {
                            
                            if platform.category == 1 {
                                
                                self.consolePlatforms.append(platform.name)
                                
                                
                                
                            }
                            
                            if platform.category == 5 {
                                self.portablePlatforms.append(platform.name)
                                
                                
                            }
                            
                            
                            
                        }
                        self.consolePlatforms.sort()
                        self.portablePlatforms.sort()
                        
                        let consolesToRemove = ["1292 Advanced Programmable Video System", "AY-3-8603", "AY-3-8605", "AY-3-8606", "AY-3-8607", "AY-3-8710", "AY-3-8760", "Blu-ray Player", "DVD Player", "Epoch Cassette Vision", "Epoch Super Cassette Vision", "Evercade", "Family Computer (FAMICOM)", "Family Computer Disk System", "Nintendo PlayStation", "Ouya", "PC-50X Family", "Playdia", "Super Famicom", "Tapwave Zodiac"]
                        
                        for console in consolesToRemove {
                            if self.consolePlatforms.contains(console) {
                                
                                
                                self.consolePlatforms.removeAll(where: { $0 == console } )
                                
                            }
                            
                            if self.portablePlatforms.contains(console) {
                                self.portablePlatforms.removeAll(where: { $0 == console })
                            }
                            
                        }
                        
                        
                    }
                    DispatchQueue.main.async {
                        completed(nil)
                    }
                    
                }
                catch {
                    
                    print(error)
                    DispatchQueue.main.async {
                        completed(error)
                    }
                }
            } else {
                self.platformFetchSuccess = false
                self.platformFetchDidFail = true
                DispatchQueue.main.async {
                    completed(error)
                }
            }
            
            
        }.resume()
        
    }
    
    
}
