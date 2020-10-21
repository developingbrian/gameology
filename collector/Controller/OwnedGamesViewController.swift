//
//  OwnedGamesViewController.swift
//  collector
//
//  Created by Brian on 10/11/20.
//  Copyright © 2020 Brian. All rights reserved.
//
import Foundation
import UIKit
import CoreData



class OwnedGamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, OwnedGameDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var platformImage: UIImageView!
    
    let persistenceManager = PersistenceManager.shared
    var ownedGames : [SavedGames] = [SavedGames]()
    var indexPath: IndexPath?
    var selectedGameID: String?
    let network = Networking()
//    var savedGames : [SavedGames] = [SavedGames]()
    var savedPlatforms: [Platform] = [Platform]()
    var savedGameIndex: IndexPath = [0,0]
    var gameName : String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: "selectFilter:")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        ownedGames = persistenceManager.fetchAscending(SavedGames.self)
//            persistenceManager.fetch(SavedGames.self)
        
        
        
        if self.traitCollection.userInterfaceStyle == .light {
       
               tableView.backgroundColor = UIColor(red: (246/255), green: (246/255), blue: (246/255), alpha: 1)
             
           } else {

               tableView.backgroundColor = UIColor(red: (15/255), green: (15/255), blue: (15/255), alpha: 1)

       }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        ownedGames = persistenceManager.fetchAscending(SavedGames.self)
//            persistenceManager.fetch(SavedGames.self)
        tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ownedGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ownedGamesCell", for: indexPath) as? OwnedGamesVCTableViewCell
        
        cell?.index = indexPath
        savedGameIndex = indexPath
        cell?.id = Int(ownedGames[indexPath.row].gameID)
        cell?.delegate = self
        cell?.gameName = ownedGames[indexPath.row].title
        cell?.platformID = Int(ownedGames[indexPath.row].platformID)
        cell?.platformName = ownedGames[indexPath.row].platformName
        var urlString = ImageURL.small.rawValue + ownedGames[indexPath.row].boxartImageURL!
        print(urlString)
        var url = URL(string: urlString)!
        cell?.boxartImageView.setImageAnimated(imageUrl: url, placeholderImage: UIImage(named: "noArtNES")!)
//        cell?.boxartShadowImageView.setImageAnimated(imageUrl: url, placeholderImage: UIImage(named: "noArtNES")!)
        cell?.boxartShadowImageView.image = cell?.boxartImageView.image
        cell?.gameTitleLabel.text = ownedGames[indexPath.row].title
        cell?.releaseDateLabel.text = ownedGames[indexPath.row].releaseDate
        cell?.developerLabel.text = ownedGames[indexPath.row].developerName
        let platformName = self.setPlatformIcon(platformID: Int(self.ownedGames[indexPath.row].platformID), mode: self.traitCollection.userInterfaceStyle)
        cell?.platformImage.image = UIImage(named: platformName)
//        cell?.genreLabel.text = ownedGames[indexPath.row].genre
//        cell?.ratingLabel.text = ownedGames[indexPath.row].rating
        
        
        
        return cell!
    }
    
    
    func removeFromLibrary(index: IndexPath) {
        deleteGameFromCoreData(index: index)
//        persistenceManager.delete(ownedGames[index.row])
        ownedGames = persistenceManager.fetchAscending(SavedGames.self)
        tableView.reloadData()
        
//        for currentGame in ownedGames {
//
//            if currentGame.title == ownedGames[index.row].title && currentGame.gameID == ownedGames[index.row].gameID {
//                let savedPlatform = persistenceManager.fetch(Platform.self)
//                let platformName = ownedGames[index.row].platformName ?? ""
//                let platformID = Int(ownedGames[index.row].platformID)
//
//                if savedPlatform.count >= 1 {
//
//                if checkForPlatformInLibrary(name: platformName, id: platformID) {
//                    print("Platform already exists--retreiving and adding game to platform")
//                    let existingPlatform = fetchCoreDataPlatformObject(id: platformID)
//                    print("existing platform is \(existingPlatform)")
//                    existingPlatform.addToGames(currentGame)
//
//                }
//                else {
//                    print("Platform doesnt exist--creating platform then adding game to platform")
//                   savePlatformToCoreData(platformID)
//                    let newPlatform = fetchCoreDataPlatformObject(id: platformID)
//                    print("new platform is \(newPlatform)")
//                    newPlatform.addToGames(currentGame)
//                }
//
//                } else {
//                    print("Platform doesnt exist--creating platform then adding game to platform")
//                   savePlatformToCoreData(platformID)
//                    let newPlatform = fetchCoreDataPlatformObject(id: platformID)
//                    print("new platform is \(newPlatform)")
//                    newPlatform.addToGames(currentGame)
//                }
                
                

            
            }
    
    func fetchPlatformObject(platformID: Int) -> PlatformObject {
        let platform = PlatformObject(id: network.platforms["\(platformID)"]!.id, name: network.platforms["\(platformID)"]!.name, alias: network.platforms["\(platformID)"]!.alias, icon: network.platforms["\(platformID)"]!.icon, console: network.platforms["\(platformID)"]!.console, controller: network.platforms["\(platformID)"]?.controller, developer: network.platforms["\(platformID)"]?.developer, manufacturer: network.platforms["\(platformID)"]?.controller, media: network.platforms["\(platformID)"]?.media, cpu: network.platforms["\(platformID)"]?.cpu, memory: network.platforms["\(platformID)"]?.memory, graphics: network.platforms["\(platformID)"]?.graphics, sound: network.platforms["\(platformID)"]?.sound, maxcontrollers: network.platforms["\(platformID)"]?.maxcontrollers, display: network.platforms["\(platformID)"]?.display, overview: network.platforms["\(platformID)"]!.overview, youtube: network.platforms["\(platformID)"]?.youtube)

        return platform
        
    }
    
    
    
                
        }
    

    

