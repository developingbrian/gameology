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


protocol NetworkingDelegate: class {
    func checkForGameInLibrary(name: String, id: Int) -> Bool
}


class Networking {
    
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
    var genre : GenreData?
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
    var platforms : [String: PlatformInfo] = [:]
    var platformArray = [PlatformInfo]()
    var userImageArray : [UIImage] = []
    
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
            
            print(fields)
            print(gameName)
            print(apiKey)
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
                    print("\(json)")
                    
                    var array = [GameObject]()
                    
                    if let jsonDecodedByGameName = try JSONDecoder().decode(ByGameName?.self, from: data!) {
                        
                        let decodedByGameName = jsonDecodedByGameName.data?.games as! [Game]
                        let boxartByGameName = jsonDecodedByGameName.include.boxart?.data
                        self.boxartsGameName.merge(boxartByGameName!, uniquingKeysWith:  { (first, _) in first })
                        
                        for item in decodedByGameName {
                            
                            var game = GameObject()
                            game.id = item.id
                                game.title = item.gameTitle
                            print("gamename item.releaseDate \(item.releaseDate)")
                            if let unformattedDate = item.releaseDate{
                                
                                    game.releaseDate = formatDate(releaseDate: unformattedDate)
                            } else {
                                game.releaseDate = ""
                            }
                                game.maxPlayers = item.players
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
                              
                                game.boxartFrontImage = fetchFrontBoxart(id: id)
                                    
                                game.boxartRearImage = fetchRearBoxart(id: id)
                            
                                game.owned = delegate?.checkForGameInLibrary(name: name, id: id)

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
        
        var game = GameObject()
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
                print(url)
//                "https://api.thegamesdb.net/v1/Games/Images?apikey=\(apiKey)&games_id=\(gameData)&filter%5Btype%5D=clearlogo%20%2C%20fanart")!
                var requestHeader = URLRequest.init(url: url!)
                requestHeader.httpMethod = "GET"
                requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
            
                URLSession.shared.dataTask(with: requestHeader) { [self] (data, response, error) in
                    print("url session")
                
                    
                    if error == nil {
                        do {
                            let json = String(data:data!, encoding: .utf8)
                            print("\(json)")
                            print("gameData = \(gameData)")
//                             self.gameDataImages
                            if let jsonDecodedGameImages = try JSONDecoder().decode(GameDBData?.self, from: data!) {
//                                self.gameImages = jsonDecodedGameImages.data?.images.innerArray["\(gameData)"] as [GameImages.Inner]
                                self.gametestImageData = jsonDecodedGameImages.data?.images.innerArray["\(gameData)"]
                                print(gametestImageData)
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
                                print("inside downloadGameImageJSON-gameImageData = \(self.gameImages)")
                                print("gametestImageData \(self.gametestImageData)")
                               
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
    
    func downloadGenreJSON(completed: @escaping () -> () ) {
        var url = URL(string: "https://api.thegamesdb.net/v1/Genres?apikey=\(apiKey)")!
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpMethod = "GET"
        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
            
            if error == nil {
                
                
                do {
                    let json = String(data:data!, encoding: .utf8)
                    print("\(json)")
                    
//                    self.gameGenreData
                    if let jsonDecodedGenre = try JSONDecoder().decode(GenreData?.self, from: data!){
                        
                        self.gameGenreData = jsonDecodedGenre.data.genres
                        self.genre = jsonDecodedGenre
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
    
    
    func downloadPlatformJSON(completed: @escaping () -> () ) {
        var url = URL(string: "https://api.thegamesdb.net/v1/Platforms?apikey=\(apiKey)&fields=icon%2Cconsole%2Ccontroller%2Cdeveloper%2Cmanufacturer%2Cmedia%2Ccpu%2Cmemory%2Cgraphics%2Csound%2Cmaxcontrollers%2Cdisplay%2Coverview%2Cyoutube")!
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpMethod = "GET"
        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
            
            if error == nil {
                
                
                do {
                    let json = String(data:data!, encoding: .utf8)
//                    print("\(json)")
                    
//                    self.gameGenreData
                    if let decodedPlatforms = try JSONDecoder().decode(Platforms?.self, from: data!){
                        
                       
                        self.platforms = decodedPlatforms.data.platforms
                        for platform in self.platforms {
                            self.platformArray.append(platform.value)
                        }
                        print("platformArray \(self.platformArray)")
//                        let sortedArray = self.platformArray.sorted(by: ( {$0["name"]! < $1["name"]!}))
                        
                        let sorted = self.platformArray.sort(by: { (firstObject, secondObject) in
                            return firstObject.name > secondObject.name
                        
                         
                            
                        })
                        
                        
//                        let sort = self.platformArray.sorted(by: { (first, second) in
//                            return first.name.lowercased() < second.name.lowercased()
//                            
//                        })
                        let sort = self.platformArray.sorted(by: { $0.name.lowercased() < $1.name.lowercased()})
                        
                        print("sorted \(sort)")


//                        let sortedArray = (self.platformArray as NSArray).sortedArray(using: [NSSortDescriptor(key: "name", ascending: true)]) as! [[String:AnyObject]]
//                        print("sortedArray \(sortedArray)")

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
    
     func downloadDevelopersJSON(completed: @escaping () -> () ) {
            var url = URL(string: "https://api.thegamesdb.net/v1/Developers?apikey=\(apiKey)")!
            var requestHeader = URLRequest.init(url: url)
            requestHeader.httpMethod = "GET"
            requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
            URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
                
                if error == nil {
                    
                    
                    do {
                        let json = String(data:data!, encoding: .utf8)
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
            var url = URL(string: "https://api.thegamesdb.net/v1/Developers?apikey=\(apiKey)")!
            var requestHeader = URLRequest.init(url: url)
            requestHeader.httpMethod = "GET"
            requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
            URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
                
                if error == nil {
                    
                    
                    do {
                        let json = String(data:data!, encoding: .utf8)
                        print("\(json)")
                        
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
                print("error = \(error)")
                completed()
            }
            
            if error == nil {
                do {
                    print("error = nil")
                    let json = String(data: data!, encoding: .utf8)
                    
                    print(json)
                    var array = [GameObject]()
                    
//                    var game = GDBGamesPlatform()
                    
                    
                   
                    
                    print("response \(response)")
                    
                    
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
                            game.maxPlayers = item.players
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
                          
                            game.boxartFrontImage = fetchFrontBoxartFilename(id: id)
                                
                            game.boxartRearImage = fetchRearBoxartFilename(id: id)
                        
                            game.owned = delegate?.checkForGameInLibrary(name: name, id: id)

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
                        print(data)
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
                        let json = String(data: data!, encoding: .utf8)
                        print("Screen scraper JSON \(json)")

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
            genreArray.append("\(gameGenreData["\(genre)"]!.name)")
            
        
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
            print(boxartsGameName["\(id)"]?[0].filename)
            frontImageName = boxartsGameName["\(id)"]?[0].filename as! String
            
        } else if boxartsGameName["\(id)"]?[0].side == .back {
            backImageName = boxartsGameName["\(id)"]?[0].filename as! String
            
        }
        
        if boxartsGameName["\(id)"]?.count == 2 {
        if boxartsGameName["\(id)"]?[1].side == .front {
            frontImageName = boxartsGameName["\(id)"]?[1].filename as! String
                       
        } else if boxartsGameName["\(id)"]?[1].side == .back {
            backImageName = boxartsGameName["\(id)"]?[1].filename as! String
                       
        }
        }
        
        return frontImageName
        
    }
    
    func fetchRearBoxart(id: Int) -> String {
        var frontImageName : String = ""
        var backImageName : String = ""
        
        if boxartsGameName["\(id)"]?[0].side == .front {
            print(boxartsGameName["\(id)"]?[0].filename)
            frontImageName = boxartsGameName["\(id)"]?[0].filename as! String
            
        } else if boxartsGameName["\(id)"]?[0].side == .back {
            backImageName = boxartsGameName["\(id)"]?[0].filename as! String
            
        }
        
        if boxartsGameName["\(id)"]?.count == 2 {
        if boxartsGameName["\(id)"]?[1].side == .front {
            frontImageName = boxartsGameName["\(id)"]?[1].filename as! String
                       
        } else if boxartsGameName["\(id)"]?[1].side == .back {
            backImageName = boxartsGameName["\(id)"]?[1].filename as! String
                       
        }
        }
        
        return backImageName
    }
    
    
    
    func fetchFrontBoxartFilename(id: Int) -> String {
        var frontImageName : String = ""
        var backImageName : String = ""
        
        if boxarts["\(id)"]?[0].side == .front {
            print(boxarts["\(id)"]?[0].filename)
            frontImageName = boxarts["\(id)"]?[0].filename as! String
            
        } else if boxarts["\(id)"]?[0].side == .back {
            backImageName = boxarts["\(id)"]?[0].filename as! String
            
        }
        
        if boxarts["\(id)"]?.count == 2 {
        if boxarts["\(id)"]?[1].side == .front {
            frontImageName = boxarts["\(id)"]?[1].filename as! String
                       
        } else if boxarts["\(id)"]?[1].side == .back {
            backImageName = boxarts["\(id)"]?[1].filename as! String
                       
        }
        }
        
        return frontImageName
        
    }
    
    func fetchRearBoxartFilename(id: Int) -> String {
        var frontImageName : String = ""
        var backImageName : String = ""
        
        if boxarts["\(id)"]?[0].side == .front {
            print(boxarts["\(id)"]?[0].filename)
            frontImageName = boxarts["\(id)"]?[0].filename as! String
            
        } else if boxarts["\(id)"]?[0].side == .back {
            backImageName = boxarts["\(id)"]?[0].filename as! String
            
        }
        
        if boxarts["\(id)"]?.count == 2 {
        if boxarts["\(id)"]?[1].side == .front {
            frontImageName = boxarts["\(id)"]?[1].filename as! String
                       
        } else if boxarts["\(id)"]?[1].side == .back {
            backImageName = boxarts["\(id)"]?[1].filename as! String
                       
        }
        }
        
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
        let images = imageData
        
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
}
