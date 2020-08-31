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


class Networking {
    
    var gameData = [Game]()
    var gameDataImages : GameDBData?
    var gamesByPlatformID : ByPlatformIDData?
    var gameGenreData : [String: Genre] = [:]
    var gameImageData : [Images.Inner]?
    var gametestImageData : Images.Inner?
    var gameDeveloperData : [String: Developer] = [:]
    var gamePublisherData : [String: Publisher] = [:]
    var gamesData: ByPlatformIDData?
    var games = [GDBGamesPlatform]()
    var boxarts = [Boxart]()
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
    var page : Pages?
    var imageArray : [UIImage?] = []
    
    func downloadGamesByGameNameJSON(gameNamed: String?, fields: String?, filterByPlatformID: String?, include: String?, completed: @escaping () -> () ) {
        
        if let gameName = gameNamed!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            
            print(fields)
            print(gameName)
            print(apiKey)
        var urlString = "https://api.thegamesdb.net/v1.1/Games/ByGameName?apikey=\(apiKey)&name=\(gameName)"
        if fields != nil {
            urlString = urlString + "&fields=" + fields!
        }
        if filterByPlatformID != nil {
                urlString = urlString + "&filter%5Bplatform%5D=" + "\(filterByPlatformID!)"
            }
            
        if include != nil {

            urlString = urlString + "&include=" + include!
        }
        
            
        print("urlString = \(urlString)")
        let url = URL(string: urlString)!
            print("\(url)")
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpMethod = "GET"
        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: requestHeader) {
            (data,response, error) in
            
            if error == nil {
                do {
                    let json = String(data: data!, encoding: .utf8)
                    print("\(json)")
                    
                    if let jsonDecodedByGameName = try JSONDecoder().decode(ByGameName?.self, from: data!) {
                        
                        self.gameData = jsonDecodedByGameName.data?.games as! [Game]
                        self.gameNameBoxart = jsonDecodedByGameName.include?.boxart
                        
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
    
    func downloadGameImageJSON(gameID: Int?, completed: @escaping () -> () ) {
        print("downloadGameImageJSON()")
//        print("games.count = \(games.count)")
//        if (games.count) > 0 {
//        if (gameData.count) > 0 {
//            print(games[0].id!)
            if let gameData = gameID {
//            if let gameData = gameData[0].id {
                print("gameData = \(gameData)")
                let url = URL(string:"https://api.thegamesdb.net/v1/Games/Images?apikey=\(apiKey)&games_id=\(gameData)")!
//                &filter%5Btype%5D=%20valfanart%2Cbanner%2Cboxart%2Cscreenshot%2Cclearlogo%2Ctitlescreen"
                print(url)
//                "https://api.thegamesdb.net/v1/Games/Images?apikey=\(apiKey)&games_id=\(gameData)&filter%5Btype%5D=clearlogo%20%2C%20fanart")!
                var requestHeader = URLRequest.init(url: url)
                requestHeader.httpMethod = "GET"
                requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
                URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
                    
                    if error == nil {
                        do {
                            let json = String(data:data!, encoding: .utf8)
                            print("\(json)")
                            print("gameData = \(gameData)")
//                             self.gameDataImages
                            if let jsonDecodedGameImages = try JSONDecoder().decode(GameDBData?.self, from: data!) {
                                self.gameImageData = jsonDecodedGameImages.data?.images.innerArray["\(gameData)"]
                                self.gametestImageData = jsonDecodedGameImages.data?.images.innerArray["\(gameData)"]?[0]
                                print("inside downloadGameImageJSON-gameImageData = \(self.gameImageData)")
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
    
    
     func downloadDevelopersJSON(completed: @escaping () -> () ) {
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
        
        URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
            
            if error != nil {
                print("error = \(error)")
                completed()
            }
            
            if error == nil {
                do {
                    print("error = nil")
                    let json = String(data: data!, encoding: .utf8)
                    
                    print(json)
                    
                    if let jsonDecodedPlatforms = try JSONDecoder().decode(ByPlatformIDData?.self, from: data!) {
                        
                        print(jsonDecodedPlatforms)
                        let decodedJSON = jsonDecodedPlatforms.data?.games
                        self.boxart = jsonDecodedPlatforms.include.boxart
                        self.baseURL = jsonDecodedPlatforms.include.boxart.baseURL
                        self.page = jsonDecodedPlatforms.pages
                        
                        if let parseJSON = decodedJSON {
                     
                            var items = self.games
                            var boxarts = self.imageArray
                            items.append(contentsOf: parseJSON)
                            
                            if self.initialOffset < items.count {
                                self.games = items
                                self.imageArray = boxarts
                                self.initialOffset = items.count
                                
                            } else {
                                self.games = items
                                self.imageArray = boxarts
                            }
                            
                            
                        }
                        
                        
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
    
    
}
