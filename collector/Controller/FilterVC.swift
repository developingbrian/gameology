//
//  FilterVC.swift
//  collector
//
//  Created by Brian on 10/23/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
 


//protocol SearchFilterDelegate {
//    func updatePlatformsFilter(platformSelections: [String])
//}


class FilterVC: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterByLbl: UILabel!
    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var platformSegmentedControl: UISegmentedControl!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var bottomStackView: UIStackView!
    let persistenceManager = PersistenceManager.shared
    let network = Networking.shared
    var genres : [String] = []

    var gameArray : [SavedGames] = []
    var genreArray : [String] = []
    var platformArray : [IGDBPlatform] = []
    var selectedItems : [String] = []
    var delegate: ModalDelegate?
    var platformFilterDelegate: SearchFilterDelegate?

    var genreSearchDelegate : GenreSearchDelegate?
    var platformSearchDelegate : PlatformSearchDelegate?
    var ageSearchDelegate : AgeSearchDelegate?
    
    var id : Int?
    var dataSource : [String] = []
    var consoleArray: [String] = []
    var portableArray: [String] = []
    var selectedPlatforms: [String] = []
    var selectedGenres: [String] = []
    var genreBackup : [String] = []
    var platformBackup : [String] = []
    let masterConsoles = ["3DO Interactive Multiplayer", "Amiga CD32", "Atari 2600", "Atari 5200", "Atari 7800", "Atari Jaguar", "ColecoVision", "Fairchild Channel F", "Intellivision", "Magnavox Odyssey", "Microsoft Xbox", "Microsoft Xbox 360", "Microsoft Xbox One", "Microsoft Xbox Series S|X", "Neo Geo AES", "Neo Geo CD", "Nintendo Entertainment System (NES)", "Super Nintendo Entertainment System (SNES)", "Nintendo Virtual Boy", "Nintendo 64", "Nintendo GameCube", "Nintendo Wii", "Nintendo Wii U", "Nintendo Switch", "Nuon", "TurboGrafx-16/PC Engine", "PC Engine SuperGrafx","Philips CD-i", "Sega Master System", "Sega Genesis/Mega Drive", "Sega CD", "Sega 32X", "Sega Saturn", "Sega Dreamcast", "Sega Pico", "Sony PlayStation", "Sony PlayStation 2", "Sony PlayStation 3", "Sony PlayStation 4", "Sony PlayStation 5", "Vectrex", "Zeebo"]
    let masterPortables = ["Atari Lynx", "Neo Geo Pocket", "Neo Geo Pocket Color", "Nintendo Game & Watch", "Nintendo Game Boy", "Nintendo Game Boy Color", "Nintendo Game Boy Advance", "Nintendo DS", "Nintendo DSi", "Nintendo 3DS", "New Nintendo 3DS", "Nokia N-Gage", "Sega Game Gear", "Sony PlayStation Portable (PSP)", "Sony PlayStation Vita", "WonderSwan", "WonderSwan Color" ]
//    var platformDelegate : SearchFilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.allowsMultipleSelection = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
//        backgroundView.layer.shadowOpacity = 0.8
//        backgroundView.layer.shadowRadius = 10
//        backgroundView.layer.shadowColor = UIColor.gray.cgColor
//        backgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cancelButton.layer.cornerRadius = 5
        cancelButton.layer.maskedCorners = [ .layerMinXMaxYCorner]
        cancelButton.clipsToBounds = true
        topStackView.layer.cornerRadius = 10
        topStackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        topStackView.clipsToBounds = true
        topLabel.layer.cornerRadius = 10
        topLabel.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        topLabel.clipsToBounds = true
        topStackView.clipsToBounds = true
        submitButton.clipsToBounds = true
        submitButton.layer.cornerRadius = 5
        submitButton.layer.maskedCorners = [.layerMaxXMaxYCorner]
        bottomStackView.clipsToBounds = true
        bottomStackView.layer.cornerRadius = 10
        bottomStackView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

        setDataSource()
        setAppearance()
   
        tableView.reloadData()
    }
    
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        if selectedGenres.count == 0 && genreBackup.count > 0 {
            selectedGenres = genreBackup
        }
        
        if selectedPlatforms.count == 0 && platformBackup.count > 0 {
            selectedPlatforms = platformBackup
        }
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func submitButtonPressed(_ sender: Any) {
        if network.sourceTag == 0 {
        delegate?.changeValue(value: selectedGenres, platformID: id)
//
        }
        
        
        if network.sourceTag == 1 {
        print("network sourcetag is 1")
        platformFilterDelegate?.updatePlatformsFilter(platformSelections: selectedPlatforms )
        }
        

        if network.sourceTag == 2 {
            print("network sourcetag is 2")

            genreSearchDelegate?.updateSearchGenres(genres: selectedGenres)
        }

        if network.sourceTag == 3 {
            print("network sourcetag is 3")
            print("count", selectedPlatforms.count)
            for platform in selectedPlatforms {
                print(platform)
            }
//            print("platformsearchdelegate", platformSearchDelegate)
            platformSearchDelegate?.updateSearchPlatforms(platforms: selectedPlatforms)
        }
      
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
//        self.navigationController?.popViewController(animated: true)
        print("submit button pressed")
    
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: view)
            print(position)
        }
    }
    
    
    
    func uniqueElementsFrom(array: [String]) -> [String] {
        //Create an empty Set to track unique items
        var set = Set<String>()
        let result = array.filter {
            guard !set.contains($0) else {
                //If the set already contains this object, return false
                //so we skip it
                return false
            }
            //Add this item to the set since it will now be in the array
            set.insert($0)
            //Return true so that filtered array will contain this item.
            return true
        }
        return result
    }
    
    
    
    func setDataSource() {
        dataSource.removeAll()
        
        if network.sourceTag == 0 {
            // use genre data source
            filterByLbl.text = "Select Genre(s)"
            platformSegmentedControl.isHidden = true

            let gameArray = persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, platformID: nil, selectedGenres: nil, selectedPlatforms: nil, selectedDateRange: nil)
         
        var array: [String] = []
        
            for game in gameArray {
            print(game)
                if let genres = game.genres {
            array.append(contentsOf: genres)
                }
        }
        
        genreArray = uniqueElementsFrom(array: array)

        dataSource = genreArray
            
            
        } else if network.sourceTag == 2 {
            filterByLbl.text = "Select Genre(s)"
            platformSegmentedControl.isHidden = true

            let genreArray = uniqueElementsFrom(array: genres)
            
            dataSource = genreArray
            
        } else if network.sourceTag == 3 {
            var consoles : [String] = []
            var portables : [String] = []
        
            for platform in network.platforms {
                if network.consolePlatforms.contains(platform.name) {
                    consoles.append(platform.name)
                } else {
                    
                    portables.append(platform.name)
                }
                

            }
            
            
            
            var prettyConsoles : [String] = []
            var prettyPortables : [String] = []

            for console in consoles {
                
                let title = formatIGDBToPrettyTitle(platformName: console)
                prettyConsoles.append(title)
            }
            
            for portable in portables {
                let title = formatIGDBToPrettyTitle(platformName: portable)
                prettyPortables.append(title)
            }
            
            
            let tempConsole = masterConsoles.filter { prettyConsoles.contains($0) }
            let tempPortable = masterPortables.filter { prettyPortables.contains($0) }
            consoleArray = uniqueElementsFrom(array: tempConsole)
            
            portableArray = uniqueElementsFrom(array: tempPortable)
            
            
            dataSource = consoleArray
            platformSegmentedControl.isHidden = false

            
        }else {
            filterByLbl.text = "Select Platform(s)"

            let gameArray = persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, platformID: 0, selectedGenres:  nil, selectedPlatforms: nil, selectedDateRange: nil)
            var consoles : [String] = []
            var portables : [String] = []
            

            for game in gameArray {
                if let platformName = game.platformName {
                if network.consolePlatforms.contains(platformName) {
                    consoles.append(platformName)
                    
                } else {
                    
                    portables.append(platformName)
                }

            }
            }
            var prettyConsoles : [String] = []
            var prettyPortables : [String] = []
            
            for console in consoles {
                
                let title = formatIGDBToPrettyTitle(platformName: console)
                prettyConsoles.append(title)
            }
            
            for portable in portables {
                let title = formatIGDBToPrettyTitle(platformName: portable)
                prettyPortables.append(title)
            }
            let tempConsole = masterConsoles.filter { prettyConsoles.contains($0) }
            let tempPortable = masterPortables.filter { prettyPortables.contains($0) }
            consoleArray = uniqueElementsFrom(array: tempConsole)
            
            portableArray = uniqueElementsFrom(array: tempPortable)
            
            
            dataSource = consoleArray
            platformSegmentedControl.isHidden = false

        }
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
            backgroundView.backgroundColor = lightGray
//            topStackView.backgroundColor = lightGray
            //            topLbl.backgroundColor = lightGray
//            filterByLbl.backgroundColor = lightGray
            

        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
            tableView.backgroundColor = darkGray
            backgroundView.backgroundColor = darkGray

//            topStackView.backgroundColor = darkGray

//            topLbl.backgroundColor = darkGray
//            filterByLbl.backgroundColor = darkGray
        }
    }
    
    @IBAction func platformIndexDidChange(_ sender: Any) {
    
        switch platformSegmentedControl.selectedSegmentIndex {
        
        case 0:
            dataSource = consoleArray
            print(dataSource)
            tableView.reloadData()
            
        case 1:
            dataSource = portableArray
            print(dataSource)
            tableView.reloadData()
        default:
            break
        
        }
    }
    
    @IBAction func didPressRemoveFilter(_ sender: Any) {
        
        if network.sourceTag == 0 || network.sourceTag == 2 {
            genreBackup = selectedGenres
            selectedGenres.removeAll()
        }
        
        if network.sourceTag == 1 || network.sourceTag == 3{
            platformBackup = selectedPlatforms
            selectedPlatforms.removeAll()
            
        }
        tableView.reloadData()
    }
}



extension FilterVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as? FilterVCTableViewCell else {
            fatalError("Cannot connect to cell")
            
        }
        
        cell.filterChoice = dataSource[indexPath.row]
        
        
        if network.sourceTag == 0 || network.sourceTag == 2 {
        
        for item in selectedGenres {
            if cell.filterChoice == item {
                print("\(item) is already selected")
                cell.setSelected(true, animated: false)
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                print(cell.isSelected)
                print(selectedGenres)
                
            }
        }
        }
        
        
        if network.sourceTag == 1 || network.sourceTag == 3 {
            for item in selectedPlatforms {
                if cell.filterChoice == item {
                    print("\(item) is already selected")
                    cell.setSelected(true, animated: false)
                    self.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                    print(cell.isSelected)
                    print(selectedPlatforms)
                    
                }
            
        }
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FilterVCTableViewCell
        if cell.isSelected {
            if network.sourceTag == 0 || network.sourceTag == 2 {
                selectedGenres.append(cell.filterChoiceLbl.text!)
                print(selectedGenres)

            }
            
            if network.sourceTag == 1 || network.sourceTag == 3 {
                
                selectedPlatforms.append(cell.filterChoiceLbl.text!)
                print(selectedPlatforms)

            }
            
            
  
        }
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FilterVCTableViewCell
        if cell.isSelected == false {
            
            if network.sourceTag == 0 || network.sourceTag == 2 {
            selectedGenres.removeAll { $0 == "\(cell.filterChoiceLbl.text!)" }
                print(selectedGenres)

            }
            
            if network.sourceTag == 1 || network.sourceTag == 3 {
                selectedPlatforms.removeAll { $0 == "\(cell.filterChoiceLbl.text!)" }
                print(selectedPlatforms)

                
            }
        }
        
    }
    
    
}
