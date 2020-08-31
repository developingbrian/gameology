//
//  Service.swift
//  collector
//
//  Created by Brian on 3/21/20.
//  Copyright © 2020 Brian. All rights reserved.
//

//import Foundation
//
//class NetworkService {
//    
//    var currentPlatform : Int?
//    var currentGame : String?
//    var searchString: String?
//    var currentOffset : Int = 0
////    var games = [Game]()
//    var initialOffset = 0
//    
//    func downloadJSON(platformSelected: Int?, gameName: String?, offset: Int?, completed: @escaping () -> () ) {
//                // Downloading JSON data from the IGDB.com api and parse it for use as an object
//        
//        
//                print("downloadJSON() triggered")
//                let fields = "age_ratings.rating, age_ratings.category, genres.name,  cover.image_id, name, first_release_date, summary, involved_companies.company.name, total_rating, platforms.category, platforms, cover.id, popularity, platforms.versions.platform_logo.image_id, platforms.platform_logo.image_id, platforms.platform_logo.url, screenshots.image_id"
//                let gameCategory = "1"
//                let limit =  "100"
//                let sortField = "name"
//        
//                currentPlatform = platformSelected
//                currentGame = gameName
//        
//                if gameName != nil {
//                    searchString = "\"\(gameName!)\""
////                    searchString = gameName
//                    print(searchString!)
//                }
//        
//                var parameters = ""
//                if platformSelected != nil {
//                if currentOffset == 0 {
//                    parameters = "fields \(fields);\nlimit \(limit);\noffset 0;\nwhere platforms = \(platformSelected!);\nsort \(sortField) asc;"
//                } else {
//                    parameters = "fields \(fields);\nlimit \(limit);\noffset \(currentOffset);\nwhere platforms = \(platformSelected!);\nsort \(sortField) asc;" }
//        
//                } else if gameName != nil && currentOffset < 5000 {
//                    print("offset = \(offset)")
//                    parameters =  "fields \(fields);\nlimit \(limit);\nsearch \(searchString!);\noffset \(offset!);"}
//                let postData = parameters.data(using: .utf8)
//        
//                let url = URL(string: "https://api-v3.igdb.com/games/")!
//                let apiKey = "\(Constants.igdbAPIKey)"
//                var requestHeader = URLRequest.init(url: url )
//                requestHeader.httpBody = postData
//                requestHeader.httpMethod = "POST"
//                requestHeader.setValue(apiKey, forHTTPHeaderField: "user-key")
//                requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
//                print("line before URLSession working")
//                URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
//                    print("line after URLSession")
//                    print(data)
//                    if error != nil {
//                        print(error)
//                    }
//        
//                    if error == nil {
//                        do {
//                            let json = String(data: data!, encoding: .utf8)
//                            print("\(json)")
//        
//                            //                    self.games = try JSONDecoder().decode([Game].self, from: data!)
//        
//                            let decodedJSON = try JSONDecoder().decode([Game]?.self, from: data!)
//                            if let parseJSON = decodedJSON {
//        
//                                var items = self.games
//                                items.append(contentsOf: parseJSON)
//        
//        
//        
//                                if self.initialOffset < items.count {
//                                    self.games = items
//                                    self.initialOffset = items.count
//        
//        
//        
//                                } else {
//                                    self.games = items
//                                }
//                                //                        DispatchQueue.main.async {
//                                //                            self.tableView.reloadData()
//                                //                        }
//        
//                            }
//        
//        
//                            DispatchQueue.main.async {
//                                completed()
//                            }
//                        } catch {
//        
//                            print(error)
//        
//                        }
//                    }
//                }.resume()
//        
////                self.tableView.reloadData()
////
//        
//    }
//    
//
//}
//
////class Service {
////    private var state: State = .ready
////    private var page: Int = 0
////    private var request: URLSessionDataTask?
//// 
////    func reloadAllData() {
////        if state == .ready || state == .loadNext || state == .endOfContent {
////            page = 0
////            state = .reloading
////            cancelCurrentRequest()
////            fetch(page: self.page, callback: { [weak self] in
////                // fetched data
////            })
////        }
////    }
//// 
////    func fetchNextPage() {
////        if state == .ready {
////            state = .loadNext
////            fetch(page: self.page, callback: { [weak self] in
////                // fetched data
////            })
////        }
////    }
//// 
////    private func fetch(page: Int, callback: () -> Void) {
////
////        // API it's network layer
////        request = API.fetch({ [weak self] items in
////            if items.isEmpty {
////                self?.state = .endOfContent
////            } else {
////                self?.state = .none
////                self?.page += 1
////            }
////            callback()
////        })
////    }
//// 
////    func cancelCurrentRequest() {
////        request?.cancel()
////    }
////}
