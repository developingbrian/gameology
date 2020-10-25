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
    var ownedGames: [SavedGames] = [SavedGames]()
    var indexPath: IndexPath?
    var selectedGameID: String?
    let network = Networking()
    var savedPlatforms: [Platform] = [Platform]()
    var savedGameIndex: IndexPath = [0,0]
    var gameName: String?
    var platformID: Int?
    var filterVC: FilterVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("platformID \(platformID)")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Filter",
            style: .plain,
            target: self,
            action: "selectFilter:"
        )
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: makeBackButton())
        
        if let filterViewController = UIStoryboard(
            name: "Main",
            bundle: nil).instantiateViewController(withIdentifier: "FilterVC") as? FilterVC {
            filterVC = filterViewController
        } else {
            print("Can't load VC. Check name")
        }
        
        let filterAction = UIAction(title: "") { action in
            //Enter your Button Action Code here
        }
        
        let firstAction = UIAction(title: "Filter by name", image: UIImage(systemName: "doc.on.doc")) { action in  }
        let secondAction = UIAction(title: "Filter by genre", image: UIImage(systemName: "pencil")) { action in
            self.navigationController?.present(self.filterVC!, animated: true, completion: nil)
        }
        let thirdAction = UIAction(
            title: "Filter by release date",
            image: UIImage(systemName: "plus.square.on.square")
        ) { action in }
        
        let fourthAction = UIAction(
            title: "Filter by number of players",
            image: UIImage(systemName: "folder")
        ) { action in }
        
        let filterMenu = UIMenu(title: "", children: [firstAction, secondAction, thirdAction, fourthAction])
        
        if #available(iOS 14.0, *) {
            let filterButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down"), menu: filterMenu)
            navigationItem.rightBarButtonItem = filterButton
        } else {
            // Fallback on earlier versions
        }
        
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if platformID! == 0 {
            ownedGames = persistenceManager.fetchAscending(SavedGames.self)
        } else {
            ownedGames = persistenceManager.fetchGameFilteredByPlatform(SavedGames.self, platformID: platformID!)
        }
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
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
        cell?.boxartShadowImageView.image = cell?.boxartImageView.image
        cell?.gameTitleLabel.text = ownedGames[indexPath.row].title
        cell?.releaseDateLabel.text = ownedGames[indexPath.row].releaseDate
        cell?.developerLabel.text = ownedGames[indexPath.row].developerName
        let platformName = self.setPlatformIcon(platformID: Int(self.ownedGames[indexPath.row].platformID), mode: self.traitCollection.userInterfaceStyle)
        cell?.platformImage.image = UIImage(named: platformName)
        return cell!
    }
    
    
    func removeFromLibrary(index: IndexPath) {
        deleteGameFromCoreData(index: index)
        ownedGames = persistenceManager.fetchGameFilteredByPlatform(SavedGames.self, platformID: platformID!)
        
        tableView.reloadData()
    }
    
    func fetchPlatformObject(platformID: Int) -> PlatformObject {
        let platform = PlatformObject(id: network.platforms["\(platformID)"]!.id, name: network.platforms["\(platformID)"]!.name, alias: network.platforms["\(platformID)"]!.alias, icon: network.platforms["\(platformID)"]!.icon, console: network.platforms["\(platformID)"]!.console, controller: network.platforms["\(platformID)"]?.controller, developer: network.platforms["\(platformID)"]?.developer, manufacturer: network.platforms["\(platformID)"]?.controller, media: network.platforms["\(platformID)"]?.media, cpu: network.platforms["\(platformID)"]?.cpu, memory: network.platforms["\(platformID)"]?.memory, graphics: network.platforms["\(platformID)"]?.graphics, sound: network.platforms["\(platformID)"]?.sound, maxcontrollers: network.platforms["\(platformID)"]?.maxcontrollers, display: network.platforms["\(platformID)"]?.display, overview: network.platforms["\(platformID)"]!.overview, youtube: network.platforms["\(platformID)"]?.youtube)
        
        return platform
        
    }
    
    func makeBackButton() -> UIButton {
        let backButton = UIButton(type: .custom)
        backButton.tintColor = .blue
        backButton.setTitle("  Back", for: .normal)
        backButton.setTitleColor(.blue, for: .normal)
        backButton.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
        return backButton
    }
    
    @objc func backButtonPressed() -> Void {
        dismiss(animated: true, completion: nil)
        
    }
    
    func segueToFilterVC() {
        let filterVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        self.navigationController?.present(filterVC, animated: true, completion: nil)
    }
}
