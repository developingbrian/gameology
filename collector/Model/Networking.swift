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

//var gameData : GameDB?
let apiKey = "\(Constants.gameDBAPIKey)"
//var gameData


protocol NetworkingDelegate: AnyObject {
    func checkForGameInLibrary(name: String, id: Int, platformID: Int) -> Bool
}


class Networking {
    
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
    var scannedGameResults = [GameObject]()
    var resultsReceived : Bool = true
    var scrapedURL = ""
    var previousDataCount = 0
    var currentDataCount = 0
    var newDataCount = 0
    var currentTask : URLSessionTask?
    var totalRequestCount = 0
    
//    var connected: Bool! {
//      willSet {
//        if newValue == false && oldValue != false {
//          NotificationCenter.default.post(name: NSNotification.Name(rawValue: "connectionDropped"), object: nil)
//        }
//      }
//    }
    
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
    
    
    func scrapePriceCharting(platformID: Int, gameName: String, uneditedGameName: String) -> PriceInfo {
        let priceInfo = PriceInfo()
        let consoleUID = formatPlatformIDToPriceChartingID(ID: platformID)
        var name = gameName.replacingOccurrences(of: " ", with: "-")
//        var allowedQueryParamAndKey = NSCharacterSet.urlQueryAllowed
//        allowedQueryParamAndKey.remove(charactersIn: ";/?:@&=+$, ")
        name = name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        name = name.replacingOccurrences(of: "'", with: "%27")
//        name = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(name)
        let url = URL(string:"https://www.pricecharting.com/search-products?q=\(name)&type=prices&sort=popularity&broad-category=video-games&console-uid=\(consoleUID)&region-name=ntsc&exclude-variants=false")!
        network.scrapedURL = url.absoluteString
        print("contents of url", url)
        let content = (try? String(contentsOf: url))
        
            
        if let htmlContent = content {
        let doc : Document = try! SwiftSoup.parse(htmlContent)
        let doclocation = doc.location()
        let docTitle = try! doc.title()
        
        if docTitle.contains("Game List") {
            
            //scrape result returned no results
            
            
        print("doc location = ",
              docTitle)
            
            if try! doc.select("table#games_table.hoverable-rows.sortable").first() == nil {
            
                let page = try! doc.select("div#search-page.js-console-page")
                
                let results = try! page.compactMap { row throws -> String in
                    
                    guard page.count == 1, let link = try page[0].select("h1").first() else {
                        return "N/A" // wrong row
                    }

                    return try link.text()
                    
                }
                
                print("results", results)
                
                priceInfo.title = "N/A"
                priceInfo.loosePrice = "N/A"
                priceInfo.cibPrice = "N/A"
                priceInfo.newPrice = "N/A"
                
                return priceInfo
                
                
                
                
                
            }
            
            
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
        
        print("titles are", titles)
        print("platforms are", platforms)
        print("loose prices are", loosePrices)
        print("cib prices are", cibPrices)
        print("new prices are", newPrices)
            print("game name", uneditedGameName)

            let currentPlatform = formatPlatformIDToPlatformName(ID: platformID)
            var platformScoreArray : [Double] = []
            print("current platform", currentPlatform)
            var matchingIndexArray : [Int] = []

            var index = 0
            
            for platform in platforms {
                if platform.caseInsensitiveCompare(currentPlatform) == .orderedSame {
//                if platform == currentPlatform {
                    matchingIndexArray.append(index)
                }
                index += 1
            }
            
            
            if matchingIndexArray.count > 0 {
                var titleScoreArray : [Double] = []
                for index in matchingIndexArray {
                    let title = titles[index]
                    let score = title.levenshteinDistanceScore(to: uneditedGameName, ignoreCase: true, trimWhiteSpacesAndNewLines: true)
                    print("score for ", title," is ",score)
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
                    priceInfo.title = titles[index]
                    priceInfo.loosePrice = loosePrices[index]
                    priceInfo.cibPrice = cibPrices[index]
                    priceInfo.newPrice = newPrices[index]
                    
                } else {
                    priceInfo.title = "N/A"
                    priceInfo.loosePrice = "N/A"
                    priceInfo.cibPrice = "N/A"
                    priceInfo.newPrice = "N/A"
                    
                }
                
                
            } else {
                priceInfo.title = "N/A"
                priceInfo.loosePrice = "N/A"
                priceInfo.cibPrice = "N/A"
                priceInfo.newPrice = "N/A"
                            }
            


        return priceInfo
            
        } else {
            
            
        //scrape result found exact match.  identifying needed properties and then taking first (most relavent) result
            
            
        print("doc location = ",
              docTitle)
        let table = try! doc.select("table#price_data.info_box").first()!
        let rows = try! table.select("tr")
        let gamePage = try! doc.select("div#game-page").first()!
        let gameText = try! gamePage.select("h1#product_name.chart_title")
            let gameTitle = try! gamePage.select("h1#text")
        print("game text", gameText.count)
        print(gameText[0])
            var titles = try! gameText.compactMap { row throws -> String? in
//            let link = gameTitle
           
            let link = gameText[0]
            print(try link.text())
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
                print("score for ", title," is ",score)
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
        print("titles are", titles)
        print("loose prices are", loosePrices)
        print("cib prices are", cibPrices)
        print("new prices are", newPrices)
            if let index = bestMatchIndex {
        priceInfo.title = titles[index]
        priceInfo.loosePrice = loosePrices[index]
        priceInfo.cibPrice = cibPrices[index]
        priceInfo.newPrice = newPrices[index]
            } else {
                priceInfo.title = "N/A"
                priceInfo.loosePrice = "N/A"
                priceInfo.cibPrice = "N/A"
                priceInfo.newPrice = "N/A"
            }
            
        return priceInfo
    
        }
    
    }
        
        priceInfo.title = "N/A"
        priceInfo.loosePrice = "N/A"
        priceInfo.cibPrice = "N/A"
        priceInfo.newPrice = "N/A"
        
        return priceInfo
        
    }
    
    func formatPlatformIDToPlatformName(ID: Int) -> String {
      
            switch ID {
            case 50         :   return "3DO"
            case 114        :   return "Amiga CD32"
            case 59         :   return "Atari 2600"
            case 66         :   return "Atari 5200"
            case 60         :   return "Atari 7800"
            case 62         :   return "Jaguar"
            case 61         :   return "Atari Lynx"
            case 68         :   return "ColecoVision"
            case 127        :   return "Fairchild Channel F"
            case 67         :   return "Intellivision"
            case 88         :   return "Magnavox Odyssey"
            case 11         :   return "Xbox"
            case 12         :   return "Xbox 360"
            case 49         :   return "Xbox One"
            case 169        :   return "Xbox Series X"
            case 80         :   return "Neo Geo AES"
            case 136        :   return "Neo Geo CD"
            case 119, 120   :   return "Neo Geo Pocket Color"
            case 307        :   return "Game & Watch"
            case 18         :   return "NES"
            case 19         :   return "Super Nintendo"
            case 87         :   return "Virtual Boy"
            case 4          :   return "Nintendo 64"
            case 21         :   return "Gamecube"
            case 5          :   return "Wii"
            case 41         :   return "Wii U"
            case 130        :   return "Nintendo Switch"
            case 33         :   return "GameBoy"
            case 22         :   return "GameBoy Color"
            case 24         :   return "GameBoy Advance"
            case 20, 159    :   return "Nintendo DS"
            case 37, 137    :   return "Nintendo 3DS"
            case 166        :   return "Pokemon Mini"
            case 42         :   return "N-Gage"
            case 122        :   return "Nuon"
            case 86         :   return "TurboGrafx-16"
            case 128        :   return "JP PC Engine"
            case 117        :   return "CD-i"
            case 84         :   return "JP Sega Mark III"
            case 64         :   return "Sega Master System"
            case 29         :   return "Sega Genesis"
            case 78         :   return "Sega CD"
            case 30         :   return "Sega 32X"
            case 32         :   return "Sega Saturn"
            case 23         :   return "Sega Dreamcast"
            case 35         :   return "Sega Game Gear"
            case 339        :   return "Sega Pico"
            case 7          :   return "Playstation"
            case 8          :   return "Playstation 2"
            case 9          :   return "Playstation 3"
            case 48         :   return "Playstation 4"
            case 167        :   return "Playstation 5"
            case 38         :   return "PSP"
            case 46         :   return "PlayStation Vita"
            case 70         :   return "Vectrex"
            case 57         :   return "WonderSwan"
            case 123        :   return "WonderSwan Color"
            case 240        :   return "Zeebo"
            default         :   print("Unkown Platform, platform ID is \(ID)")
                                return "Unknown Platform, platform ID is \(ID)"
            }
       
    }
    
    
    func formatPlatformIDToPriceChartingID(ID: Int) -> String {
      
            switch ID {
            case 50     :   return "G25"    //"3DO Interactive Multiplayer"
            case 114    :   return "G92"    //"Amiga CD32"
            case 59     :   return "G24"    //"Atari 2600"
            case 66     :   return "G31"    //"Atari 5200"
            case 60     :   return "G33"    //"Atari 7800"
            case 62     :   return "G21"    //"Atari Jaguar"
            case 61     :   return "G26"    //"Atari Lynx"
            case 68     :   return "G30"    //"ColecoVision"
            case 127    :   return "G83"    //"Fairchild Channel F"
            case 67     :   return "G27"    //"Intellivision"
            case 88     :   return "G130"   //"Magnavox Odyssey"
            case 11     :   return "G8"     //"Microsoft Xbox"
            case 12     :   return "G10"    //"Microsoft Xbox 360"
            case 49     :   return "G54"    //"Microsoft Xbox One"
            case 169    :   return "G7585"  //"Microsoft Xbox Series S|X"
            case 80     :   return "G116"   //"Neo Geo AES"
            case 136    :   return "G60"    //"Neo Geo CD"
            case 119    :   return "G40"    //"Neo Geo Pocket"
            case 120    :   return "G40"    //"Neo Geo Pocket Color"
            case 307    :   return "G68"    //"Nintendo Game & Watch"
            case 18     :   return "G17"    //"Nintendo Entertainment System (NES)"
            case 19     :   return "G13"    //"Super Nintendo Entertainment System (SNES)"
            case 87     :   return "G22"    //"Nintendo Virtual Boy"
            case 4      :   return "G4"     //"Nintendo 64"
            case 21     :   return "G3"     //"Nintendo GameCube"
            case 5      :   return "G11"    //"Nintendo Wii"
            case 41     :   return "G47"    //"Nintendo Wii U"
            case 130    :   return "G59"    //"Nintendo Switch"
            case 33     :   return "G49"    //"Nintendo Game Boy"
            case 22     :   return "G2"     //"Nintendo Game Boy Color"
            case 24     :   return "G1"     //"Nintendo Game Boy Advance"
            case 20     :   return "G5"     //"Nintendo DS"
//          case 159    :   return ""       //"Nintendo DSi"
            case 37     :   return "G39"    //"Nintendo 3DS"
            case 137    :   return "G39"    //"New Nintendo 3DS"
            case 166    :   return "G143"   //"Nintendo Pokémon Mini"
            case 42     :   return "G42"    //"Nokia N-Gage"
//          case 122    :   return ""       //"Nuon"
            case 86     :   return "G19"    //"TurboGrafx-16/PC Engine"
            case 128    :   return "G82"    //"PC Engine SuperGrafx"
            case 117    :   return "G37"    //"Philips CD-i"
            case 84     :   return "G6900"  //"Sega SG-1000"
            case 64     :   return "G29"    //"Sega Master System"
            case 29     :   return "G15"    //"Sega Genesis/Mega Drive"
            case 78     :   return "G23"    //"Sega CD"
            case 30     :   return "G50"    //"Sega 32X"
            case 32     :   return "G14"    //"Sega Saturn"
            case 23     :   return "G16"    //"Sega Dreamcast"
            case 35     :   return "G20"    //"Sega Game Gear"
            case 339    :   return "G136"   //"Sega Pico"
            case 7      :   return "G6"     //"Sony PlayStation"
            case 8      :   return "G7"     //"Sony PlayStation 2"
            case 9      :   return "G12"    //"Sony PlayStation 3"
            case 48     :   return "G53"    //"Sony PlayStation 4"
            case 167    :   return "G7468"  //"Sony PlayStation 5"
            case 38     :   return "G9"     //"Sony PlayStation Portable (PSP)"
            case 46     :   return "G43"    //"Sony PlayStation Vita"
            case 70     :   return "G32"    //"Vectrex"
            case 57     :   return "G151"   //"WonderSwan"
            case 123    :   return "G152"   //"WonderSwan Color"
//          case 240    :   return ""       //"Zeebo"
            default     :   print("Unkown Platform, platform ID is \(ID)")
                            return ""
            }
       
    }
    
    
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
    
    func fetchGameFromUPC(gameName: String, platformID: [Int], completed: @escaping (Error?) -> () ) {
        scannedGameResults.removeAll()
        var searchResults : [GameObject] = []
        let stringComponents = gameName.components(separatedBy: " ")
        let allowedPlatforms : [Int] = [50,114,59,66,60,62,61,68,127,67,88,11,12,49,169,80,136,119,120,307,18,19,87,4,21,5,41,130,33,22,24,20,159,37,137,166,42,122,86,128,117,84,64,29,78,30,32,23,35,339,7,8,9,48,167,38,46,70,57,123,240]
        let fields = "fields age_ratings.*, genres.*, name, first_release_date, summary, involved_companies.company.name, involved_companies.publisher, total_rating, total_rating_count, platforms.*, cover.*, platforms.versions.platform_logo.*, platforms.platform_logo.*, screenshots.*, game_modes.name, rating, status, videos.video_id;"
//        let filter = "where name ~*(\"\(gameName)\");"
        
//        let filter = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7);"
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
        
        print("platforms are", platforms)
//        let filter = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & name ~ *\"\(gameName)\"*; sort name asc;"
        
        if platformID.count < 1 {
            filter = " where themes != (42) & status = n & category != (1,2,5,6,7);"
        } else {
            
            filter = " where themes != (42) & status = n & category != (1,2,5,6,7) & platforms = (\(platforms));"
        }
        
        let search = "search \"\(gameName)\";"
        let httpBodyString = fields + search + filter
        print("httpBodyString", httpBodyString)
        let url = URL(string: "https://30kn8ciec4.execute-api.us-west-2.amazonaws.com/production/v4/games")!
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpBody = httpBodyString.data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: requestHeader) { [self] (data, response, error) in
            
            do {
                
                var array = [GameObject]()
                
                if let decodedGameData = try JSONDecoder().decode(IGDBGames?.self, from: data!) {
                    print("decodedUPCGAMEDATA", decodedGameData)
                    var tempArray : [GameObject] = []
                    if decodedGameData.count == 0 {
                        resultsReceived = false
                        DispatchQueue.main.async {
                            completed(nil)
                        }
                    }
                    
                    resultsReceived = true
                    for gameData in decodedGameData {
                        var game = GameObject()
                        
//                        if let platforms = platformID {
                        
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
                            self.scannedGameResults = array
                                
                                print("barcode request complete, results are", scannedGameResults)
                                
                                DispatchQueue.main.async {
                                    completed(nil)
                                }
                            
                        }
                        }
                        
                        }
                        
                        else {
                            print("gamedata platform", gameData.platforms)
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
                            self.scannedGameResults = array
                                    
                                    print("barcode request complete, results are", scannedGameResults)
                                    
                                    DispatchQueue.main.async {
                                        completed(nil)
                                    }
                            
                        }
                        }
                        
                            }
                        }
//                        }
                
            
    
                        
                   

                }
                        
                    }
                
                    
                    
                    
                
                
                
                
            }
            
            catch {
                
                print(error)
                DispatchQueue.main.async {
                    completed(error)
                }
                
            }
            
        }.resume()
        
    }
    
    func fetchIGDBTop20Data(platformID: Int, completed: @escaping (Error?) -> () ) {
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
                        completed(nil)
                    }
                    
                    
                }
                
                catch {
                    print(error)
                    DispatchQueue.main.async {
                        completed(error)
                    }
                }
                
            }
        }.resume()
    }
    
    
    func fetchIGDBRecentlyReleasedData(platformID: Int, completed: @escaping (Error?) -> () ) {
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
                        completed(nil)
                    }
                    
                    
                }
                
                catch {
                    print(error)
                    DispatchQueue.main.async {
                        completed(error)
                    }
                }
                
            }
        }.resume()
    }
    
    
    func fetchIGDBComingSoonData(platformID: Int, completed: @escaping (Error?) -> () ) {
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
                        completed(nil)
                    }
                    
                    
                }
                
                catch {
                    print(error)
                    DispatchQueue.main.async {
                        completed(error)
                    }
                }
                
            }
        }.resume()
    }
    
    func searchIGDBByName(platformID: Int, searchByName: String, sortAscending: Bool, completed: @escaping () -> () ) {
    
        self.lastRequestedPlatformID = platformID
        
        var sortDirection : String {
            if sortAscending == true {
                return "asc"
            } else {
                return "dsc"
            }
        }
        
        var filter = " where themes != (42) % status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & platforms = \(platformID) & name ~ *\"\(searchByName)\"*; sort name \(sortDirection)"
    
        let fields = "fields age_ratings.*, genres.*, name, first_release_date, summary, involved_companies.company.name, involved_companies.publisher, total_rating, platforms.*, cover.*, platforms.versions.platform_logo.*, platforms.platform_logo.*, screenshots.*, game_modes.name, rating, status, videos.video_id, release_dates.*;"
        
        let httpBodyString =  fields + filter
        let url = URL(string: "https://30kn8ciec4.execute-api.us-west-2.amazonaws.com/production/v4/games")!
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpBody = httpBodyString.data(using: .utf8, allowLossyConversion: false)
        
        requestHeader.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: requestHeader) { [weak self] data, response, error in
            
            do {
                
                if let decodedGameData = try JSONDecoder().decode(IGDBGames?.self, from: data!) {
                    
                    for gameData in decodedGameData {
                        
                        
                        
                    }
                    
                    
                }
                
            }
            
            catch {
                
                
            }
        }
        
    }
    
    func createHTTPBody(sortByField: String?, sortAscending: Bool?, filterBy: String?, platformID: Int?, searchByName: String?, offset: Int, resultsPerPage: Int?) -> String {
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
            filter = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & \(filterParameters)(\(platformID)) & name ~ *\"\(searchName)\"*; sort name asc;"
                } else {
                    filter = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & \(filterParameters)(\(platformID)); sort name asc;"
                }
            } else {
                if let searchName = searchByName {
                filter = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & \(filterParameters) & name ~ *\"\(searchName)\"*; sort name asc;"
                } else {
                    
                    filter = " where themes != (42) & status = n & category != (1,2,5,6,7) & release_dates.region != (5,6,7) & \(filterParameters); sort name asc;"
                    
                }
            }
        }
        
        let fields = "fields age_ratings.*, genres.*, name, first_release_date, summary, involved_companies.company.name, involved_companies.publisher, total_rating, platforms.*, cover.*, platforms.versions.platform_logo.*, platforms.platform_logo.*, screenshots.*, game_modes.name, rating, status, videos.video_id, release_dates.*;"

        
   
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
        
        return httpBodyString
    }
    
    
    func fetchIGDBGamesData(filterBy: String?, platformID: Int?, searchByName: String?, sortByField: String?, sortAscending: Bool?, offset: Int, resultsPerPage: Int?, completed: @escaping (Error?) -> () ) {
        if let platform = platformID {
            self.lastRequestedPlatformID = platform
        }
//        var sortDirection = "asc"
//        var sort : String?
//        var filter : String?
//
//        if let sortField = sortByField {
//            if let sortAsc = sortAscending {
//
//        switch sortAsc {
//
//        case true:
//            sortDirection = "asc"
//        case false:
//            sortDirection = "dsc"
//
//        }
//
//            sort = " sort" + " \(sortField)" + " \(sortDirection);"
//        }
//
//        }
//
//        if let filterParameters = filterBy {
//            if let platformID = platformID {
//                if let searchName = searchByName {
//            filter = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & \(filterParameters)(\(platformID)) & name ~ *\"\(searchName)\"*; sort name asc;"
//                } else {
//                    filter = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & \(filterParameters)(\(platformID)); sort name asc;"
//                }
//            } else {
//                if let searchName = searchByName {
//                filter = " where themes != (42) & status = n & release_dates.region != (5,6,7) & category != (1,2,5,6,7) & \(filterParameters) & name ~ *\"\(searchName)\"*; sort name asc;"
//                } else {
//
//                    filter = " where themes != (42) & status = n & category != (1,2,5,6,7) & release_dates.region != (5,6,7) & \(filterParameters); sort name asc;"
//
//                }
//            }
//        }
//
//        let fields = "fields age_ratings.*, genres.*, name, first_release_date, summary, involved_companies.company.name, involved_companies.publisher, total_rating, platforms.*, cover.*, platforms.versions.platform_logo.*, platforms.platform_logo.*, screenshots.*, game_modes.name, rating, status, videos.video_id, release_dates.*;"
//
//
//
        let url = URL(string: "https://30kn8ciec4.execute-api.us-west-2.amazonaws.com/production/v4/games")!
        var requestHeader = URLRequest.init(url: url)
//
//        var httpBodyString = fields + " offset \(offset);"
//
//        if let limit = resultsPerPage {
//            httpBodyString += " limit \(limit);"
//        }
//
//        if let sortFields = sort {
//            httpBodyString += sortFields
//        }
//
//        if let filterData = filter {
//            httpBodyString += filterData
//        }
        let httpBody = createHTTPBody(sortByField: sortByField, sortAscending: sortAscending, filterBy: filterBy, platformID: platformID, searchByName: searchByName, offset: offset, resultsPerPage: resultsPerPage)

        print("httpbodystring \(httpBody)")
//        requestHeader.httpBody = httpBodyString.data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpBody = httpBody.data(using: .utf8, allowLossyConversion: false)

        requestHeader.httpMethod = "POST"
            
        self.currentTask = URLSession.shared.dataTask(with: requestHeader) { [weak self] (data, response, error) in
    
                
                do {
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        print("Response is")
                        print(httpResponse.allHeaderFields)
                        if let xCount = httpResponse.allHeaderFields["x-count"] as? String {
                            self?.totalRequestCount = Int(xCount)!
                            print("total request count is", self?.totalRequestCount)
                        }
                        
                    }
                    
                    self?.gameFetchDidFail = false
                    self?.gameFetchSuccess = true
                    
                    if self?.platformFetchSuccess == true && self?.genreFetchSuccess == true && self?.gameFetchSuccess == true {
                        self?.initialFetchComplete = true
                        
                    }
                    
                    var array = [GameObject]()
                        
                    func addGameToArray(gameFromRegion: [ReleaseDate], gameData: IGDBGame, platform: Int) {
                    
                        
                        let game = self?.createGameWithPlatformDateFiltered(releaseDates: gameFromRegion, platformID: platform, gameData: gameData)
//                            print(game)
                            if let game = game {
                                
                                
                                
                                
                            array.append(contentsOf: game)
                            }
                        
                    }
//                                        let json = String(data:data!, encoding: .utf8)
//                    print("here is json")
//                    print(json)
                    if let decodedGameData = try JSONDecoder().decode(IGDBGames?.self, from: data!) {
                        
                        if decodedGameData.count < 500 {
                            self?.endOfResults = true
//                            DispatchQueue.main.async {
//                                completed( nil)
//                            }
                            print("endofresults = \(self?.endOfResults)")
                        } else {
                            self?.endOfResults = false
                            print("endofresults = \(self?.endOfResults)")

                        }
                        
                        self?.newDataCount = decodedGameData.count

//                        let test = decodedGameData.filter( {$0.releaseDate?.filter( {$0.region == 2} )})
//                        let filteredGameData = decodedGameData })
                        var testArray : [GameObject] = []
                        self?.tempArray.removeAll()
                        for gameData in decodedGameData {
                            
                            if let date = gameData.releaseDate {
                                if let platform = platformID {
                                //we are only interested in certain reigions with the order of priority being North American, then European, and finally world wide releases.  If the game exists in multiple regions, go with the top priority.
                                
                                let naReleases = date.filter { $0.region == 2 && $0.platform == platformID }
                                let euReleases = date.filter { $0.region == 1 && $0.platform == platformID }
                                let wwReleases = date.filter { $0.region == 8 && $0.platform == platformID }
                                    addGameToArray(gameFromRegion: date, gameData: gameData, platform: platform)
//                                if naReleases.count > 0 {
//                                    print("na release", gameData.name, "count", naReleases.count)
//                                    addGameToArray(gameFromRegion: naReleases, gameData: gameData, platform: platform)
//
//                                } else if euReleases.count > 0 {
//                                    print("eu release", gameData.name, "count", euReleases.count)
//                                    addGameToArray(gameFromRegion: euReleases, gameData: gameData, platform: platform)
//
//                                } else if wwReleases.count > 0 {
//                                    print("ww release", gameData.name, "count", wwReleases.count)
//                                    addGameToArray(gameFromRegion: wwReleases, gameData: gameData, platform: platform)
//
//                                }
                                

                                }
                            }

                            self?.tempArray = array
                        print("platforms downloaded")

                    }
                        
                        
                        print("temp array count is", self?.tempArray.count)

                        for game in testArray {
                            print("games in test array", game.title)
                        }
                        let newData = self?.tempArray
                        var oldData = self?.gameArray
                        print("previous data count",self!.previousDataCount)
                        print("new data count", self!.newDataCount)
                        self?.currentDataCount = self!.previousDataCount + self!.newDataCount
                        self?.previousDataCount = self!.currentDataCount
//                        oldData?.append(contentsOf: newData!)
                        var mergedData = oldData
                        mergedData?.append(contentsOf: newData!)
                        print("currentOffset before = \(self?.currentOffset)")
                        print("mergeddata count is \((self?.currentDataCount)!)")
                        //think this is the one to work with**
                        if self!.currentOffset < self!.currentDataCount {
                            print("paginating")
                            if !self!.endOfResults {
                            self?.gameArray = mergedData!
                            print("gamearray count \(self?.gameArray.count)")
//                            currentOffset = mergedData.count
                            } else {
                                self?.gameArray = mergedData!
                            }
               

                        } else {
                            print("not paginating")
                            self?.gameArray = newData!
                        }
                        //**
                        
                      
                        
                        
                    
                    
                        
                        
                    
                        
                    DispatchQueue.main.async {
                        completed(error)
                    }
                    
                    
                    }
                    
                    
                    
                }
                catch {
                    self?.fetchingMore = false
                    print("fetching more error \(self?.fetchingMore)")
                    print("error= \(error)")
                    DispatchQueue.main.async {
                        completed(error)
                    }                }
                
            
            
     
            
            
        }
        currentTask?.resume()
    }
    
    
    
    func removeLeadingArticle(fromString: String) -> String{
        let articles = ["the", "a", "an"]
        
        for article in articles {
            if fromString.hasPrefix(article) {
//                return string.substring(from: string.index(string.startIndex, offsetBy: article.characters.count))
                let articleLength = article.count

               return String(((fromString[(fromString.index(fromString.startIndex, offsetBy: articleLength + 1))])))
            } else {
               return fromString
            }
            
        }
        
        return fromString
        

    }
    
    func refreshSavedContentFrom(updatedGameData: GameObject, savedGameToUpdate: NSManagedObject) {
        
        if let savedGame = savedGameToUpdate as? SavedGames {
            
            if savedGame.title != updatedGameData.title {
                savedGame.title = updatedGameData.title
            }
            
            if savedGame.overview != updatedGameData.overview {
                savedGame.overview = updatedGameData.overview
            }
            
            if savedGame.genre != updatedGameData.genreDescriptions {
                savedGame.genre = updatedGameData.genreDescriptions
            }
            
            if savedGame.genres != updatedGameData.genres {
                savedGame.genres = updatedGameData.genres
            }
            
            if savedGame.maxPlayers != updatedGameData.maxPlayers {
                savedGame.maxPlayers = updatedGameData.maxPlayers
            }
            
            if savedGame.rating != updatedGameData.rating {
                savedGame.rating = updatedGameData.rating
            }
            
            if savedGame.releaseDate != updatedGameData.releaseDate {
                savedGame.releaseDate = updatedGameData.releaseDate
            }
            
            if savedGame.developerName != updatedGameData.developer {
                savedGame.developerName = updatedGameData.developer
                
            }
            
            if savedGame.youtubeURL != updatedGameData.youtubePath {
                savedGame.youtubeURL = updatedGameData.youtubePath
            }
            
            var screenShotArray : [String] = []
            if let screenshots = updatedGameData.screenshots {
            for screenshot in screenshots {
                if let imageID = screenshot.imageID {
                screenShotArray.append(imageID)
                }
            }
            }
            
            
            if savedGame.screenshotImageIDs != screenShotArray {
                
                savedGame.screenshotImageIDs = screenShotArray
            }
            
            if savedGame.boxartImageURL != updatedGameData.boxartFrontImage {
                savedGame.boxartImageURL = updatedGameData.boxartFrontImage
                
            }
            
            
            if let userRating = updatedGameData.userRating {
            if savedGame.userRating != Int32(userRating) {
                savedGame.userRating = Int32(userRating)
            }
            }
            
            
            if let totalRating = updatedGameData.totalRating {
            if savedGame.totalRating != Int32(totalRating) {
                savedGame.totalRating = Int32(totalRating)
            }
            }
            
        }
        
        if let wishlistGame = savedGameToUpdate as? WishList {
            
            if wishlistGame.title != updatedGameData.title {
                wishlistGame.title = updatedGameData.title
            }
            
            if wishlistGame.overview != updatedGameData.overview {
                wishlistGame.overview = updatedGameData.overview
            }
            
            if wishlistGame.genre != updatedGameData.genreDescriptions {
                wishlistGame.genre = updatedGameData.genreDescriptions
            }
            
            if wishlistGame.genres != updatedGameData.genres {
                wishlistGame.genres = updatedGameData.genres
            }
            
            if wishlistGame.maxPlayers != updatedGameData.maxPlayers {
                wishlistGame.maxPlayers = updatedGameData.maxPlayers
            }
            
            if wishlistGame.rating != updatedGameData.rating {
                wishlistGame.rating = updatedGameData.rating
            }
            
            if wishlistGame.releaseDate != updatedGameData.releaseDate {
                wishlistGame.releaseDate = updatedGameData.releaseDate
            }
            
            if wishlistGame.developerName != updatedGameData.developer {
                wishlistGame.developerName = updatedGameData.developer
                
            }
            
            if wishlistGame.youtubeURL != updatedGameData.youtubePath {
                wishlistGame.youtubeURL = updatedGameData.youtubePath
            }
            
            var screenShotArray : [String] = []
            if let screenshots = updatedGameData.screenshots {
            for screenshot in screenshots {
                if let imageID = screenshot.imageID {
                screenShotArray.append(imageID)
                }
            }
            }
            
            
            if wishlistGame.screenshotImageIDs != screenShotArray {
                
                wishlistGame.screenshotImageIDs = screenShotArray
            }
            
            if wishlistGame.boxartImageURL != updatedGameData.boxartFrontImage {
                wishlistGame.boxartImageURL = updatedGameData.boxartFrontImage
                
            }
            
            
            if let userRating = updatedGameData.userRating {
            if wishlistGame.userRating != Int32(userRating) {
                wishlistGame.userRating = Int32(userRating)
            }
            }
            
            
            if let totalRating = updatedGameData.totalRating {
            if wishlistGame.totalRating != Int32(totalRating) {
                wishlistGame.totalRating = Int32(totalRating)
            }
            }
            
            
        }
        
        persistenceManager.save()
    }
    
    func filterRegions(releaseDate: ReleaseDate, maxYear: Int,gameData: IGDBGame, platformID: Int) -> [GameObject] {
        var game = GameObject()
        var array : [GameObject] = []
        let savedGames = persistenceManager.fetch(SavedGames.self)
        let wishlistGames = persistenceManager.fetch(WishList.self)
        
        print("About to filter by platforms release year, title is", gameData.name)
        
        if let releaseYear = releaseDate.y {
            let region = releaseDate.region
            print("release year", releaseYear)
            print("max year", maxYear)
            print("region", region)


            if region == 2 && releaseYear < maxYear {
            game = (self.createGameObject(data: gameData, platformID: platformID))
                for savedGame in savedGames {
                    if savedGame.gameID == Int32(game.id!){
                        refreshSavedContentFrom(updatedGameData: game, savedGameToUpdate: savedGame)
                    }
                }
                
                for wishlistGame in wishlistGames {
                    if wishlistGame.gameID == Int32(game.id!) {
                        refreshSavedContentFrom(updatedGameData: game, savedGameToUpdate: wishlistGame)
                }
                }
                
            array.append(game)

        } else if region == 1 && releaseYear < maxYear {
                game = (self.createGameObject(data: gameData, platformID: platformID))
            
            for savedGame in savedGames {
                if savedGame.gameID == Int32(game.id!){
                    refreshSavedContentFrom(updatedGameData: game, savedGameToUpdate: savedGame)

            }
            }
            
            for wishlistGame in wishlistGames {
                if wishlistGame.gameID == Int32(game.id!) {
                    refreshSavedContentFrom(updatedGameData: game, savedGameToUpdate: wishlistGame)            }
            }
            
                array.append(game)

            } else if region == 8 && releaseYear < maxYear {
                game = (self.createGameObject(data: gameData, platformID: platformID))
                
                
                for savedGame in savedGames {
                    if savedGame.gameID == Int32(game.id!){
                        refreshSavedContentFrom(updatedGameData: game, savedGameToUpdate: savedGame)

                }
                }
                
                for wishlistGame in wishlistGames {
                    if wishlistGame.gameID == Int32(game.id!) {
                        refreshSavedContentFrom(updatedGameData: game, savedGameToUpdate: wishlistGame)
                        
                    }
                }
                
                
                array.append(game)
                
            }
        }
        
        return array

    }
    
    func createGameWithPlatformDateFiltered(releaseDates: [ReleaseDate], platformID: Int, gameData: IGDBGame) -> [GameObject] {
        var array : [GameObject] = []
        print(gameData.name!)
            print("release platform ==", platformID)
            print(releaseDates)
        for releaseDate in releaseDates {
            
            if releaseDate.platform == platformID {
                let region = releaseDate.region
            switch platformID {
           
            case 50     :
            //"3DO Interactive Multiplayer"
                
               array = filterRegions(releaseDate: releaseDate, maxYear: 1997, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1997 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//                }
//                }
            case 114    :   //return "Amiga CD32"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1997, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1997 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//                }
//                }
            case 59     :   //return "Atari 2600"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1993, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1993 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//                }
//                }
            case 66                                   :   //return "Atari 5200"
                
                array = filterRegions(releaseDate: releaseDate, maxYear: 1987, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1987 {
//                    game = self.createGameObject(data: gameData, platformID: platformID)
//                    array.append(game)
//
//                }
//                }
            case 60:   //return "Atari 7800"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1992, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1992 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//
//                }
//                }
            case 62                                 :   //return "Atari Jaguar"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1999, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1999 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//
//                }
//                }
            case 61                                   :   //return "Atari Lynx"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1997, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2000 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//
//                }
//                }
            case 68                                 :   //return "ColecoVision"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1987, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1987 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 127                          :   //return "Fairchild Channel F"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1982, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1982 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 67                                :   //return "Intellivision"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1990, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1990 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//
//                }
//                }
            case 88                             :   //return "Magnavox Odyssey"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1980, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1980 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 11                               :   //return "Microsoft Xbox"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2009, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2009 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//
//                    array.append(game)
//
//                }
//                }
            case 12                           :   //return "Microsoft Xbox 360"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2019, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2019 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//
//                    array.append(game)
//
//                }
//                }
            case 49                           :   //return "Microsoft Xbox One"
     
//                game = (self.createGameObject(data: gameData, platformID: platformID))
//                array.append(game)
                array = filterRegions(releaseDate: releaseDate, maxYear: 2050, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }

            case 169                    :   //return "Microsoft Xbox Series S|X"
            
//                game = (self.createGameObject(data: gameData, platformID: platformID))
//                array.append(game)
                array = filterRegions(releaseDate: releaseDate, maxYear: 2050, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }

            case 80                                  :   //return "Neo Geo AES"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2005, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2005 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//
//                    array.append(game)
//
//                }
//                }
            case 136                                   :   //return "Neo Geo CD"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1997, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2000 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//
//                    array.append(game)
//
//                }
//                }
            case 119                               :   //return "Neo Geo Pocket"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2001, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2001 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//
//                    array.append(game)
//
//                }
//                }
            case 120                         :   //return "Neo Geo Pocket Color"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2002, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2002 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 307                        :   //return "Nintendo Game & Watch"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1997, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1992 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 18          :   //return "Nintendo Entertainment System (NES)"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1998, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1998 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 19   :   //return "Super Nintendo Entertainment System (SNES)"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1997, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2001 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 87                         :   //return "Nintendo Virtual Boy"
            
                array = filterRegions(releaseDate: releaseDate, maxYear: 1997, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1997 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//
//                    array.append(game)
//
//                }
//                }
            case 4                                  :   //return "Nintendo 64"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2003, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2003 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 21                            :   //return "Nintendo GameCube"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1997, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2008 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 5                                 :   //return "Nintendo Wii"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2021, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2021 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 41                               :   //return "Nintendo Wii U"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2021, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2021 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//
//                    array.append(game)
//
//                }
//                }
            case 130                              :
            //return "Nintendo Switch"
              
//                game = (self.createGameObject(data: gameData, platformID: platformID))
//                array.append(game)
                array = filterRegions(releaseDate: releaseDate, maxYear: 2050, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }

                
            case 33                            :
                
            //return "Nintendo Game Boy"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2021, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2021 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//                }
//                }
                    
            case 22     :   //return "Nintendo Game Boy Color"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2003, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2003 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//
//                }
//                }
            case 24                    :   //return "Nintendo Game Boy Advance"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1997, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2009 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//
//                }
//                }
            case 20                                  :   //return "Nintendo DS"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2015, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2015 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 159                                 :   //return "Nintendo DSi"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2017, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2017 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 37                                 :   //return "Nintendo 3DS"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2021, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2021 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 137                             :   //return "New Nintendo 3DS"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2021, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2021 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 166                        :   //return "Nintendo Pokémon Mini"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2003, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2003 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 42                                 :   //return "Nokia N-Gage"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2007, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2007 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 122                                         :   //return "Nuon"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2005, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2005 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 86                      :   //return "TurboGrafx-16/PC Engine"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2000, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2000 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 128                         :   //return "PC Engine SuperGrafx"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1995, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1995 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 117                                 :   //return "Philips CD-i"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2000, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2000 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 84                                 :   //return "Sega SG-1000"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1988, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1988 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 64                           :   //return "Sega Master System"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1999, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1999 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 29                      :   //return "Sega Genesis/Mega Drive"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1999, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1999 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 78                                      :   //return "Sega CD"
                print("region before filter", region)
                array = filterRegions(releaseDate: releaseDate, maxYear: 1997, gameData: gameData, platformID: platformID)
                 
                if array.count > 0 {
                return array
                }
//                if let releaseYear = releaseDate.y {
//                    if releaseDate.region == 2 && releaseYear < 1997 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//                        print("added US Region game", game.title)
//                    return array
//
//                    } else if releaseDate.region == 1 && releaseYear < 1997 {
//                        game = (self.createGameObject(data: gameData, platformID: platformID))
//                        array.append(game)
//                        print("added EU Region game", game.title)
//                        return array
//
//                    } else  if releaseDate.region == 8 && releaseYear < 1997  {
//                        game = (self.createGameObject(data: gameData, platformID: platformID))
//                        array.append(game)
//                        print("added WW Region game", game.title)
//
//                        return array
//                    }
//                }

                
            case 30                                     :   //return "Sega 32X"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1997, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if region == 2 && releaseYear < 1997 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//                }else if region == 1 && releaseYear < 1997 {
//                        game = (self.createGameObject(data: gameData, platformID: platformID))
//                        array.append(game)
//
//                    } else if region == 8 && releaseYear < 1997 {
//                        game = (self.createGameObject(data: gameData, platformID: platformID))
//                        array.append(game)
//
//                    }
//                }
            case 32                                  :   //return "Sega Saturn"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1999, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1999 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 23                               :   //return "Sega Dreamcast"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2005, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2005 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 35                               :   //return "Sega Game Gear"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1998, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1998 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 339                                    :   //return "Sega Pico"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1999, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1999 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 7                             :   //return "Sony PlayStation"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2006, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2006 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 8                           :   //return "Sony PlayStation 2"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2014, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2014 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 9                           :   //return "Sony PlayStation 3"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2021, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2021 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 48                           :   //return "Sony PlayStation 4"
          
//                game = (self.createGameObject(data: gameData, platformID: platformID))
//                array.append(game)
                array = filterRegions(releaseDate: releaseDate, maxYear: 2050, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }

              
            case 167                           :   //return "Sony PlayStation 5"
            
//                game = (self.createGameObject(data: gameData, platformID: platformID))
//                array.append(game)
                array = filterRegions(releaseDate: releaseDate, maxYear: 2050, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }
                
            case 38              :   //return "Sony PlayStation Portable (PSP)"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2017, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2017 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 46                        :   //return "Sony PlayStation Vita"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2022, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2022 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 70                                      :   //return "Vectrex"
                array = filterRegions(releaseDate: releaseDate, maxYear: 1984, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 1984 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 57                                   :   //return "WonderSwan"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2002, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2002 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 123                             :   //return "WonderSwan Color"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2005, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2005 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            case 240                                        :   //return "Zeebo"
                array = filterRegions(releaseDate: releaseDate, maxYear: 2011, gameData: gameData, platformID: platformID)
                if array.count > 0 {
                return array
                }//                if let releaseYear = releaseDate.y {
//                if releaseYear < 2011 {
//                    game = (self.createGameObject(data: gameData, platformID: platformID))
//                    array.append(game)
//
//
//                }
//                }
            default                                             : print("Unkown Platform, platform ID is \(platformID)")
            }
            
//        print("game is", game.title)
//            print("platform is", platformID)
            }
        }
            return array
            
            
        
        
        
    }
    
    func createGameObject(data: IGDBGame, platformID: Int) -> GameObject {
        
        let gameData = data
        var game = GameObject()
//        var region = 0
//        for releaseDate in gameData.releaseDate! {
//            if releaseDate.platform == platformID {
//                region = 0
//            }
//        }
//         region = gameData.releaseDate?[0].region
        let regionFilter = gameData.releaseDate?.contains {$0.region == 2}
        let jpFilter = gameData.releaseDate?.contains {$0.region == 5}
        let asiaFilter = gameData.releaseDate?.contains {$0.region == 7}
        let chinaFilter = gameData.releaseDate?.contains {$0.region == 6}
        print("about to look at filters, game name is", gameData.name)
        switch (regionFilter, jpFilter, asiaFilter, chinaFilter) {
        case (false, false, false, false):
            //game doesnt exist in any of the regions
            print("game doesnt exist in any of the regions")
        
        case(true, false, false, false):
            //game was released in NA only
            print("game was released in NA only")
        case(false, true, true, true):
            //game is asia only release
            print("game is asia only release")
        case(false, true, true, false):
            //game is asia only release
            print("game is asia only release")
        case(false, true, false, false):
            //game is asia only release
            print("game is asia only release")
        case(false, true, false, true):
            //game is asia only release
            print("game is asia only release")
        case(false, false, true, true):
            //game is asia only release
            print("game is asia only release")
        case(false, false, true, false):
            //game is asia only release
            print("game is asia only release")
        case(false, false, false, true):
            //game is asia only release
            print("game is asia only release")
        case(false, false, false, true):
            //game is asia only release
            print("game is asia only release")
        case(true, true, false, false):
            //game is na and japan only release
            print("game is na and japan only release")
        case(true, true, false, true):
            //game is na, jp, and china only release
            print("")
        case(true, true, true, false):
            //game is na, jp, asia only release
            print("game is na, jp, and china only release")
        case(true, false, true, true):
            //game is na, asia, china only release
            print("game is na, jp, and china only release")
        case(true, false, true, false):
            //game is na and asia only release
            print("game is na and asia only release")
        case(true, false, false, true):
            //game is na and china only release
            print("game is na and china only release")
        

        default:
            print("game doesnt match test cases, results are", regionFilter, jpFilter, asiaFilter, chinaFilter)
        }
    
      
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
                game.rating = self.fetchAgeRatingString(rating: rating)
//                                    print("game rating in esrb rating count: \(game.rating)")
            } else {
                if esrbRatings.count == 0 {
                if pegiRatings.count > 0 {
                let rating = pegiRatings[0].rating!
                    game.rating = self.fetchAgeRatingString(rating: rating)
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
                game.developer = self.fetchCompanyName(companyID: company.id!, game: gameData
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
        guard let name = game.title else { return game }
        guard let id = game.id else { return game}
        guard let platformID = game.platformID else { return game}
        game.owned = self.delegate?.checkForGameInLibrary(name: name, id: id, platformID: platformID)
        
//        print("game to return is", game.)
        return game
        
        
    }
    
    
    
    func fetchIGDBGenreData(completed: @escaping (Error?) -> () ) {
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
                    print("failure")
                    print(error)
                    DispatchQueue.main.async {
                        completed(error)
                    }
                }
                
            } else {
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
        requestHeader.httpMethod = "POST"
        URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
            
            if error == nil {
                
                do {
                    self.platformFetchSuccess = true
                    self.platformFetchDidFail = false
                    if self.platformFetchSuccess == true && self.genreFetchSuccess == true && self.gameFetchSuccess == true {
                        self.initialFetchComplete = true
                        
                    }
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


