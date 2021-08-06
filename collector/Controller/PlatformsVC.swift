//
//  PlatformsVC.swift
//  collector
//
//  Created by Brian on 10/21/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit

class PlatformsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
        @IBOutlet weak var ownedGamesLabel: UILabel!
    
    let persistenceManager = PersistenceManager.shared
    var ownedGames : [SavedGames] = [SavedGames]()
    var selectedGameID: String?
    let network = Networking.shared
    var savedPlatforms: [Platform] = [Platform]()
    var savedGameIndex: IndexPath = [0,0]
    var segueID : Int?
    let fields = "players,publishers,genres,overview,last_updated,rating,platform,coop,youtube,os,processor,ram,hdd,video,sound,alternates"
    let include = "boxart,platform"

    override func viewWillAppear(_ animated: Bool) {

        savedPlatforms.removeAll()
        savedPlatforms = persistenceManager.fetchPlatformsAscending(Platform.self)
        
        setAppearance()
        setTotalOwnedLabel()
        createAllPlatformsSection()
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsSelection = true
        
        setAppearance()
        createTitleViewImage()

        tableView.reloadData()
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? OwnedGamesViewController {
//            print("segueID \(segueID)")
            destination.platformID = segueID!
            
        }
    }
    
    
    func createAllPlatformsSection() {
        
        let allPlatforms = savedPlatforms.filter({$0.name == "0All Games"})
      
        if savedPlatforms.count > 0 {
        if allPlatforms.count < 1 {
            //if all platform object does not exist, create it and add it to the beginning of the array
            let allGamesObject = Platform(context: persistenceManager.context)
            
            allGamesObject.name = "0All Games"
            allGamesObject.id = 0
            savedPlatforms.insert(allGamesObject, at: 0)
        } else if allPlatforms.count > 0 && savedPlatforms.count == 1{
            //if there is only 1 saved platform, remove the all platform object
            savedPlatforms.remove(at: 0)
            
        }
        } else {
            //if all other platforms removed, remove the all platform object
            if allPlatforms.count > 0 {
                savedPlatforms.remove(at: 0)
                
            }
            
            
        }
    }

    func createTitleViewImage() {
        
        self.title = "Library"
        let logo = UIImage(named: "glogo44")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    
    func setTotalOwnedLabel() {
        
        var count = 0

        for platform in savedPlatforms {
//            print("owned games count is",platform.games?.count)
            count += platform.games!.count
        }

        ownedGamesLabel.text = "\(count)"
        
    }
    
    
    func fetchPlatformObject(platformID: Int) -> PlatformObject {

        var platform = PlatformObject(id: 0, abbreviation: nil, alternativeName: nil, category: nil, createdAt: nil, generation: nil, name: "", platformLogo: nil, platformFamily: nil, slug: nil, updatedAt: nil, url: nil, versions: nil, checksum: nil)
        
        let platforms = network.platforms
        
        for platformObject in platforms {
            
            if platformObject.id == platformID {
                
                 platform = PlatformObject(id: platformObject.id, abbreviation: platformObject.abbreviation, alternativeName: platformObject.alternativeName, category: platformObject.category, createdAt: platformObject.createdAt, generation: platformObject.generation, name: platformObject.name, platformLogo: nil, platformFamily: platformObject.platformFamily, slug: platformObject.slug, updatedAt: platformObject.updatedAt, url: platformObject.url, versions: nil, checksum: platformObject.checksum)
               
            }
        }
        
        return platform
        
    }
    
    
    func segueToOwnedGames() {
        
        let ownedGamesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ownedGames") as! OwnedGamesViewController
        ownedGamesVC.hidesBottomBarWhenPushed = false
        ownedGamesVC.platformID = segueID!
//        let platformsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "platforms") as! PlatformsVC
        
        self.navigationController!.pushViewController(ownedGamesVC, animated: false)
        
    }
    
    func setAppearance() {
        
        let defaults = UserDefaults.standard
        let appearanceSelection = defaults.integer(forKey: "appearanceSelection")

        
        if appearanceSelection == 0 {
            self.navigationController?.overrideUserInterfaceStyle = .unspecified
            self.tabBarController?.overrideUserInterfaceStyle = .unspecified
            overrideUserInterfaceStyle = .unspecified
        } else if appearanceSelection == 1 {
            overrideUserInterfaceStyle = .light
            self.navigationController?.overrideUserInterfaceStyle = .light
            self.tabBarController?.overrideUserInterfaceStyle = .light


        } else {
            overrideUserInterfaceStyle = .dark
            self.navigationController?.overrideUserInterfaceStyle = .dark
            self.tabBarController?.overrideUserInterfaceStyle = .dark

        }
        
        if traitCollection.userInterfaceStyle == .light {
            let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
            tableView.backgroundColor = lightGray
            view.backgroundColor = lightGray
            

        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
            tableView.backgroundColor = darkGray
            view.backgroundColor = darkGray
        }
    }
    
    func prepareData() {
        
        self.showSpinner(onView: self.view, userInterfaceStyle: traitCollection.userInterfaceStyle)
        self.network.fetchIGDBGenreData {
            
        
        self.network.fetchIGDBPlatformData {
            self.network.fetchIGDBGamesData(filterBy: "platforms = ", platformID: 18, searchByName: nil, sortByField: "name", sortAscending: true, offset: self.network.currentOffset, resultsPerPage: 20, completed: {
                print("data downloaded")
                self.network.currentOffset = self.network.gameArray.count
                self.tableView.reloadData()
                self.removeSpinner()
            })
        }
        }

}

}


extension PlatformsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        savedPlatforms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "platformCell", for: indexPath) as! PlatformsTableViewCell
        cell.savedPlatforms = savedPlatforms

        cell.game = savedPlatforms[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! PlatformsTableViewCell
        let platform = fetchCoreDataPlatformObject(id: Int(savedPlatforms[indexPath.row].id))

        print("platform.id \(Int(platform.id))")
        segueID = Int(savedPlatforms[indexPath.row].id)
//        print("segueID \(segueID)")

        segueToOwnedGames()
    }
    
}
