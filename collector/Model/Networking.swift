//
//  Networking.swift
//  collector
//
//  Created by Brian on 8/4/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation
import UIKit

//var gameData : GameDB?
let apiKey = "\(Constants.gameDBAPIKey)"
//var gameData


protocol NetworkingDelegate: AnyObject {
    func checkForGameInLibrary(name: String, id: Int, platformID: Int) -> Bool
}


class Networking {
    
    var endOfResults = false
    var fetchingMore = false
    var sourceTag = 0
    var list = [GDBGamesPlatform]()
    var gameData = [Game]()
    var gameDataImages : GameDBData?
    var gamesByPlatformID : ByPlatformIDData?
    var gameGenreData : [String: Genre] = [:]
    var gameImages : [GameImages.Inner]?
    var gametestImageData : [Images.Inner]?
    var gameDeveloperData : [String: Developer] = [:]
    var gamePublisherData : [String: Publisher] = [:]
    var gamesData: ByPlatformIDData?
    var games = [GDBGamesPlatform]()
    var gameArray = [GameObject]()
    var boxarts = [String : [ImageData]]()
    var boxartsGameName = [String : [GameData]]()
    var boxart : Boxart?
    var gameNameBoxart : GameNameBoxart?
    var images : [String: [ImageData]] = [:]
//    var games = ByPlatformIDData
    var initialOffset = 0
    var currentOffset = 0
    var gamesArray = [GDBGamesPlatform]()
    var test : ViewController?
//    var genre : GenreData?
    var baseURL : BaseURL?
    var imagesBaseURL : DetailBaseURL?
    var page : Pages?
    var pages : GameNamePages?
    var gameDetailsSS : ScreenScraper?
//    var imageArray : [UIImage?] = []
//    var fullDB = List<GameInformation>()
    var owned : Bool?
    weak var delegate: NetworkingDelegate?
    var tempArray = [GameObject]()
    var image = Image()
//    var platforms : [String: PlatformInfo] = [:]
//    var platformArray = [PlatformInfo]()
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
    
    init() {}
    static let shared = Networking()
    
//    func initialDownload(completed: @escaping () -> () ) {
//        var urlString = "https://cdn.thegamesdb.net/json/database-latest.json"
//        let url = URL(string: urlString)!
//        var requestHeader = URLRequest.init(url: url)
//        requestHeader.httpMethod = "GET"
//        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
//        URLSession.shared.dataTask(with: requestHeader) {
//            (data,response, error) in
//            
//            if error == nil {
//                do {
//                    let json = String(data: data!, encoding: .utf8)
//                    print("\(json)")
//                    
//                    if let jsonDecoded = try JSONDecoder().decode(TheGamesDBData?.self, from: data!) {
//                        
//                        self.fullDB = jsonDecoded.data!.games
////                        self.gameNameBoxart = jsonDecodedByGameName.include?.boxart?.data as! ExtraImages
//                        
//                    }
//                    DispatchQueue.main.async {
//                        completed()
//                    }
//                } catch {
//                    print(error)
//                    
//                }
//            }
//        }.resume()
//    }
    
    func downloadGamesByGameNameJSON(gameNamed: String?, fields: String?, filterByPlatformID: String?, include: String?,pageURL: String?, completed: @escaping () -> () ) {
        var gameName : String?
        var urlString = ""
        
//        guard let gameName = gameNamed?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
//        if let gameName = gameNamed!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            
//            print(fields)
//            print(gameName)
//            print(apiKey)
//            if pageURL == nil {
        if gameNamed != nil {
            gameName = gameNamed
         urlString = "https://api.thegamesdb.net/v1.1/Games/ByGameName?apikey=\(apiKey)&name=\(gameName!)"
        }
        
        if pageURL == nil {
            
        if fields != nil {
            urlString = urlString + "&fields=" + fields!
        }
        if filterByPlatformID != nil {
                urlString = urlString + "&filter%5Bplatform%5D=" + "\(filterByPlatformID!)"
            }
            
        if include != nil {

            urlString = urlString + "&include=" + include!
        }
        }  else {
                urlString = pageURL!
            }
            
        print("urlString = \(urlString)")
        let url = URL(string: urlString)!
            print("\(url)")
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpMethod = "GET"
        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
            URLSession.shared.dataTask(with: requestHeader) { [self]
            (data,response, error) in
            
            if error == nil {
                do {
                    let json = String(data: data!, encoding: .utf8)
                    print("\(String(describing: json))")
                    
                    var array = [GameObject]()
                    
                    if let jsonDecodedByGameName = try JSONDecoder().decode(ByGameName?.self, from: data!) {
                        
                        let decodedByGameName = jsonDecodedByGameName.data?.games
                        let boxartByGameName = jsonDecodedByGameName.include.boxart?.data
                        self.boxartsGameName.merge(boxartByGameName!, uniquingKeysWith:  { (first, _) in first })
                        print(boxartsGameName)
                        for item in decodedByGameName! {
                            
                            var game = GameObject()
                            game.id = item.id
                                game.title = item.gameTitle
                            print("gamename item.releaseDate \(String(describing: item.releaseDate))")
                            if let unformattedDate = item.releaseDate{
                                
                                    game.releaseDate = formatDate(releaseDate: unformattedDate)
                            } else {
                                game.releaseDate = ""
                            }
//                                game.maxPlayers = item.players
                                game.overview = item.overview
                                game.rating = item.rating
                                game.youtubePath = item.youtube
                                game.platformID = item.platform
                                game.genreIDs = item.genres
                                game.developerIDs = item.developers
                                if let developerID = game.developerIDs {
                                    game.developer = self.fetchDeveloperName(developerIDs: developerID)
                                    
                                }
                                
                                if let genreID = game.genreIDs {
                                    game.genres = fetchGenreNames(genreIDs: genreID)
                                    
                                    game.genreDescriptions = fetchGenreNames(genreIDs: genreID).joined(separator: " | ")
                                }
                                
                                guard let name = game.title else { return }
                                guard let id = game.id else { return }
                            guard let platformID = game.platformID else { return }
                              
                                game.boxartFrontImage = fetchFrontBoxart(id: id)
//                                    print("** \(game.boxartFrontImage)")
                            game.boxartResolution = fetchBoxartResolution(id: id)
                                game.boxartRearImage = fetchRearBoxart(id: id)
                            
                            game.owned = delegate?.checkForGameInLibrary(name: name, id: id, platformID: platformID)

                                print(game)
                            array.append(game)
                            self.tempArray = array
                        }
                        
                        gameArray.append(contentsOf: tempArray)
                        pages = jsonDecodedByGameName.pages!
                        
                    }
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print(error)
                    
                }
            }
        }.resume()
//    }
        
}
    
    func downloadGameImageJSON(gameID: Int?, completed: @escaping () -> () ) {
        print("downloadGameImageJSON()")
        
//        var game = GameObject()
//        print("games.count = \(games.count)")
//        if (games.count) > 0 {
//        if (gameData.count) > 0 {
//            print(games[0].id!)
            if let gameData = gameID {
//            if let gameData = gameData[0].id {
                print("gameData = \(gameData)")
                let urlString = "https://api.thegamesdb.net/v1/Games/Images?apikey=\(apiKey)&games_id=\(gameData)&filter%5Btype%5D=fanart%2Cbanner%2Cboxart%2Cscreenshot%2Cclearlogo%2Ctitlescreen"
                let url = URL(string: urlString)
//                &filter%5Btype%5D=%20valfanart%2Cbanner%2Cboxart%2Cscreenshot%2Cclearlogo%2Ctitlescreen"
//                print(url)
//                "https://api.thegamesdb.net/v1/Games/Images?apikey=\(apiKey)&games_id=\(gameData)&filter%5Btype%5D=clearlogo%20%2C%20fanart")!
                var requestHeader = URLRequest.init(url: url!)
                requestHeader.httpMethod = "GET"
                requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
            
                URLSession.shared.dataTask(with: requestHeader) { [self] (data, response, error) in
                    print("url session")
                
                    
                    if error == nil {
                        do {
                            let json = String(data:data!, encoding: .utf8)
                            print("\(String(describing: json))")
                            print("gameData = \(gameData)")
//                             self.gameDataImages
                            if let jsonDecodedGameImages = try JSONDecoder().decode(GameDBData?.self, from: data!) {
//                                self.gameImages = jsonDecodedGameImages.data?.images.innerArray["\(gameData)"] as [GameImages.Inner]
                                self.gametestImageData = jsonDecodedGameImages.data?.images.innerArray["\(gameData)"]
//                                print(gametestImageData)
//                                for item in gametestImageData! {
//                                var image = Image()
//                                    image.fileName = item.fileName
//                                    image.id = item.id
//                                    image.type = item.type
//                                }
                                
                                
//                                self.imagesBaseURL = jsonDecodedGameImages.data?.baseURL
                             
                                image.clearLogo = self.getImageFileName(imageType: "clearlogo", imageData: self.gametestImageData!)
                                image.banner = self.getImageFileName(imageType: "banner", imageData: self.gametestImageData!)
                                image.fanart = self.getImageFileName(imageType: "fanart", imageData: self.gametestImageData!)
                                image.screenshot = self.getImageFileName(imageType: "screenshot", imageData: self.gametestImageData!)
                                image.screenshotArray = self.fetchAddtionalImageArrays(imageType: "screenshot", imageData: self.gametestImageData!)
                                image.boxartArray = self.fetchAddtionalImageArrays(imageType: "boxart", imageData: self.gametestImageData!)
                                image.fanartArray = self.fetchAddtionalImageArrays(imageType: "fanart", imageData: self.gametestImageData!)
                                image.bannerArray = self.fetchAddtionalImageArrays(imageType: "banner", imageData: self.gametestImageData!)
                                image.clearLogoArray = self.fetchAddtionalImageArrays(imageType: "clearlogo", imageData: self.gametestImageData!)
                                image.titleScreenArray = self.fetchAddtionalImageArrays(imageType: "titlescreen", imageData: self.gametestImageData!)
                                
                                print(image)
                                print("inside downloadGameImageJSON-gameImageData = \(String(describing: self.gameImages))")
                                print("gametestImageData \(String(describing: self.gametestImageData))")
                               
                            }
                            
                            
                            DispatchQueue.main.async {
                                completed()
                            }
                            
                        } catch {
                        print(error)
                            
                     
                        }
                    
                                                
                    }
                
                }.resume()
            }
            
        
    }
    
//    func downloadGenreJSON(completed: @escaping () -> () ) {
//        var url = URL(string: "https://api.thegamesdb.net/v1/Genres?apikey=\(apiKey)")!
//        var requestHeader = URLRequest.init(url: url)
//        requestHeader.httpMethod = "GET"
//        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
//        URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
//            
//            if error == nil {
//                
//                
//                do {
//                    let json = String(data:data!, encoding: .utf8)
//                    print("\(json)")
//                    
////                    self.gameGenreData
//                    if let jsonDecodedGenre = try JSONDecoder().decode(GenreData?.self, from: data!){
//                        
//                        self.gameGenreData = jsonDecodedGenre.data.genres
//                        self.genre = jsonDecodedGenre
//                    }
//                    DispatchQueue.main.async {
//                        
//                        completed()
//                    }
//                
//                } catch {
//                    print(error)
//                }
//            }
//        }.resume()
//    }
    func fetchIGDBTop20Data(platformID: Int, completed: @escaping () -> () ) {
        topTwentyArray.removeAll()
//        let date = NSDate()
//        let today = Int(date.timeIntervalSince1970)
        
//        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
//        calendarDate.timeZone = TimeZone(abbreviation: "GMT")
//        let currentDate = Calendar.current.date(from: dateComponents)
//        print(currentDate)
        
//        let today = Int(currentDate!.timeIntervalSince1970)
        
        let today = Int(Calendar(identifier: .gregorian).startOfDay(for: Date()).timeIntervalSince1970)
        
        let todayMinusThirty = Int(Calendar.current.date(byAdding: .month, value: -1, to: Date())!.timeIntervalSince1970)
//        let todayPlusThirty = Int(datePlusThirty!.timeIntervalSince1970)
        print("top20")
        print(today, todayMinusThirty)
        
        let fields = "fields age_ratings.*, genres.*, name, first_release_date, summary, involved_companies.company.name, involved_companies.publisher, total_rating, total_rating_count, platforms.*, cover.*, platforms.versions.platform_logo.*, platforms.platform_logo.*, screenshots.*, game_modes.name, rating, status, videos.video_id;"
        let filter = " where themes != (42) & status = n & total_rating != n & total_rating_count > 5 &category != (1,2,5,6,7) & platforms = (\(platformID)) & platforms != (19); limit 20; sort total_rating desc;"
        
        
        
        let httpBodyString = fields + filter
        print("coming soon", httpBodyString)
        let url = URL(string: "https://30kn8ciec4.execute-api.us-west-2.amazonaws.com/production/v4/games")!
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpBody = httpBodyString.data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "POST"
            
            
        URLSession.shared.dataTask(with: requestHeader) { [self] (data, response, error) in
            
            if error == nil {
                
                do {
                    
                    
//                    let json = String(data:data!, encoding: .utf8)
//                    print(json)
                    
                    var array = [GameObject]()
                        
                    
                    if let decodedGameData = try JSONDecoder().decode(IGDBGames?.self, from: data!) {
                            
                        
                        if decodedGameData.count == 0 {
                            endOfResults = true
                            print("endofresults = \(endOfResults)")
                        } else {
                            endOfResults = false
                            print("endofresults = \(endOfResults)")

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
                                print("release date \(formattedDate)")
                                game.releaseDate = "\(formattedDate)"
                            }
                            
                            var genreArray : [String] = []
                            if let genreData = gameData.genres {
                            for genre in genreData {
                                print("genre.name \(String(describing: genre.name))")
                                
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
                                
//                                print("\(gameData.name!) esrbRating.count = \(esrbRatings.count) esrb.rating = \(esrbRatings[0].rating)")
                                if esrbRatings.count > 0 {
                                    
                                    let rating = esrbRatings[0].rating!
                                    print(esrbRatings)
                                    game.rating = fetchAgeRatingString(rating: rating)
                                    print("game rating in esrb rating count: \(String(describing: game.rating))")
                                } else {
                                    if esrbRatings.count == 0 {
                                    if pegiRatings.count > 0 {
                                    let rating = pegiRatings[0].rating!
                                    game.rating = fetchAgeRatingString(rating: rating)
                                    }
                                    }
                                }
                                
                                
                                print("game rating is: \(String(describing: game.rating))")
                                
                    
                            } else {
                                game.rating = "ESRB NR"
                            }

                            
                            
                            game.screenshots = gameData.screenshots
//                            var screenshotArray : [String] = []
//
//                            if let screenshotData = gameData.screenshots {
//                                for screenshot in screenshotData {
//                                    let screenshotURL = screenshot.imageID! + ".jpg"
//                                    screenshotArray.append(screenshotURL)
//                            }
//                            game.screenshots = screenshotArray
//                            }

                            
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
                                    print("companydata \(company) company.id \(String(describing: company.id))")
                                    game.developer = fetchCompanyName(companyID: company.id!, game: gameData
                                    )
                                    print("game.developer \(String(describing: game.developer))")
                                }
                            }
                            }
                            game.boxartInfo = gameData.cover
                            
                            if let imageID = gameData.cover?.imageID {
                                game.boxartFrontImage = imageID + ".jpg"
                            }
//                            game.boxartFrontImage = (gameData.cover?.imageID)! + ".jpg"
                            guard let name = game.title else { return }
                            guard let id = game.id else { return }
                            guard let platformID = game.platformID else { return }
                            game.owned = delegate?.checkForGameInLibrary(name: name, id: id, platformID: platformID)
                            array.append(game)
                            self.tempArray = array
                        print("platforms downloaded")

                    }
                        
                        
                        let newData = self.tempArray
                        var oldData = self.topTwentyArray
                        
                        
                        oldData.append(contentsOf: newData)
                        let mergedData = oldData
                        print("currentOffset before = \(currentOffset)")
                        print("mergeddata count is \(mergedData.count)")
                        //think this is the one to work with**
                        if self.currentOffset < mergedData.count {
                            
                            self.topTwentyArray = mergedData
                            print("recently released count \(topTwentyArray.count)")
//                            currentOffset = mergedData.count
               

                        } else {
                            self.topTwentyArray = mergedData
                        }
                    
                    }
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                    
                    
                }
                
                catch {
                    print(error)
                }
                
            }
        }.resume()
    }
    
    
    func fetchIGDBRecentlyReleasedData(platformID: Int, completed: @escaping () -> () ) {
        recentlyReleasedArray.removeAll()
//        let date = NSDate()
//        let today = Int(date.timeIntervalSince1970)
        
//        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
//        calendarDate.timeZone = TimeZone(abbreviation: "GMT")
//        let currentDate = Calendar.current.date(from: dateComponents)
//        print(currentDate)
        
//        let today = Int(currentDate!.timeIntervalSince1970)
        
        let today = Int(Calendar(identifier: .gregorian).startOfDay(for: Date()).timeIntervalSince1970)
        
        let todayMinusThirty = Int(Calendar.current.date(byAdding: .month, value: -1, to: Date())!.timeIntervalSince1970)
//        let todayPlusThirty = Int(datePlusThirty!.timeIntervalSince1970)
        print("recently released")
        print(today, todayMinusThirty)
        
        let fields = "fields age_ratings.*, genres.*, name, first_release_date, summary, involved_companies.company.name, involved_companies.publisher, total_rating, total_rating_count, platforms.*, cover.*, platforms.versions.platform_logo.*, platforms.platform_logo.*, screenshots.*, game_modes.name, rating, status, videos.video_id;"
        let filter = " where themes != (42) & status = n & category != (1,2,5,6,7) & platforms = (\(platformID)) & first_release_date > \(todayMinusThirty) & first_release_date <= \(today); limit 500; sort first_release_date desc;"
        
        
        
        let httpBodyString = fields + filter
        print("recently released", httpBodyString)
        let url = URL(string: "https://30kn8ciec4.execute-api.us-west-2.amazonaws.com/production/v4/games")!
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpBody = httpBodyString.data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "POST"
            
            
        URLSession.shared.dataTask(with: requestHeader) { [self] (data, response, error) in
            
            if error == nil {
                
                do {
                    
                    
//                    let json = String(data:data!, encoding: .utf8)
//                    print(json)
                    
                    var array = [GameObject]()
                        
                    
                    if let decodedGameData = try JSONDecoder().decode(IGDBGames?.self, from: data!) {
                            
                        
                        if decodedGameData.count == 0 {
                            endOfResults = true
                            print("endofresults = \(endOfResults)")
                        } else {
                            endOfResults = false
                            print("endofresults = \(endOfResults)")

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
                                print("release date \(formattedDate)")
                                game.releaseDate = "\(formattedDate)"
                            }
                            
                            var genreArray : [String] = []
                            if let genreData = gameData.genres {
                            for genre in genreData {
//                                print("genre.name \(genre.name)")
                                
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
                                
//                                print("\(gameData.name!) esrbRating.count = \(esrbRatings.count) esrb.rating = \(esrbRatings[0].rating)")
                                if esrbRatings.count > 0 {
                                    
                                    let rating = esrbRatings[0].rating!
                                    print(esrbRatings)
                                    game.rating = fetchAgeRatingString(rating: rating)
//                                    print("game rating in esrb rating count: \(game.rating)")
                                } else {
                                    if esrbRatings.count == 0 {
                                    if pegiRatings.count > 0 {
                                    let rating = pegiRatings[0].rating!
                                    game.rating = fetchAgeRatingString(rating: rating)
                                    }
                                    }
                                }
                                
                                
//                                print("game rating is: \(game.rating)")
                                
                    
                            } else {
                                game.rating = "ESRB NR"
                            }

                            
                            
                            game.screenshots = gameData.screenshots
//                            var screenshotArray : [String] = []
//
//                            if let screenshotData = gameData.screenshots {
//                                for screenshot in screenshotData {
//                                    let screenshotURL = screenshot.imageID! + ".jpg"
//                                    screenshotArray.append(screenshotURL)
//                            }
//                            game.screenshots = screenshotArray
//                            }

                            
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
//                                    print("companydata \(company) company.id \(company.id)")
                                    game.developer = fetchCompanyName(companyID: company.id!, game: gameData
                                    )
//                                    print("game.developer \(game.developer)")
                                }
                            }
                            }
                            game.boxartInfo = gameData.cover
                            
                            if let imageID = gameData.cover?.imageID {
                                game.boxartFrontImage = imageID + ".jpg"
                            }
//                            game.boxartFrontImage = (gameData.cover?.imageID)! + ".jpg"
                            guard let name = game.title else { return }
                            guard let id = game.id else { return }
                            guard let platformID = game.platformID else { return }
                            game.owned = delegate?.checkForGameInLibrary(name: name, id: id, platformID: platformID)
                            array.append(game)
                            self.tempArray = array
                        print("platforms downloaded")

                    }
                        
                        
                        let newData = self.tempArray
                        var oldData = self.recentlyReleasedArray
                        
                        
                        oldData.append(contentsOf: newData)
                        let mergedData = oldData
                        print("currentOffset before = \(currentOffset)")
                        print("mergeddata count is \(mergedData.count)")
                        //think this is the one to work with**
                        if self.currentOffset < mergedData.count {
                            
                            self.recentlyReleasedArray = mergedData
                            print("recently released count \(recentlyReleasedArray.count)")
//                            currentOffset = mergedData.count
               

                        } else {
                            self.recentlyReleasedArray = mergedData
                        }
                    
                    }
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                    
                    
                }
                
                catch {
                    print(error)
                }
                
            }
        }.resume()
    }
    
    
    func fetchIGDBComingSoonData(platformID: Int, completed: @escaping () -> () ) {
        comingSoonArray.removeAll()
//        let date = NSDate()
//        let today = Int(date.timeIntervalSince1970)
        
//        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
//        calendarDate.timeZone = TimeZone(abbreviation: "GMT")
//        let currentDate = Calendar.current.date(from: dateComponents)
//        print(currentDate)
        
//        let today = Int(currentDate!.timeIntervalSince1970)
        
        let today = Int(Calendar(identifier: .gregorian).startOfDay(for: Date()).timeIntervalSince1970)
        
        let todayPlusThirty = Int(Calendar.current.date(byAdding: .month, value: 1, to: Date())!.timeIntervalSince1970)
//        let todayPlusThirty = Int(datePlusThirty!.timeIntervalSince1970)

        print(today, todayPlusThirty)
        
        let fields = "fields age_ratings.*, genres.*, name, first_release_date, summary, involved_companies.company.name, involved_companies.publisher, total_rating, total_rating_count, platforms.*, cover.*, platforms.versions.platform_logo.*, platforms.platform_logo.*, screenshots.*, game_modes.name, rating, status, videos.video_id;"
        let filter = " where themes != (42) & status = n & category != (1,2,5,6,7) & platforms = (\(platformID)) & first_release_date > \(today) & first_release_date < \(todayPlusThirty); limit 500; sort first_release_date asc;"
        
        
        
        let httpBodyString = fields + filter
        print("coming soon", httpBodyString)
        let url = URL(string: "https://30kn8ciec4.execute-api.us-west-2.amazonaws.com/production/v4/games")!
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpBody = httpBodyString.data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "POST"
            
            
        URLSession.shared.dataTask(with: requestHeader) { [self] (data, response, error) in
            
            if error == nil {
                
                do {
                    
                    
//                    let json = String(data:data!, encoding: .utf8)
//                    print(json)
                    
                    var array = [GameObject]()
                        
                    
                    if let decodedGameData = try JSONDecoder().decode(IGDBGames?.self, from: data!) {
                            
                        
                        if decodedGameData.count == 0 {
                            endOfResults = true
                            print("endofresults = \(endOfResults)")
                        } else {
                            endOfResults = false
                            print("endofresults = \(endOfResults)")

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
                                print("release date \(formattedDate)")
                                game.releaseDate = "\(formattedDate)"
                            }
                            
                            var genreArray : [String] = []
                            if let genreData = gameData.genres {
                            for genre in genreData {
//                                print("genre.name \(genre.name)")
                                
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
                                
//                                print("\(gameData.name!) esrbRating.count = \(esrbRatings.count) esrb.rating = \(esrbRatings[0].rating)")
                                if esrbRatings.count > 0 {
                                    
                                    let rating = esrbRatings[0].rating!
                                    print(esrbRatings)
                                    game.rating = fetchAgeRatingString(rating: rating)
//                                    print("game rating in esrb rating count: \(game.rating)")
                                } else {
                                    if esrbRatings.count == 0 {
                                    if pegiRatings.count > 0 {
                                    let rating = pegiRatings[0].rating!
                                    game.rating = fetchAgeRatingString(rating: rating)
                                    }
                                    }
                                }
                                
                                
//                                print("game rating is: \(game.rating)")
                                
                    
                            } else {
                                game.rating = "ESRB NR"
                            }

                            
                            
                            game.screenshots = gameData.screenshots
//                            var screenshotArray : [String] = []
//
//                            if let screenshotData = gameData.screenshots {
//                                for screenshot in screenshotData {
//                                    let screenshotURL = screenshot.imageID! + ".jpg"
//                                    screenshotArray.append(screenshotURL)
//                            }
//                            game.screenshots = screenshotArray
//                            }

                            
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
//                                    print("companydata \(company) company.id \(company.id)")
                                    game.developer = fetchCompanyName(companyID: company.id!, game: gameData
                                    )
//                                    print("game.developer \(game.developer)")
                                }
                            }
                            }
                            game.boxartInfo = gameData.cover
                            
                            if let imageID = gameData.cover?.imageID {
                                game.boxartFrontImage = imageID + ".jpg"
                            }
//                            game.boxartFrontImage = (gameData.cover?.imageID)! + ".jpg"
                            guard let name = game.title else { return }
                            guard let id = game.id else { return }
                            guard let platformID = game.platformID else { return }
                            game.owned = delegate?.checkForGameInLibrary(name: name, id: id, platformID: platformID)
                            array.append(game)
                            self.tempArray = array
                        print("platforms downloaded")

                    }
                        
                        
                        let newData = self.tempArray
                        var oldData = self.comingSoonArray
                        
                        
                        oldData.append(contentsOf: newData)
                        let mergedData = oldData
                        print("currentOffset before = \(currentOffset)")
                        print("mergeddata count is \(mergedData.count)")
                        //think this is the one to work with**
                        if self.currentOffset < mergedData.count {
                            
                            self.comingSoonArray = mergedData
                            print("gamearray count \(comingSoonArray.count)")
//                            currentOffset = mergedData.count
               

                        } else {
                            self.comingSoonArray = mergedData
                        }
                    
                    }
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                    
                    
                }
                
                catch {
                    print(error)
                }
                
            }
        }.resume()
    }
    
    func fetchIGDBGamesData(filterBy: String?, platformID: Int?, searchByName: String?, sortByField: String?, sortAscending: Bool?, offset: Int, resultsPerPage: Int?, completed: @escaping () -> () ) {
        
        
        var sortDirection = "asc"
        var sort : String?
        var filter : String?
        
        if let sortField = sortByField {
            if let sortAsc = sortAscending {
                
        switch sortAsc {
        
        case true:
            sortDirection = "asc"
        case false:
            sortDirection = "dsc"
            
        }
            
            sort = " sort" + " \(sortField)" + " \(sortDirection);"
        }
            
        }
        
        if let filterParameters = filterBy {
            if let platformID = platformID {
                if let searchName = searchByName {
            filter = " where themes != (42) & status = n & category != (1,2,5,6,7) & \(filterParameters)(\(platformID)) & name ~ *\"\(searchName)\"*; sort name asc;"
                } else {
                    filter = " where themes != (42) & status = n & category != (1,2,5,6,7) & \(filterParameters)(\(platformID)); sort name asc;"
                }
            } else {
                if let searchName = searchByName {
                filter = " where themes != (42) & status = n & category != (1,2,5,6,7) & \(filterParameters) & name ~ *\"\(searchName)\"*; sort name asc;"
                } else {
                    
                    filter = " where themes != (42) & status = n & category != (1,2,5,6,7) & \(filterParameters); sort name asc;"
                    
                }
            }
        }
        
        let fields = "fields age_ratings.*, genres.*, name, first_release_date, summary, involved_companies.company.name, involved_companies.publisher, total_rating, platforms.*, cover.*, platforms.versions.platform_logo.*, platforms.platform_logo.*, screenshots.*, game_modes.name, rating, status, videos.video_id;"

        
        
        let url = URL(string: "https://30kn8ciec4.execute-api.us-west-2.amazonaws.com/production/v4/games")!
        var requestHeader = URLRequest.init(url: url)
        var httpBodyString = fields + " offset \(offset);"
        
        if let limit = resultsPerPage {
            httpBodyString += " limit \(limit);"
        }
        
        if let sortFields = sort {
            httpBodyString += sortFields
        }
        if let filterData = filter {
            httpBodyString += filterData
        }
        
//        if let searchName = searchByName {
//            httpBodyString += " search \"\(searchName)\";"
//        }
        
        
//        if offset > 0 {
//            httpBodyString += " offset \(offset);"
//        }
        print("httpbodystring \(httpBodyString)")
        requestHeader.httpBody = httpBodyString.data(using: .utf8, allowLossyConversion: false)
//        requestHeader.httpBody = "fields age_ratings.rating, age_ratings.rating, genres.*, name, first_release_date, summary, involved_companies.company.name, involved_companies.publisher, total_rating, platforms.*, cover.*, platforms.versions.platform_logo.*, platforms.platform_logo.*, screenshots.*, game_modes.name, rating, videos.video_id; sort name \(sortDirection); where platforms = \(platformID); limit 100;".data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "POST"
            
            
        URLSession.shared.dataTask(with: requestHeader) { [self] (data, response, error) in
            
            if error == nil {
                
                do {
                    
                    
//                    let json = String(data:data!, encoding: .utf8)
//                    print(json)
                    
                    var array = [GameObject]()
                        
                    
                    if let decodedGameData = try JSONDecoder().decode(IGDBGames?.self, from: data!) {
                            
                        
                        if decodedGameData.count == 0 {
                            endOfResults = true
                            print("endofresults = \(endOfResults)")
                        } else {
                            endOfResults = false
                            print("endofresults = \(endOfResults)")

                        }
                        for gameData in decodedGameData {
                            var game = GameObject()
                            
                            game.id = gameData.id
                            game.title = gameData.name
                            if let date = gameData.firstReleaseDate {
                                let releaseDate = NSDate(timeIntervalSince1970: TimeInterval(date))
                                
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "MM-dd-yyyy"
                                let formattedDate = dateFormatter.string(from: releaseDate as Date)
                                print("release date \(formattedDate)")
                                game.releaseDate = "\(formattedDate)"
                            }
                            
                            var genreArray : [String] = []
                            if let genreData = gameData.genres {
                            for genre in genreData {
//                                print("genre.name \(genre.name)")
                                
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
                                
//                                print("\(gameData.name!) esrbRating.count = \(esrbRatings.count) esrb.rating = \(esrbRatings[0].rating)")
                                if esrbRatings.count > 0 {
                                    
                                    let rating = esrbRatings[0].rating!
                                    print(esrbRatings)
                                    game.rating = fetchAgeRatingString(rating: rating)
//                                    print("game rating in esrb rating count: \(game.rating)")
                                } else {
                                    if esrbRatings.count == 0 {
                                    if pegiRatings.count > 0 {
                                    let rating = pegiRatings[0].rating!
                                    game.rating = fetchAgeRatingString(rating: rating)
                                    }
                                    }
                                }
                                
                                
//                                print("game rating is: \(game.rating)")
                                
                    
                            } else {
                                game.rating = "ESRB NR"
                            }

                            
                            
                            game.screenshots = gameData.screenshots
//                            var screenshotArray : [String] = []
//
//                            if let screenshotData = gameData.screenshots {
//                                for screenshot in screenshotData {
//                                    let screenshotURL = screenshot.imageID! + ".jpg"
//                                    screenshotArray.append(screenshotURL)
//                            }
//                            game.screenshots = screenshotArray
//                            }

                            
                            game.youtubePath = gameData.videos?[0].videoID
                            
                            if let platformID = platformID {
                                if let platforms = gameData.platforms {
                            for platform in platforms {
                                if platform.id == platformID {
                                    game.platformID = platformID
                                }
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
//                                    print("companydata \(company) company.id \(company.id)")
                                    game.developer = fetchCompanyName(companyID: company.id!, game: gameData
                                    )
//                                    print("game.developer \(game.developer)")
                                }
                            }
                            }
                            game.boxartInfo = gameData.cover
                            game.boxartHeight = gameData.cover?.height
                            game.boxartWidth = gameData.cover?.width
                            
                            if let imageID = gameData.cover?.imageID {
                                game.boxartFrontImage = imageID + ".jpg"
                            }
//                            game.boxartFrontImage = (gameData.cover?.imageID)! + ".jpg"
                            guard let name = game.title else { return }
                            guard let id = game.id else { return }
                            guard let platformID = game.platformID else { return }
                            game.owned = delegate?.checkForGameInLibrary(name: name, id: id, platformID: platformID)
                            array.append(game)
                            self.tempArray = array
                        print("platforms downloaded")

                    }
                        
                        
                        let newData = self.tempArray
                        var oldData = self.gameArray
                        
                        
                        oldData.append(contentsOf: newData)
                        let mergedData = oldData
                        print("currentOffset before = \(currentOffset)")
                        print("mergeddata count is \(mergedData.count)")
                        //think this is the one to work with**
                        if self.currentOffset < mergedData.count {
                            
                            self.gameArray = mergedData
                            print("gamearray count \(gameArray.count)")
//                            currentOffset = mergedData.count
               

                        } else {
                            self.gameArray = mergedData
                        }
                        //**
                        
                      
                        
                        
                    
                    
                        
                        
                    
                        
                    DispatchQueue.main.async {
                        completed()
                    }
                    
                    
                    }
                    
                    
                    
                }
                catch {
                    self.fetchingMore = false
                    print("fetching more error \(fetchingMore)")
                    print("error= \(error)")
                }
                
            
            
            } else {
                print("Error fetching data: \(String(describing: error))")
                self.fetchingMore = false
            }
            
            
        }.resume()
        
    }
    
    func fetchIGDBGenreData(completed: @escaping () -> () ) {
        let url = URL(string: "https://30kn8ciec4.execute-api.us-west-2.amazonaws.com/production/v4/platforms")!
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpBody = "fields *; limit 500;".data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "POST"
        URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
            
            if error == nil {
                
                do {
                    
//                    let json = String(data:data!, encoding: .utf8)
//                    print(json)
                    if let decodedGenres = try JSONDecoder().decode(IGDBGenres?.self, from: data!) {
                      
                        self.genres = decodedGenres
                        
                    }
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                    
                }
                
                catch {
                    print(error)
                }
                
            }
        
        } .resume()
        
    }
    
    func fetchIGDBPlatformData(completed: @escaping () -> () ) {
        
        let url = URL(string: "https://30kn8ciec4.execute-api.us-west-2.amazonaws.com/production/v4/platforms")!
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpBody = "fields *; limit 500;".data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "POST"
        URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
            
            if error == nil {
                
                do {
//                    let json = String(data:data!, encoding: .utf8)
//                    print(json)
                    if let decodedPlatforms = try JSONDecoder().decode(IGDBPlatforms?.self, from: data!) {
                        self.platforms = decodedPlatforms
                        
                        print("Platform Information:")
                        for platform in decodedPlatforms {
                            
                            if platform.category == 1 {
                                
                                self.consolePlatforms.append(platform.name)
                                
                                print("IGDB CONSOLE PLATFORMS", platform.name, platform.id)
                            }
                            
                            if platform.category == 5 {
                                self.portablePlatforms.append(platform.name)
                                
                                print("IGDB PORTABLE PLATOFORMS", platform.name, platform.id)
                            }
                            
                            
                            
                        }
                        self.consolePlatforms.sort()
                        self.portablePlatforms.sort()
                        
                        let consolesToRemove = ["1292 Advanced Programmable Video System", "AY-3-8603", "AY-3-8605", "AY-3-8606", "AY-3-8607", "AY-3-8710", "AY-3-8760", "Blu-ray Player", "DVD Player", "Epoch Cassette Vision", "Epoch Super Cassette Vision", "Evercade", "Family Computer (FAMICOM)", "Family Computer Disk System", "Nintendo PlayStation", "Ouya", "PC-50X Family", "Playdia", "Super Famicom", "Tapwave Zodiac"]
                        print(self.consolePlatforms)
                        for console in consolesToRemove {
                            if self.consolePlatforms.contains(console) {
                                
                                
                                self.consolePlatforms.removeAll(where: { $0 == console } )
                                
                            }
                            
                            if self.portablePlatforms.contains(console) {
                                self.portablePlatforms.removeAll(where: { $0 == console })
                            }
                            
                        }
                        
                        print(self.consolePlatforms)
                        print(self.portablePlatforms)
                        print("platforms downloaded")

                    }
                    DispatchQueue.main.async {
                        completed()
                    }
                
                }
                catch {
                    
                    print(error)
                }
            }
            
            
        }.resume()

    }
    
    
//    func downloadPlatformJSON(completed: @escaping () -> () ) {
//        var url = URL(string: "https://api.thegamesdb.net/v1/Platforms?apikey=\(apiKey)&fields=icon%2Cconsole%2Ccontroller%2Cdeveloper%2Cmanufacturer%2Cmedia%2Ccpu%2Cmemory%2Cgraphics%2Csound%2Cmaxcontrollers%2Cdisplay%2Coverview%2Cyoutube")!
//        var requestHeader = URLRequest.init(url: url)
//        requestHeader.httpMethod = "GET"
//        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
//        URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
//            
//            if error == nil {
//                
//                
//                do {
////                    let json = String(data:data!, encoding: .utf8)
////                    print("\(json)")
//                    
////                    self.gameGenreData
//                    if let decodedPlatforms = try JSONDecoder().decode(Platforms?.self, from: data!){
//                        
//                       
//                        self.platforms = decodedPlatforms.data.platforms
////                        for platform in self.platforms {
////                            self.platformArray.append(platform.value)
////                        }
////                        print("platformArray \(self.platformArray)")
////                        let sortedArray = self.platformArray.sorted(by: ( {$0["name"]! < $1["name"]!}))
//                        
////                        let sorted = self.platformArray.sort(by: { (firstObject, secondObject) in
////                            return firstObject.name > secondObject.name
////
////
////
////                        })
//                        
//                        
////                        let sort = self.platformArray.sorted(by: { (first, second) in
////                            return first.name.lowercased() < second.name.lowercased()
////                            
////                        })
////                        let sort = self.platformArray.sorted(by: { $0.name.lowercased() < $1.name.lowercased()})
//                        
////                        print("sorted \(sort)")
//                        print("platforms downloaded")
//
////                        let sortedArray = (self.platformArray as NSArray).sortedArray(using: [NSSortDescriptor(key: "name", ascending: true)]) as! [[String:AnyObject]]
////                        print("sortedArray \(sortedArray)")
//
//                    }
//                    DispatchQueue.main.async {
//                        
//                        completed()
//                    }
//                
//                } catch {
//                    print(error)
//                }
//            }
//        }.resume()
//    }
    
     func downloadDevelopersJSON(completed: @escaping () -> () ) {
        let url = URL(string: "https://api.thegamesdb.net/v1/Developers?apikey=\(apiKey)")!
            var requestHeader = URLRequest.init(url: url)
            requestHeader.httpMethod = "GET"
            requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
            URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
                
                if error == nil {
                    
                    
                    do {
//                        let json = String(data:data!, encoding: .utf8)
//                        print("\(json)")
                        
    //                    self.gameGenreData
                        if let jsonDecodedGenre = try JSONDecoder().decode(DeveloperData?.self, from: data!){
                            
                            self.gameDeveloperData = jsonDecodedGenre.data.developers
                            
                        }
                        DispatchQueue.main.async {
                            
                            completed()
                        }
                    
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    
    
     func downloadPublishersJSON(completed: @escaping () -> () ) {
        let url = URL(string: "https://api.thegamesdb.net/v1/Developers?apikey=\(apiKey)")!
            var requestHeader = URLRequest.init(url: url)
            requestHeader.httpMethod = "GET"
            requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
            URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
                
                if error == nil {
                    
                    
                    do {
//                        let json = String(data:data!, encoding: .utf8)
//                        print("\(json)")
                        
    //                    self.gameGenreData
                        if let jsonDecodedGenre = try JSONDecoder().decode(PublisherData?.self, from: data!){
                            
                            self.gamePublisherData = jsonDecodedGenre.data.publishers
                            
                        }
                        DispatchQueue.main.async {
                            
                            completed()
                        }
                    
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    
    
    
    func downloadGamesByPlatformIDJSON(platformID: Int?, fields: String?, include: String?, pageURL: String?, completed: @escaping () -> () ) {
        var urlString : String?
        
        if pageURL == nil {
            urlString = "https://api.thegamesdb.net/v1/Games/ByPlatformID?apikey=\(apiKey)&id=\(platformID!)"
            
            if fields != nil {
                urlString = urlString! + "&fields=" + fields!
            }
            if include != nil {
                
                urlString = urlString! + "&include=" + include!
            }
            
        } else {
            urlString = pageURL!
        }
        print(urlString!)
        let url = URL(string: "\(urlString!)")!
        print(url)
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpMethod = "GET"
        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        URLSession.shared.dataTask(with: requestHeader) { [self] (data, response, error) in
            
            if error != nil {
                print("error = \(String(describing: error))")
                completed()
            }
            
            if error == nil {
                do {
                    print("error = nil")
//                    let json = String(data: data!, encoding: .utf8)
                    
//                    print(json)
                    var array = [GameObject]()
                    
//                    var game = GDBGamesPlatform()
                    
                    
                   
                    
//                    print("response \(response)")
                    
                    
//                    for (k, arrayOfValues) in dict where k == gamesdb {
//
//                    }
                    
                    if let jsonDecodedPlatforms = try JSONDecoder().decode(ByPlatformIDData?.self, from: data!) {
                        
                        print(jsonDecodedPlatforms)
                        
                    
//                        self.gameData = jsonDecodedByGameName.data?.games as! [Game]

                        let decodedJSON = jsonDecodedPlatforms.data!.games as [GDBGamesPlatform]
                        
//                        let decodedBoxart = jsonDecodedPlatforms.include.boxart.data
                        print("decoded JSON = \(decodedJSON)")
                        let decodedBoxart = jsonDecodedPlatforms.include.boxart.data
                        print ("test A \(decodedBoxart)")
                        self.boxarts.merge(decodedBoxart, uniquingKeysWith: { (first, _) in first })
//                        self.boxart?.data.mer
                        print("test b \(self.boxarts)")
                        
                        for item in decodedJSON {
                            print("decoding \(item)")
//
                            var game = GameObject()
                            game.id = item.id
                            game.title = item.gameTitle
                            if let unformattedDate = item.releaseDate {
                            
                                game.releaseDate = formatDate(releaseDate: unformattedDate)
                            }
//                            game.maxPlayers = item.players
                            game.overview = item.overview
                            game.rating = item.rating
                            game.youtubePath = item.youtube
                            game.platformID = item.platform
                            game.genreIDs = item.genres
                            game.developerIDs = item.developers
                            if let developerID = game.developerIDs {
                                game.developer = fetchDeveloperName(developerIDs: developerID)
                                
                            }
                            
                            if let genreID = game.genreIDs {
                                game.genres = fetchGenreNames(genreIDs: genreID)
                                
                                game.genreDescriptions = fetchGenreNames(genreIDs: genreID).joined(separator: " | ")
                            }
                            
                            guard let name = game.title else { return }
                            guard let id = game.id else { return }
                            guard let platformID = game.platformID else { return }
                            
                            game.boxartFrontImage = fetchFrontBoxartFilename(id: id)
                            game.boxartResolution = fetchBoxartResolution(id: id)
                            game.boxartRearImage = fetchRearBoxartFilename(id: id)
                        
                            game.owned = delegate?.checkForGameInLibrary(name: name, id: id, platformID: platformID)

                            print(game)
                            array.append(game)
                            self.tempArray = array
                            
                        }
                        
                        
                        gameArray.append(contentsOf: tempArray)
                        
                        print("gameArray \(gameArray)")
                        self.baseURL = jsonDecodedPlatforms.include.boxart.baseURL
                        self.page = jsonDecodedPlatforms.pages
                        
//                        self.games.append(contentsOf: decodedJSON)
                        
//                        for i in 0..<self.games.count {
////                            let vc = ViewController()
//                            print("checking if \(games[i].gameTitle) owned")
//                            print(games[i].id)
//                            print(delegate?.checkForGameInLibrary(title: games[i].gameTitle ?? "", id: games[i].id ?? 0 ))
//                            print("checkforgamesinlibrary = \(delegate?.checkForGameInLibrary(title: games[i].gameTitle, id: games[i].id!))")
//                            self.games[i].owned =
//                                delegate?.checkForGameInLibrary(title: games[i].gameTitle, id: games[i].id!)
////                            vc.checkForGameInLibrary(title: games[i].gameTitle, id: games[i].id!)
//                            print("games[0].owned = \(self.games[0].owned)")
//
//                        }
                        
                        
                        
                        
//                        if let parseJSON = decodedJSON {
//
//                            var items = self.games
//                            var boxarts = self.imageArray
//                            items.append(contentsOf: parseJSON)
//
//                            if self.initialOffset < items.count {
//                                self.games = items
//                                self.imageArray = boxarts
//                                self.initialOffset = items.count
//
//                            } else {
//                                self.games = items
//                                self.imageArray = boxarts
//                            }
//
//
//                        }
                        
                        
                    }
                    
                    DispatchQueue.main.async {
                        
                        completed()
//                        print(data)
                    }
                } catch {
                    print(error)
                }
                
            }
            
        }.resume()
        
    }
    
    
    func downloadScreenScraperJSON(gameName: String, completed: @escaping () -> () ) {
        
        
        if let gameName = gameName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            print("\(gameName)")
            let url = URL(string: "https://www.screenscraper.fr/api2/jeuInfos.php?devid=\(Constants.screenScaperDevID)&devpassword=\(Constants.screenScraperDevPassword)&softname=collector&output=json&romnom=\(gameName)")!
            var requestHeader = URLRequest.init(url: url )
            //        requestHeader.httpBody = "fields name;limit 50;".data(using: .utf8, allowLossyConversion: false)
            requestHeader.httpMethod = "GET"
            //        requestHeader.setValue(apiKey, forHTTPHeaderField: "user-key")
            //        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
            URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in

                if error == nil {
                    do {
//                        let json = String(data: data!, encoding: .utf8)
//                        print("Screen scraper JSON \(json)")

                        self.gameDetailsSS = try JSONDecoder().decode(ScreenScraper.self, from: data!)

                        DispatchQueue.main.async {
                            completed()
                        }
                    } catch {

                        print(error)

                    }
                }
            }.resume()
        }
        
    }
    
    
    
    func fetchGenreNames(genreIDs: [Int]) -> [String] {
        var genreArray : [String] = []
        for genre in genreIDs {
            let genreString = String(genre)
            if let name = gameGenreData[genreString]?.name {
            genreArray.append(name)
            }
        
        }
        
        return genreArray
    }
    
    func fetchDeveloperName(developerIDs: [Int]) -> String {
        guard let developerText = gameDeveloperData["\(developerIDs[0])"]?.name else {
            return ""
            
        }
        
        
        return developerText
    }
    
    
    func fetchFrontBoxart(id: Int) -> String {
        var frontImageName : String = ""
        var backImageName : String = ""
        
        if boxartsGameName["\(id)"]?[0].side == .front {
//            print(boxartsGameName["\(id)"]?[0].filename)
            frontImageName = (boxartsGameName["\(id)"]?[0].filename)!
            
        } else if boxartsGameName["\(id)"]?[0].side == .back {
            backImageName = (boxartsGameName["\(id)"]?[0].filename)!
            
        }
        
        if boxartsGameName["\(id)"]?.count == 2 {
        if boxartsGameName["\(id)"]?[1].side == .front {
            frontImageName = (boxartsGameName["\(id)"]?[1].filename)!
                       
        } else if boxartsGameName["\(id)"]?[1].side == .back {
            backImageName = (boxartsGameName["\(id)"]?[1].filename)!
                       
        }
        }
        print(backImageName)
        
        return frontImageName
        
    }
    
    func fetchRearBoxart(id: Int) -> String {
        var frontImageName : String = ""
        var backImageName : String = ""
        
        if boxartsGameName["\(id)"]?[0].side == .front {
//            print(boxartsGameName["\(id)"]?[0].filename)
            frontImageName = (boxartsGameName["\(id)"]?[0].filename)!
            
        } else if boxartsGameName["\(id)"]?[0].side == .back {
            backImageName = (boxartsGameName["\(id)"]?[0].filename)!
            
        }
        
        if boxartsGameName["\(id)"]?.count == 2 {
        if boxartsGameName["\(id)"]?[1].side == .front {
            frontImageName = (boxartsGameName["\(id)"]?[1].filename)!
                       
        } else if boxartsGameName["\(id)"]?[1].side == .back {
            backImageName = (boxartsGameName["\(id)"]?[1].filename)!
                       
        }
        }
        print(frontImageName)
        return backImageName
    }
    
    func fetchBoxartResolution(id: Int) -> String? {
//        var resolution = ""
//        print(boxartsGameName["\(id)"]?[0].filename)
//
//        print("boxarts \(boxartsGameName["\(id)"])")
//        print("boxarts \(boxartsGameName["\(id)"]?[1])")

        if let resolution = (boxartsGameName["\(id)"]?[0].resolution) {
        print("resolution = \(resolution)")
        return resolution
        }
        else {
            return nil
        }
        
        
    }
    
    
    func fetchFrontBoxartFilename(id: Int) -> String {
        var frontImageName : String = ""
        var backImageName : String = ""
        
        if boxartsGameName["\(id)"]?[0].side == .front {
//            print(boxartsGameName["\(id)"]?[0].filename)
            frontImageName = (boxartsGameName["\(id)"]?[0].filename
                )!
            
        } else if boxarts["\(id)"]?[0].side == .back {
            backImageName = (boxartsGameName["\(id)"]?[0].filename)!
            
        }
        
        if boxartsGameName["\(id)"]?.count == 2 {
        if boxartsGameName["\(id)"]?[1].side == .front {
            frontImageName = (boxartsGameName["\(id)"]?[1].filename)!
                       
        } else if boxarts["\(id)"]?[1].side == .back {
            backImageName = (boxartsGameName["\(id)"]?[1].filename)!
                       
        }
        }
        print(backImageName)
        return frontImageName
        
    }
    
    func fetchRearBoxartFilename(id: Int) -> String {
        var frontImageName : String = ""
        var backImageName : String = ""
        
        if boxarts["\(id)"]?[0].side == .front {
//            print(boxartsGameName["\(id)"]?[0].filename)
            frontImageName = (boxarts["\(id)"]?[0].filename)!
            
        } else if boxarts["\(id)"]?[0].side == .back {
            backImageName = (boxartsGameName["\(id)"]?[0].filename)!
            
        }
        
        if boxartsGameName["\(id)"]?.count == 2 {
        if boxartsGameName["\(id)"]?[1].side == .front {
            frontImageName = (boxartsGameName["\(id)"]?[1].filename)!
                       
        } else if boxarts["\(id)"]?[1].side == .back {
            backImageName = (boxartsGameName["\(id)"]?[1].filename)!
                       
        }
        }
        print(frontImageName)
        return backImageName
    }
    
    func formatDate(releaseDate: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-DD"
        dateFormatter.timeZone = TimeZone(abbreviation: "MST") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        
        let strDate = dateFormatter.date(from: releaseDate)
        dateFormatter.dateFormat = "MM-dd-yyyy" //Specify your format that you want
        let finalDate = dateFormatter.string(from: strDate!)
        return finalDate
    }
    
    
    func fetchAddtionalImageArrays(imageType: String, imageData: [Images.Inner]) -> [String] {
//        let images = imageData
        
        let filteredArray = imageData.filter({$0.type == "\(imageType)"})
        var imageArray : [String] = []
        for image in filteredArray {
            imageArray.append(image.fileName)
        }
        
//        print("filtered = \(filtered)")
        return imageArray
        
    }
    
    
    func getImageFileName(imageType: String, imageData: [Images.Inner]) -> String {
        print("outside imageData \(imageData)")
        
        let images = imageData

        var imageFileName : String = ""

        let testArray = images.filter({$0.type == "\(imageType)"})
print("testArray = \(testArray)")

        if testArray.count > 0 && imageType == "fanart"{
            imageFileName = (testArray.randomElement()?.fileName)!
            
        } else if testArray.count > 0 {
            imageFileName = (testArray[0].fileName)
        }
        return imageFileName
    }
    
    
    func fetchCompanyName(companyID: Int, game: IGDBGame) -> String {
        var companyName = ""
        if let involvedCompany = game.involvedCompanies {
        for company in involvedCompany {
            print("companyinfo \(company)")
            if company.id == companyID {
//                print("companyname \(company.company?.name)")
                companyName = (company.company?.name!)!
                
            }
            
            
            
        }
            
        }
        return companyName

    }
    
    func fetchAgeRatingString(rating: Int) -> String {
        
        var ratingString = ""
        
        switch rating {
        case 1:
            ratingString = "PEGI 3"
        case 2:
            ratingString = "PEGI 7"
        case 3:
            ratingString = "PEGI 12"
        case 4:
            ratingString = "PEGI 16"
        case 5:
            ratingString = "PEGI 18"
        case 6:
            ratingString = "ESRB RP"
        case 7:
            ratingString = "ESRB EC"
        case 8:
            ratingString = "ESRB E"
        case 9:
            ratingString = "ESRB E10"
        case 10:
            ratingString = "ESRB T"
        case 11:
            ratingString = "ESRB M"
        case 12:
            ratingString = "ESRB AO"
        default :
            ratingString = "ESRB NR"
        }
        
        return ratingString
    }
    
}


