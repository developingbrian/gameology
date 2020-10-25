//
//  PlatformsVC.swift
//  collector
//
//  Created by Brian on 10/21/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit

class PlatformsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let persistenceManager = PersistenceManager.shared
    var ownedGames : [SavedGames] = [SavedGames]()
//    var indexPath : IndexPath?
    var selectedGameID: String?
    let network = Networking()
    var savedPlatforms: [Platform] = [Platform]()
    var savedGameIndex: IndexPath = [0,0]
    var segueID : Int?


    override func viewWillAppear(_ animated: Bool) {
       

        savedPlatforms.removeAll()
        savedPlatforms = persistenceManager.fetchPlatformsAscending(Platform.self)
        
        let allPlatforms = savedPlatforms.filter({$0.name == "All Games"})
        if savedPlatforms.count > 0 {
        if allPlatforms.count < 1 {
            let allGamesObject = Platform(context: persistenceManager.context)
            allGamesObject.name = "All Games"
            allGamesObject.id = 0
            savedPlatforms.insert(allGamesObject, at: 0)
        } else if allPlatforms.count > 0 && savedPlatforms.count == 1{
            savedPlatforms.remove(at: 0)
            
        }
        } else {
            if allPlatforms.count > 0 {
                savedPlatforms.remove(at: 0)
                
            }
            
            
        }
        print(savedPlatforms)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsSelection = true

        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tap)
        

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
        savedPlatforms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "platformCell", for: indexPath) as? PlatformsTableViewCell
//        let platform = fetchPlatformObject(platformID: Int(savedPlatforms[indexPath.row].id))
        let platform = fetchCoreDataPlatformObject(id: Int(savedPlatforms[indexPath.row].id))
        print(platform.games?.count)
        print(savedPlatforms[indexPath.row].name)
        print(savedPlatforms[indexPath.row].games?.count)
        let platformName = self.setPlatformIcon(platformID: Int(savedPlatforms[indexPath.row].id), mode: self.traitCollection.userInterfaceStyle)
        cell?.platformBanner.image = UIImage(named: platformName)
        cell?.ownedTotalLbl.text = "\(platform.games!.count)"
        print("platform id = \(savedPlatforms[indexPath.row].id)")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PlatformsTableViewCell
        let platform = fetchCoreDataPlatformObject(id: Int(savedPlatforms[indexPath.row].id))

        print("platform.id \(Int(platform.id))")
        segueID = Int(savedPlatforms[indexPath.row].id)
        print("segueID \(segueID)")
//        performSegue(withIdentifier: "showPlatform", sender: self)
        segueToOwnedGames()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? OwnedGamesViewController {
            print("segueID \(segueID)")
            destination.platformID = segueID
            
        }
    }

    
    func fetchPlatformObject(platformID: Int) -> PlatformObject {
        print(network)
        print(platformID)
        print(network.platforms["\(platformID)"])
        
        let platform = PlatformObject(id: network.platforms["\(platformID)"]!.id, name: network.platforms["\(platformID)"]!.name, alias: network.platforms["\(platformID)"]!.alias, icon: network.platforms["\(platformID)"]!.icon, console: network.platforms["\(platformID)"]!.console, controller: network.platforms["\(platformID)"]?.controller, developer: network.platforms["\(platformID)"]?.developer, manufacturer: network.platforms["\(platformID)"]?.controller, media: network.platforms["\(platformID)"]?.media, cpu: network.platforms["\(platformID)"]?.cpu, memory: network.platforms["\(platformID)"]?.memory, graphics: network.platforms["\(platformID)"]?.graphics, sound: network.platforms["\(platformID)"]?.sound, maxcontrollers: network.platforms["\(platformID)"]?.maxcontrollers, display: network.platforms["\(platformID)"]?.display, overview: network.platforms["\(platformID)"]!.overview, youtube: network.platforms["\(platformID)"]?.youtube)

        return platform
        
    }
    
    
    func segueToOwnedGames() {
        
        let ownedGamesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ownedGames") as! OwnedGamesViewController
//        ownedGamesVC.modalPresentationStyle = .fullScreen
        ownedGamesVC.hidesBottomBarWhenPushed = false
        ownedGamesVC.platformID = segueID
        let platformsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "platforms") as! PlatformsVC
        
        self.navigationController!.pushViewController(ownedGamesVC, animated: true)
//        let navigationController = UINavigationController()
//        let navigationController = UINavigationController(rootViewController: ownedGamesVC)
//        navigationController.modalPresentationStyle = .fullScreen
//        navigationController.hidesBottomBarWhenPushed = false
//        self.present(navigationController, animated: true, completion: nil)
        
        
//        navigationController.pushViewController(ownedGamesVC, animated: true)
        
    }
    
    
}
