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

protocol ModalDelegate {
    func changeValue(value: [String], platformID: Int?)
}

protocol AgeRangeDelegate {
    func changeDateRange(dateRange: [Int], platformID: Int)
}

protocol MaxPlayerDelegate {
    
    func changeMaxPlayerRange(playerRange: [Int], platformID: Int)
}

class OwnedGamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, OwnedGameDelegate, ModalDelegate, AgeRangeDelegate, MaxPlayerDelegate, UISearchResultsUpdating {

    

    
    
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
    var filterSelections : [String] = []
    var dateSelections : [Int] = []
    var playerSelections : [Int] = []
    var asecending = true
    var ageRangeVC : AgeRangeVC?
    var maxPlayerVC: PlayerFilterVC?
//    var delegate : FilterDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("platformID \(platformID)")
//        delegate?.getPlatformID(platformID: platformID)
//        var filterButton = UIBarButtonItem(
//            title: "Filter",
//            style: .plain,
//            target: self,
//            action: "selectFilter:"
//        )
//        var ageRangeVC = AgeRangeVC()
//
//        ageRangeVC.delegate = self
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = search
        let logo = UIImage(named: "glogo44")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        if self.traitCollection.userInterfaceStyle == .light {
       
               tableView.backgroundColor = UIColor(red: (246/255), green: (246/255), blue: (246/255), alpha: 1)
             
           } else {

               tableView.backgroundColor = UIColor(red: (15/255), green: (15/255), blue: (15/255), alpha: 1)

       }
//
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: makeBackButton())
        
        if let filterViewController = UIStoryboard(
            name: "Main",
            bundle: nil).instantiateViewController(withIdentifier: "FilterVC") as? FilterVC {
            filterVC = filterViewController
        } else {
            print("Can't load VC. Check name")
        }
        
        if let ageRangeViewController = UIStoryboard(
            name: "Main",
            bundle: nil).instantiateViewController(withIdentifier: "AgeRange") as? AgeRangeVC {
            ageRangeVC = ageRangeViewController
        } else {
            print("Can't load VC. Check name")
        }
        
        if let playerRangeViewController = UIStoryboard(
            name: "Main",
            bundle: nil).instantiateViewController(withIdentifier: "PlayerRange") as? PlayerFilterVC {
            maxPlayerVC = playerRangeViewController
        } else {
            print("Can't load VC. Check name")
        }
        
        
        
        let filterAction = UIAction(title: "") { action in
            //Enter your Button Action Code here
        }
        
        let firstAction = UIAction(
            title: "All Games",
            image: UIImage(systemName: "dpad")
        ) { action in
            
            self.ownedGames = self.persistenceManager.fetchGame(SavedGames.self, platformID: self.platformID, selectedGenres: nil)
            self.tableView.reloadData()
        }
        
        
        let secondAction = UIAction(
            title: "Filter by genre",
            image: UIImage(systemName: "book")
        ) { [weak self] action in
            
            guard let viewController = self?.filterVC else {
            print("something wrong")
            return }
            viewController.id = self?.platformID!
        viewController.delegate = self
        self?.present(viewController, animated: true, completion: nil)
//            self?.filterVC?.modalPresentationStyle = .overCurrentContext

        }
        
        
        let thirdAction = UIAction(
            title: "Filter by release date",
            image: UIImage(systemName: "calendar")
        ) { action in
            guard let viewController = self.ageRangeVC else {
                print("something wrong")
                return }
            viewController.id = self.platformID!
            viewController.delegate = self
            self.present(viewController, animated: true, completion: nil)
            
            
//            self.ageRangeVC?.modalPresentationStyle = .overCurrentContext
            

            
            
        }
        
        let fourthAction = UIAction(
            title: "Filter by number of players",
            image: UIImage(systemName: "person.3")
        ) { action in
            guard let viewController = self.maxPlayerVC else {
                print("something wrong")
                return }
            viewController.id = self.platformID!
            viewController.delegate = self
            self.present(viewController, animated: true, completion: nil)
            
//            self.maxPlayerVC?.modalPresentationStyle = .overCurrentContext

            
            
            
            
            
        }
        
        let filterMenu = UIMenu(title: "", children: [firstAction, secondAction, thirdAction, fourthAction])
        var filterButton : UIBarButtonItem?
        
        if #available(iOS 14.0, *) {
             filterButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle"), menu: filterMenu)
            
//            navigationItem.rightBarButtonItem = filterButton
        } else {
            // Fallback on earlier versions
        }
        let sortbutton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(self.selectSort))
        
        self.navigationItem.rightBarButtonItems = [filterButton!, sortbutton]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("filterSelects \(filterSelections)")
        
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
        print("filterSelections")
        print(filterSelections)
        cell?.index = indexPath
        savedGameIndex = indexPath
        cell?.id = Int(ownedGames[indexPath.row].gameID)
        cell?.delegate = self
        cell?.gameName = ownedGames[indexPath.row].title
        cell?.platformID = Int(ownedGames[indexPath.row].platformID)
        cell?.platformName = ownedGames[indexPath.row].platformName
        if let boxartImageURL = ownedGames[indexPath.row].boxartImageURL {
            let urlString = ImageURL.small.rawValue + boxartImageURL
            print(urlString)
        var url = URL(string: urlString)!
        cell?.boxartImageView.setImageAnimated(imageUrl: url, placeholderImage: UIImage(named: "noArtNES")!)
        } else {
            print(ownedGames[indexPath.row])
        }
        cell?.boxartShadowImageView.image = cell?.boxartImageView.image
        cell?.gameTitleLabel.text = ownedGames[indexPath.row].title! + "\(ownedGames[indexPath.row].platformID)"
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
        let lightBlue = UIColor(red: 43/255, green: 149/255, blue: 206/255, alpha: 1)
        let backButton = UIButton(type: .custom)
        backButton.tintColor = lightBlue
        backButton.setTitle("  Back", for: .normal)
        backButton.setTitleColor(lightBlue, for: .normal)
        backButton.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
        return backButton
    }
    
    @objc func backButtonPressed() -> Void {
        print("back button pressed")
//        dismiss(animated: true, completion: nil)
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: false)
//        tabBarController?.dismiss(animated: true, completion: nil)
//        navigationController?.popViewController(animated: true)
    }
    
    @objc func selectSort() -> Void {
        print("sort button pressed")
        
        if asecending {
            ownedGames.sort(by: {$0.title! > $1.title!} )
            self.asecending = false
            print("Sorting is asecending = \(self.asecending)")
            tableView.reloadData()
            }
         else {
            
    ownedGames.sort(by: {$0.title! < $1.title!} )
            self.asecending = true
            print("Sorting is asecending = \(self.asecending)")
            tableView.reloadData()
        }
        
    }
    
//    func segueToFilterVC() {
//        let filterVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
//        filterVC.modalPresentationStyle = .overCurrentContext
//        self.present(filterVC, animated: true, completion: nil)
//
//
//    }
    
    func changeMaxPlayerRange(playerRange: [Int], platformID: Int) {
        print("changeDateRange called")
        self.playerSelections = playerRange
        if platformID != nil {
            self.ownedGames = persistenceManager.fetchFilteredByPlayers(SavedGames.self, platformID: platformID, playerRange: playerRange)
        }
        tableView.reloadData()
        print("changeDateRange called")

    }
    
    
    func changeDateRange(dateRange: [Int], platformID: Int) {
        print("changeDateRange called")
        self.dateSelections = dateRange
        if platformID != nil {
            self.ownedGames = persistenceManager.fetchFilteredByReleaseDate(SavedGames.self, platformID: platformID, dateRange: dateRange)
        }
        tableView.reloadData()
        print("changeDateRange called")

    }
    
    func changeValue(value: [String], platformID: Int?) {
        self.filterSelections = value
        print("changeValue called through protocal")
//        self.ownedGames = persistenceManager.fetchFilteredByGenre(SavedGames.self, genres: filterSelections)
        if platformID != nil {
            print("platformID changeValue \(platformID!)")
        self.ownedGames = persistenceManager.fetchGame(SavedGames.self, platformID: platformID!, selectedGenres: filterSelections)

        } else {
            self.ownedGames = persistenceManager.fetchGame(SavedGames.self, platformID: nil, selectedGenres: filterSelections)

        }
        
        tableView.reloadData()

        print("modal delegate filter selections \(self.filterSelections)")
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
        if platformID != nil {
            if text == "" {
                
                self.ownedGames = self.persistenceManager.fetchGame(SavedGames.self, platformID: self.platformID, selectedGenres: nil)
                
            } else {
            
        self.ownedGames = persistenceManager.fetchFilteredByName(SavedGames.self, name: text, platformID: platformID!)
            }
        } else {
            print("Search--Invalid Platform ID")
        }
        print(self.ownedGames)
        tableView.reloadData()
    }
    
    
}
