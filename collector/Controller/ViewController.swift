//
//  ViewController.swift
//  collector
//
//  Created by Brian on 3/10/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
import SDWebImage
import DropDown

class ViewController: UIViewController {
    
    
    @IBOutlet weak var platformPicker: UIPickerView!
    @IBOutlet weak var tableviewPlatformImage: UIImageView!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var dropDownView: UIButton!
    @IBOutlet weak var progressIndicator: UIProgressView!
    @IBOutlet weak var totalGamesDisplayedLbl: UILabel!
    @IBOutlet weak var progressCompleteLbl: UILabel!
    @IBOutlet weak var gameArrayCountLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    static let sectionHeaderElementKind = "section-header-element-kind"
    let network = Networking.shared
    let layoutButton = UIButton(type: .system)
    var altLayout = true
    var topSection = 0
    let failLabel = UILabel()
    let failRefreshBtn = UIButton()
    var wishList : [WishList] = [WishList]()
    var savedGames: [SavedGames] = [SavedGames]()
    var savedPlatforms: [Platform] = [Platform]()
    var savedGenres: [GameGenre] = [GameGenre]()
    let persistenceManager = PersistenceManager.shared
    static var savedGameIndex: IndexPath = [0,0]
    static var savedGame = GameObject()
    static var selectedGameIndex : IndexPath = IndexPath(row: 0, section: 0)
    var advancedSearchBtn = UIButton()
    var sortDirection : ComparisonResult = .orderedAscending
    var numericGames : [GameObject] = []
    let blueTint = UIColor(named: "color5")
    var tableTimer : Timer?
    let blueText = UIColor(red: 86/255, green: 164/255, blue: 210/255, alpha: 1)
    var aGames : [GameObject] = []
    var bGames : [GameObject] = []
    var cGames : [GameObject] = []
    var dGames : [GameObject] = []
    var eGames : [GameObject] = []
    var fGames : [GameObject] = []
    var gGames : [GameObject] = []
    var hGames : [GameObject] = []
    var iGames : [GameObject] = []
    var jGames : [GameObject] = []
    var kGames : [GameObject] = []
    var lGames : [GameObject] = []
    var mGames : [GameObject] = []
    var nGames : [GameObject] = []
    var oGames : [GameObject] = []
    var pGames : [GameObject] = []
    var qGames : [GameObject] = []
    var rGames : [GameObject] = []
    var sGames : [GameObject] = []
    var tGames : [GameObject] = []
    var uGames : [GameObject] = []
    var vGames : [GameObject] = []
    var wGames : [GameObject] = []
    var xGames : [GameObject] = []
    var yGames : [GameObject] = []
    var zGames : [GameObject] = []
    
    
    var gameArray : [GameObject] = [] {
        didSet {
            
            numericGames.removeAll()
            aGames.removeAll()
            bGames.removeAll()
            cGames.removeAll()
            dGames.removeAll()
            eGames.removeAll()
            fGames.removeAll()
            gGames.removeAll()
            hGames.removeAll()
            iGames.removeAll()
            jGames.removeAll()
            kGames.removeAll()
            lGames.removeAll()
            mGames.removeAll()
            nGames.removeAll()
            oGames.removeAll()
            pGames.removeAll()
            qGames.removeAll()
            rGames.removeAll()
            sGames.removeAll()
            tGames.removeAll()
            uGames.removeAll()
            vGames.removeAll()
            wGames.removeAll()
            xGames.removeAll()
            yGames.removeAll()
            zGames.removeAll()
            
            for game in gameArray {
                
                
                let titleCleaned = removeLeadingArticle(fromString: game.title!)
                
                if titleCleaned.first.flatMap({ Int(String($0)) }) != nil {
                    numericGames.append(game)
                }
                
                
                if titleCleaned.hasPrefix("A") || titleCleaned.hasPrefix("a") {
                    
                    aGames.append(game)
                }
                
                if titleCleaned.hasPrefix("B") || titleCleaned.hasPrefix("b") {
                    bGames.append(game)
                }
                
                if titleCleaned.hasPrefix("C") || titleCleaned.hasPrefix("c") {
                    cGames.append(game)
                }
                
                if titleCleaned.hasPrefix("D") || titleCleaned.hasPrefix("d") {
                    dGames.append(game)
                }
                
                if titleCleaned.hasPrefix("E") || titleCleaned.hasPrefix("e") {
                    eGames.append(game)
                }
                
                if titleCleaned.hasPrefix("F") || titleCleaned.hasPrefix("f") {
                    fGames.append(game)
                }
                
                if titleCleaned.hasPrefix("G") || titleCleaned.hasPrefix("g") {
                    gGames.append(game)
                }
                
                if titleCleaned.hasPrefix("H") || titleCleaned.hasPrefix("h") {
                    hGames.append(game)
                }
                
                if titleCleaned.hasPrefix("I") || titleCleaned.hasPrefix("i") {
                    iGames.append(game)
                }
                
                if titleCleaned.hasPrefix("J") || titleCleaned.hasPrefix("j") {
                    jGames.append(game)
                }
                
                if titleCleaned.hasPrefix("K") || titleCleaned.hasPrefix("k") {
                    kGames.append(game)
                }
                
                if titleCleaned.hasPrefix("L") || titleCleaned.hasPrefix("l") {
                    lGames.append(game)
                }
                
                if titleCleaned.hasPrefix("M") || titleCleaned.hasPrefix("m") {
                    
                    mGames.append(game)
                }
                
                if titleCleaned.hasPrefix("N") || titleCleaned.hasPrefix("n") {
                    nGames.append(game)
                }
                
                if titleCleaned.hasPrefix("O") || titleCleaned.hasPrefix("o") {
                    oGames.append(game)
                }
                
                if titleCleaned.hasPrefix("P") || titleCleaned.hasPrefix("p") {
                    pGames.append(game)
                }
                
                if titleCleaned.hasPrefix("Q") || titleCleaned.hasPrefix("q") {
                    qGames.append(game)
                }
                
                if titleCleaned.hasPrefix("R") || titleCleaned.hasPrefix("r") {
                    rGames.append(game)
                }
                
                if titleCleaned.hasPrefix("S") || titleCleaned.hasPrefix("s") {
                    sGames.append(game)
                }
                
                if titleCleaned.hasPrefix("T") || titleCleaned.hasPrefix("t") {
                    tGames.append(game)
                }
                
                if titleCleaned.hasPrefix("U") || titleCleaned.hasPrefix("u") {
                    uGames.append(game)
                }
                
                if titleCleaned.hasPrefix("V") || titleCleaned.hasPrefix("v") {
                    vGames.append(game)
                }
                
                if titleCleaned.hasPrefix("W") || titleCleaned.hasPrefix("w") {
                    wGames.append(game)
                }
                
                if titleCleaned.hasPrefix("X") || titleCleaned.hasPrefix("x") {
                    xGames.append(game)
                }
                
                if titleCleaned.hasPrefix("Y") || titleCleaned.hasPrefix("y") {
                    yGames.append(game)
                }
                
                if titleCleaned.hasPrefix("Z") || titleCleaned.hasPrefix("z") {
                    zGames.append(game)
                }
                
                
                
                
            }
            
            sortGameArrays()
            
            gameArrayCountLabel.text = String(gameArray.count)
            
            if network.endOfResults == true {
                if gameArray.count > 0 {
                    let currentCount = Float(self.gameArray.count)
                    let totalCount = Float(self.gameArray.count)
                    let progress = currentCount / totalCount
                    let progressPercent = progress * 100
                    let progressInteger = Int(progressPercent)
                    let progressString = String(progressInteger) + "%"
                    
                    progressCompleteLbl.text = progressString
                    progressIndicator.progress = progress
                }
                
                
                UIView.animate(withDuration: 2) {
                    self.search.searchBar.alpha = 1
                } completion: { complete in
                    self.search.searchBar.isUserInteractionEnabled = true
                }
                
            } else {
                
                let currentCount = Float(self.gameArray.count)
                let totalCount = Float(self.network.totalRequestCount)
                let progress = currentCount / totalCount
                let progressDecimal = String(format: "%.2f", progress)
                let progressPercent = String(Int((Double(progressDecimal)! * 100))) + "%"
                
                progressCompleteLbl.text = progressPercent
                progressIndicator.progress = progress
                
                
                UIView.animate(withDuration: 2) {
                    self.search.searchBar.alpha = 0.2
                    
                } completion: { complete in
                    self.search.searchBar.isUserInteractionEnabled = false
                    
                }
                
            }
        }
    }
    
    var segueObject : GameObject?
    var boxartImage : UIImage?
    let dropDown = DropDown()
    var platformsToFilter : [Int] = []
    var currentPlatformID = 18
    var currentPlatformName = ""
    let search = UISearchController(searchResultsController: nil)
    let platforms = ["3DO Interactive Multiplayer", "Amiga CD32", "Atari 2600", "Atari 5200", "Atari 7800", "Atari Jaguar", "Atari Lynx", "ColecoVision", "Fairchild Channel F", "Intellivision", "Magnavox Odyssey", "Microsoft Xbox", "Microsoft Xbox 360", "Microsoft Xbox One", "Microsoft Xbox Series S|X", "Neo Geo AES", "Neo Geo CD", "Neo Geo Pocket", "Neo Geo Pocket Color", "Nintendo Game & Watch", "Nintendo Entertainment System (NES)", "Super Nintendo Entertainment System (SNES)", "Nintendo Virtual Boy", "Nintendo 64", "Nintendo GameCube", "Nintendo Wii", "Nintendo Wii U", "Nintendo Switch", "Nintendo Game Boy", "Nintendo Game Boy Color", "Nintendo Game Boy Advance", "Nintendo DS", "Nintendo DSi", "Nintendo 3DS", "New Nintendo 3DS", "Nokia N-Gage", "Nuon", "TurboGrafx-16/PC Engine", "PC Engine SuperGrafx","Philips CD-i", "Sega Master System", "Sega Genesis/Mega Drive", "Sega CD", "Sega 32X", "Sega Saturn", "Sega Dreamcast", "Sega Game Gear", "Sega Pico", "Sony PlayStation", "Sony PlayStation 2", "Sony PlayStation 3", "Sony PlayStation 4", "Sony PlayStation 5", "Sony PlayStation Portable (PSP)", "Sony PlayStation Vita", "Vectrex",  "Zeebo"]
    
    let sectionTitles = "0ABCDEFGHIJKLMNOPQRSTUVWXYZ".map(String.init)
    
       
    
    
    override func viewWillDisappear(_ animated: Bool) {
        clearImageCacheFromMemory()
    }
    
    override func didReceiveMemoryWarning() {
        clearImageCacheFromMemory()
    }
    
    func clearImageCacheFromMemory() {
        let imageCache = SDImageCache.shared
        imageCache.clearMemory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        dropDown.reloadAllComponents()
        
        if network.gameArray.count != 0 {
            gameArray = network.gameArray
            self.collectionView.reloadData()
            
        }
        if gameArray.count > 0  {
            if let platformID = gameArray[0].platformID {
                currentPlatformID = platformID
            }
            currentPlatformName = convertPlatformIDToName(PlatformID: currentPlatformID)
            
            search.searchBar.placeholder = "Search within \(currentPlatformName)"
            
        }
        
        self.collectionView.reloadData()
        updateWithOwnedGames()
        setAppearance()
        
        search.definesPresentationContext = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        dropDown.width = dropDownView.frame.width
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        altLayout = UserDefaults.standard.bool(forKey: "gamesAltLayout")

        
        
        let currentCount = Float(gameArray.count)
        let totalCount = Float(network.totalRequestCount)
        if totalCount != 0 {
            let progress = currentCount / totalCount
            self.progressIndicator.progress = progress
        }
        
   
        collectionView.register(VCHeaderView.self, forSupplementaryViewOfKind: ViewController.sectionHeaderElementKind, withReuseIdentifier: VCHeaderView.reuseIdentifier)
        collectionView.register(ViewControllerCVTableCell.self  , forCellWithReuseIdentifier: ViewControllerCVTableCell.cellIdentifier)
        collectionView.register(ViewControllerCVCell.self, forCellWithReuseIdentifier: ViewControllerCVCell.cellIdentifier)
     

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = setupCollectionViewLayout()
        
        let lightBlue = UIColorFromRGB(0x2B95CE)
        collectionView.tintColor = lightBlue
        prepareData()
        
        setAppearance()
        configureDropDownMenu()
        configureSearchBar()
        createAppIcon()
        createFailViews()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureRecognizer)
        
        let scanButton = UIButton(type: .system)
        scanButton.setImage(UIImage(systemName: "barcode"), for: .normal)
        scanButton.setTitle("Scan", for: .normal)
        scanButton.contentVerticalAlignment = .bottom
        scanButton.sizeToFit()
        scanButton.addTarget(self, action: #selector(scanButtonPressed), for: .touchUpInside)
        
        layoutButton.setImage(altLayout == true ? UIImage(systemName: "rectangle.grid.1x2") : UIImage(systemName: "rectangle.grid.2x2"), for: .normal)
        layoutButton.addTarget(self, action: #selector(setLayout), for: .touchUpInside)
        let layout = UIBarButtonItem(customView: layoutButton)
        let scan = UIBarButtonItem(customView: scanButton)
        
        self.navigationItem.rightBarButtonItems = [scan, layout]
        
        advancedSearchBtn.frame = CGRect(x: 10, y: 20, width: 50, height: 50)
        advancedSearchBtn.setTitle("Adv. Search", for: .normal)
        advancedSearchBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        advancedSearchBtn.setTitleColor(blueTint, for: .normal)
        advancedSearchBtn.titleEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        self.advancedSearchBtn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        advancedSearchBtn.sizeToFit()
        
        advancedSearchBtn.addTarget(self, action: #selector(sortButtonPressed), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: advancedSearchBtn)
        
        requestMoreGames()
        
    }
    
    @objc func tap() {
        search.searchBar.endEditing(true)
    }
    
    @objc func setLayout() {

        if altLayout == false {
            UserDefaults.standard.set(true, forKey: "gamesAltLayout")
        } else {
            UserDefaults.standard.set(false, forKey: "gamesAltLayout")
        }
        
        
        altLayout = UserDefaults.standard.bool(forKey: "gamesAltLayout")
        
        layoutButton.setImage(altLayout == true ? UIImage(systemName: "rectangle.grid.1x2") : UIImage(systemName: "rectangle.grid.2x2"), for: .normal)

        collectionView.setCollectionViewLayout(setupCollectionViewLayout(), animated: false)
        collectionView.collectionViewLayout.invalidateLayout()

        self.collectionView.reloadData()

        }
    
    
    @objc func sortButtonPressed() {
        
        let VC = storyboard?.instantiateViewController(identifier: "advancedSearch") as! AdvancedSearchVC
        
        navigationController?.pushViewController(VC, animated: true)
    }
    
    
    func removeLeadingArticle(fromString: String) -> String{
        let articles = ["a ", "an ", "the ", "The ", "A ", "An "]
        
        for article in articles {
            if fromString.lowercased().hasPrefix(article.lowercased()) {
                
                
                let articleLength = article.count
                
                let returnString = String(fromString[fromString.index(fromString.startIndex, offsetBy: articleLength)...])
                
                return returnString
                
            }
            
        }
        
        return fromString
        
        
    }
    
    
    
    func sortGameArrays() {
        self.numericGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.aGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.bGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.cGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.dGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.eGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.fGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.gGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.hGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.iGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.jGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        
        self.kGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        
        self.lGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.mGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.nGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.oGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.pGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.qGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.rGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.sGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.tGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        
        self.uGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.vGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.wGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        self.xGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.yGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
        
        self.zGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == sortDirection
            
        }
    }
    
    
    func requestMoreGames() {
        
        let platformID = network.lastRequestedPlatformID
        if network.endOfResults != true {
            
            self.network.fetchIGDBGamesData(filterBy: "platforms = ", platformID: platformID, searchByName: nil, sortByField: "name", sortAscending: true, offset: self.network.currentOffset, resultsPerPage: 500) { error in
                
                
                
                
                if error != nil {
                    
                    self.collectionView.reloadData()
                } else {
                    
                    self.gameArray = self.network.gameArray
                    self.network.currentOffset += 500
                    
                    self.network.fetchingMore = false
                    self.collectionView.reloadData()
                    
                    if self.network.endOfResults == true {
                        self.gameArrayCountLabel.text = String(self.gameArray.count)
                        
                        UIView.animate(withDuration: 1.5) {
                            self.progressIndicator.alpha = 0
                            self.progressCompleteLbl.alpha = 0
                            self.activityIndicator.alpha = 0
                            self.progressIndicator.isHidden = true
                            self.progressCompleteLbl.isHidden = true
                            self.activityIndicator.isHidden = true
                        } completion: { complete in
                            UIView.animate(withDuration: 1.5) {
                                self.gameArrayCountLabel.isHidden = false
                                self.totalGamesDisplayedLbl.isHidden = false
                                self.gameArrayCountLabel.alpha = 1
                                self.totalGamesDisplayedLbl.alpha = 1
                                
                            } completion: { complete in
                                
                            }
                            
                        }
                        
                        
                    } else {
                        self.requestMoreGames()
                    }
                    
                    
                }
            }
        } else {
            
            self.gameArrayCountLabel.text = String(self.gameArray.count)
            
            UIView.animate(withDuration: 3) {
                self.progressIndicator.alpha = 0
                self.progressCompleteLbl.alpha = 0
                self.activityIndicator.alpha = 0
            } completion: { complete in
                UIView.animate(withDuration: 3) {
                    
                    self.gameArrayCountLabel.alpha = 1
                    self.totalGamesDisplayedLbl.alpha = 1
                    
                } completion: { complete in
                    
                }
                
                
            }
            
            
        }
    }
    
    @objc func scanButtonPressed() {
        
        let sboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = sboard.instantiateViewController(identifier: "barcode")
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func createAppIcon() {
        
        let logo = UIImage(named: "gameologylogo44")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
    }
    
    
    func configureSearchBar() {
        
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.showsBookmarkButton = false
        search.searchBar.alpha = 0.2
        search.searchBar.setImage(UIImage(systemName: "line.horizontal.3.decrease.circle"), for: .bookmark, state: .normal)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = search
        
    }
    
    
    func prepareData() {
        
        if network.gameArray.count != 0 {
            self.gameArray = self.network.gameArray
            guard let platformID = gameArray[0].platformID else { return }
            let game = gameArray[0]
            let platformImage = game.fetchPlatformFlag(platformID: platformID, uiMode: traitCollection.userInterfaceStyle)
            self.tableviewPlatformImage.image = platformImage
            self.collectionView.reloadData()
         
        }
        
    }
    
    func createFailViews() {
        view.addSubview(failLabel)
        view.addSubview(failRefreshBtn)
        
        failLabel.text = "Network failure..."
        failLabel.textAlignment = .center
        failLabel.isHidden = true
        failLabel.translatesAutoresizingMaskIntoConstraints = false
        
        failRefreshBtn.setTitle("Refresh", for: .normal)
        failRefreshBtn.backgroundColor = .red
        failRefreshBtn.tintColor = .white
        failRefreshBtn.isHidden = true
        failRefreshBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            failLabel.heightAnchor.constraint(equalToConstant: 50),
            failLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            failLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            failLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            failRefreshBtn.heightAnchor.constraint(equalToConstant: 50),
            failRefreshBtn.widthAnchor.constraint(equalTo: failLabel.widthAnchor, multiplier: 0.5),
            failRefreshBtn.topAnchor.constraint(equalTo: failLabel.bottomAnchor),
            failRefreshBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let destination = segue.destination as? PagingDetailVC {
            destination.game = segueObject!
            
        }
        
    }
    
    
    
    func updateWithOwnedGames() {
        let title = ViewController.savedGame.title
        let id = ViewController.savedGame.id
        let owned = ViewController.savedGame.owned
        
        for i in 0...gameArray.count - 1 {
            if gameArray[i].title == title && gameArray[i].id == id {
                gameArray[i].owned = owned
            }
        }
        collectionView.reloadData()
  
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
    
    
    func convertPlatformNameToID(platformName: String) -> Int {
        let allPlatforms = network.platforms
        var platformID = 0
        for platform in allPlatforms {
            
            if platform.name == platformName {
                platformID = platform.id
            }
            
        }
        return platformID
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
            dropDownView.layer.shadowColor = UIColor.darkGray.cgColor
            
        } else {
            overrideUserInterfaceStyle = .dark
            self.navigationController?.overrideUserInterfaceStyle = .dark
            self.tabBarController?.overrideUserInterfaceStyle = .dark
            dropDownView.layer.shadowColor = UIColor.gray.cgColor
            
        }
        
        if traitCollection.userInterfaceStyle == .light {
            let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
            collectionView.backgroundColor = lightGray
            view.backgroundColor = lightGray
            platformLabel.backgroundColor = lightGray
            platformPicker.backgroundColor = lightGray
            dropDown.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            dropDown.textColor = .black
            dropDown.shadowColor = .black
            dropDown.shadowOffset = CGSize(width: 3.0, height: 3.0)
            navigationController?.view.backgroundColor = .white
            
        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
            collectionView.backgroundColor = darkGray
            view.backgroundColor = darkGray
            platformLabel.backgroundColor = darkGray
            platformPicker.backgroundColor = darkGray
            dropDown.backgroundColor = UIColor(red: 0.17, green: 0.17, blue: 0.18, alpha: 1)
            dropDown.textColor = .white
            dropDown.shadowOffset = CGSize(width: 3.0, height: 3.0)
            dropDown.shadowColor = .white
            navigationController?.view.backgroundColor = .black
            
        }
        
        
        if let platformID = gameArray[0].platformID {
            let game = gameArray[0]
            let platformLogos = game.fetchPlatformFlag(platformID: platformID, uiMode: traitCollection.userInterfaceStyle)
            self.tableviewPlatformImage.image = platformLogos
        }
        
    }
    
    
    
    @IBAction func platformMenuTouched(_ sender: Any) {
        
        dropDown.show()
        
    }
    
    
    func convertPlatformIDToName(PlatformID: Int) -> String {
        let platforms = network.platforms
        var platformName = ""
        for platform in platforms {
            
            if platform.id == PlatformID {
                platformName = platform.name
            }
        }
        
        return platformName
    }
    
    
    
    func createSectionTitles()-> [String]
    {
        var sectionTitles : [String] = []
        if numericGames.count > 0 {
            
            sectionTitles.append("0-9")
        }
        if aGames.count > 0 {
            
            sectionTitles.append("A")
        }
        if bGames.count > 0 {
            
            sectionTitles.append("B")
        }
        if cGames.count > 0 {
            
            sectionTitles.append("C")
        }
        if dGames.count > 0 {
            
            sectionTitles.append("D")
        }
        if eGames.count > 0 {
            
            sectionTitles.append("E")
        }
        if fGames.count > 0 {
            
            sectionTitles.append("F")
        }
        if gGames.count > 0 {
            
            sectionTitles.append("G")
        }
        if hGames.count > 0 {
            
            sectionTitles.append("H")
        }
        if iGames.count > 0 {
            
            sectionTitles.append("I")
        }
        if jGames.count > 0 {
            
            sectionTitles.append("J")
        }
        if kGames.count > 0 {
            
            sectionTitles.append("K")
        }
        if lGames.count > 0 {
            
            sectionTitles.append("L")
        }
        if mGames.count > 0 {
            
            sectionTitles.append("M")
        }
        if nGames.count > 0 {
            
            sectionTitles.append("N")
        }
        if oGames.count > 0 {
            
            sectionTitles.append("O")
        }
        if pGames.count > 0 {
            
            sectionTitles.append("P")
        }
        if qGames.count > 0 {
            
            sectionTitles.append("Q")
        }
        if rGames.count > 0 {
            
            sectionTitles.append("R")
        }
        if sGames.count > 0 {
            
            sectionTitles.append("S")
        }
        if tGames.count > 0 {
            
            sectionTitles.append("T")
        }
        if uGames.count > 0 {
            
            sectionTitles.append("U")
        }
        if vGames.count > 0 {
            
            sectionTitles.append("V")
        }
        if wGames.count > 0 {
            
            sectionTitles.append("W")
        }
        if xGames.count > 0 {
            
            sectionTitles.append("X")
        }
        if yGames.count > 0 {
            
            sectionTitles.append("Y")
        }
        if zGames.count > 0 {
            
            sectionTitles.append("Z")
        }
        
        return sectionTitles
    
}
    
    
    
    
    
}



extension ViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        //instant search, will process after each keypress
        
        guard let text = searchController.searchBar.text else { return }
        
        var searchResults : [GameObject] = []
        let searchBarText = text
        
        if searchBarText != "" {
            
            network.searchFilter = " platforms = "
            
            network.searchText = searchBarText
            
            for game in network.gameArray {
                let contained = game.title?.lowercased().contains(searchBarText.lowercased())
                if contained == true {
                    searchResults.append(game)
                }
                
            }
            
            self.gameArray = searchResults
            collectionView.reloadData()
        } else {
            self.gameArray = network.gameArray
            self.collectionView.reloadData()
        }
        
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            searchController.searchBar.becomeFirstResponder()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        search.searchBar.showsCancelButton = true
        
    }
    
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        search.searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.search.searchBar.showsCancelButton = true
        self.search.searchBar.endEditing(true)
        self.gameArray = network.gameArray
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.search.searchBar.endEditing(true)
        
    }
    
}


extension ViewController: DropdownPickerViewDelegate {
    
    
    func configureDropDownMenu() {
        dropDown.anchorView = dropDownView
        let title = formatPlatformIDToPrettyPlatformName(ID: network.lastRequestedPlatformID)
        dropDownView.setTitle(title, for: .normal)
        dropDownView.layer.cornerRadius = 12
        dropDownView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        dropDownView.layer.shadowOpacity = 0.7
        dropDownView.layer.shadowRadius = 2
        dropDownView.layer.masksToBounds = false
        dropDownView.titleLabel?.adjustsFontSizeToFitWidth = true
        dropDown.backgroundColor = .white
        dropDown.dataSource = platforms
        dropDown.direction = .bottom
        dropDown.width = dropDownView.frame.size.width
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            network.currentTask?.cancel()
            
            self.network.searchIsActive = false
            self.progressCompleteLbl.text = "0%"
            self.progressIndicator.progress = 0
            self.gameArrayCountLabel.alpha = 0
            self.totalGamesDisplayedLbl.alpha = 0
            self.totalGamesDisplayedLbl.isHidden = true
            self.progressIndicator.isHidden = true
            self.gameArrayCountLabel.isHidden = true
            self.progressIndicator.isHidden = false
            self.activityIndicator.isHidden = false
            self.progressCompleteLbl.isHidden = false
            self.progressIndicator.progress = 0
            self.progressCompleteLbl.alpha = 1
            self.progressIndicator.alpha = 1
            self.activityIndicator.alpha = 1
            
            let selectedPlatformID = gameArray[0].formatPrettyPlatformNameToID(platformName: item)
            network.lastRequestedPlatformID = selectedPlatformID
            
            dropDownView.setTitle(item, for: .normal)
            self.network.gameArray.removeAll()
            self.collectionView.reloadData()
            self.network.previousDataCount = 0
            self.network.currentDataCount = 0
            self.network.currentOffset = 0
            
            self.search.searchBar.placeholder = "Search within \(item)"
            let platformLogos = gameArray[0].fetchPlatformFlag(platformID: selectedPlatformID, uiMode: traitCollection.userInterfaceStyle)
            UIView.transition(with: self.tableviewPlatformImage, duration: 1, options: .transitionCrossDissolve, animations: {
                self.tableviewPlatformImage.image = platformLogos
                
            }, completion: nil)
            
            
            network.fetchIGDBGamesData(filterBy: "platforms = ", platformID: selectedPlatformID, searchByName: nil, sortByField: "name", sortAscending: true, offset: 0, resultsPerPage: 500) { error in
                
                if error == nil {
                    network.currentOffset = 0
                    self.gameArray = network.gameArray
                    dropDownFetchSuccess(item: item, selectedPlatformID: selectedPlatformID)
                }
                
            }
            
            
            
            
            
        }
        
        
    }
    
    
    
    func getTopSection() -> Int {
        var section = 0
        if sortDirection == .orderedAscending {
            if numericGames.count > 0 {
                section = 0
            } else if aGames.count > 0 {
                section = 1
            } else if bGames.count > 0 {
                section = 2
            } else if cGames.count > 0 {
                section = 3
            } else if dGames.count > 0 {
                section = 4
            } else if eGames.count > 0 {
                section = 5
            } else if fGames.count > 0 {
                section = 6
            } else if gGames.count > 0 {
                section = 7
            } else if hGames.count > 0 {
                section = 8
            } else if iGames.count > 0 {
                section = 9
            } else if jGames.count > 0 {
                section = 10
            } else if kGames.count > 0 {
                section = 11
            } else if lGames.count > 0 {
                section = 12
            } else if mGames.count > 0 {
                section = 13
            } else if nGames.count > 0 {
                section = 14
            } else if oGames.count > 0 {
                section = 15
            } else if pGames.count > 0 {
                section = 16
            } else if qGames.count > 0 {
                section = 17
            } else if rGames.count > 0 {
                section = 18
            } else if sGames.count > 0 {
                section = 19
            } else if tGames.count > 0 {
                section = 20
            } else if uGames.count > 0 {
                section = 21
            } else if vGames.count > 0 {
                section = 22
            } else if wGames.count > 0 {
                section = 23
            } else if xGames.count > 0 {
                section = 24
            } else if yGames.count > 0 {
                section = 25
            } else if zGames.count > 0 {
                section = 26
            }
        } else {
            if zGames.count > 0 {
                section = 0
            } else if yGames.count > 0 {
                section = 1
            } else if xGames.count > 0 {
                section = 2
            } else if wGames.count > 0 {
                section = 3
            } else if vGames.count > 0 {
                section = 4
            } else if uGames.count > 0 {
                section = 5
            } else if tGames.count > 0 {
                section = 6
            } else if sGames.count > 0 {
                section = 7
            } else if rGames.count > 0 {
                section = 8
            } else if qGames.count > 0 {
                section = 9
            } else if pGames.count > 0 {
                section = 10
            } else if oGames.count > 0 {
                section = 11
            } else if nGames.count > 0 {
                section = 12
            } else if mGames.count > 0 {
                section = 13
            } else if lGames.count > 0 {
                section = 14
            } else if kGames.count > 0 {
                section = 15
            } else if jGames.count > 0 {
                section = 16
            } else if iGames.count > 0 {
                section = 17
            } else if hGames.count > 0 {
                section = 18
            } else if gGames.count > 0 {
                section = 19
            } else if fGames.count > 0 {
                section = 20
            } else if eGames.count > 0 {
                section = 21
            } else if dGames.count > 0 {
                section = 22
            } else if cGames.count > 0 {
                section = 23
            } else if bGames.count > 0 {
                section = 24
            } else if aGames.count > 0 {
                section = 25
            } else if numericGames.count > 0 {
                section = 26
            }
        }
        
        return section
    }
    
    
    
    func dropDownFetchSuccess(item: String, selectedPlatformID: Int) {
        
        
        if let platformID = gameArray[0].platformID {
            currentPlatformID = platformID
            let defaults = UserDefaults.standard
            defaults.setValue(platformID, forKey: "lastFetchedPlatform")
        }
        
        currentPlatformName = convertPlatformIDToName(PlatformID: currentPlatformID)
        
        self.network.currentOffset += 500
        
        self.collectionView.reloadData()
        let indexPath = IndexPath(item: 0, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        if network.endOfResults != true {
            
            requestMoreGames()
            
        } else {
            
            self.gameArray = self.network.gameArray
            
            self.gameArrayCountLabel.text = String(self.gameArray.count)
            
            UIView.animate(withDuration: 1.5) {
                self.progressIndicator.alpha = 0
                self.progressCompleteLbl.alpha = 0
                self.activityIndicator.alpha = 0
                
            } completion: { complete in
                self.progressIndicator.isHidden = true
                self.progressCompleteLbl.isHidden = true
                self.activityIndicator.isHidden = true
                
                self.gameArrayCountLabel.isHidden = false
                self.totalGamesDisplayedLbl.isHidden = false
                
                UIView.animate(withDuration: 1.5) {
                    self.gameArrayCountLabel.alpha = 1
                    self.totalGamesDisplayedLbl.alpha = 1
                    
                    
                } completion: { complete in
                    self.gameArrayCountLabel.isHidden = false
                    self.totalGamesDisplayedLbl.isHidden = false
                    self.gameArrayCountLabel.alpha = 1
                    self.totalGamesDisplayedLbl.alpha = 1
                    
                }
                
            }
            
        }
        
    }
 
    
  
    
    
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath {

        switch title {
            
        case "0-9":
            return IndexPath(item: 0, section: index)
       
        case "A":
            return IndexPath(item: 0, section: index)
        case "B":
        
            return IndexPath(item: 0, section: index)
        case "C":
            return IndexPath(item: 0, section: index)

        case "D":
            return IndexPath(item: 0, section: index)

        case "E":
            return IndexPath(item: 0, section: index)

        case "F":
            return IndexPath(item: 0, section: index)

        case "G":
            return IndexPath(item: 0, section: index)

        case "H":
            return IndexPath(item: 0, section: index)

        case "I":
            return IndexPath(item: 0, section: index)

        case "J":
            return IndexPath(item: 0, section: index)

        case "K":
            return IndexPath(item: 0, section: index)

        case "L":
            return IndexPath(item: 0, section: index)

        case "M":
            return IndexPath(item: 0, section: index)

        case "N":
            return IndexPath(item: 0, section: index)
        case "O":
            return IndexPath(item: 0, section: index)
        case "P":
            return IndexPath(item: 0, section: index)
        case "Q":
            return IndexPath(item: 0, section: index)
        case "R":
            return IndexPath(item: 0, section: index)
        case "S":
            return IndexPath(item: 0, section: index)
        case "T":
            return IndexPath(item: 0, section: index)
        case "U":
            return IndexPath(item: 0, section: index)
        case "V":
            return IndexPath(item: 0, section: index)
        case "W":
            return IndexPath(item: 0, section: index)
        case "X":
            return IndexPath(item: 0, section: index)
        case "Y":
            return IndexPath(item: 0, section: index)
        case "Z":
            return IndexPath(item: 0, section: index)
        default:
            return IndexPath(item: 0, section: 0)
            
        }

    }
    
    
    func indexTitles(for collectionView: UICollectionView) -> [String]? {
        var title = createSectionTitles()
        if let numericIndex = title.firstIndex(where: {$0 == "0-9"}) {
            title[numericIndex] = "0"
        }
        return title
    }
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let titles = createSectionTitles()
                switch titles[section] {
                    
                case "0-9":
                    
                    return numericGames.count
                case "A":
                    return  aGames.count
                case "B":
                    return  bGames.count
                case "C":
                    return  cGames.count
                case "D":
                    return  dGames.count
                case "E":
                    return  eGames.count
                case "F":
                    return  fGames.count
                case "G":
                    return  gGames.count
                case "H":
                    return  hGames.count
                case "I":
                    return  iGames.count
                case "J":
                    return  jGames.count
                case "K":
                    return  kGames.count
                case "L":
                    return  lGames.count
                case "M":
                    return  mGames.count
                case "N":
                    return  nGames.count
                case "O":
                    return  oGames.count
                case "P":
                    return  pGames.count
                case "Q":
                    return  qGames.count
                case "R":
                    return  rGames.count
                case "S":
                    return  sGames.count
                case "T":
                    return  tGames.count
                case "U":
                    return  uGames.count
                case "V":
                    return  vGames.count
                case "W":
                    return  wGames.count
                case "X":
                    return  xGames.count
                case "Y":
                    return  yGames.count
                case "Z":
                    return  zGames.count
                default:
                    return 0
                }
                
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let sections = createSectionTitles()
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let titles = createSectionTitles()

        guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: VCHeaderView.reuseIdentifier, for: indexPath) as? VCHeaderView else {
            fatalError("Cannot create header view") }

        switch titles[indexPath.section] {
        case "0-9":
            supplementaryView.indexSection = "0-9"

        case "A":
                        supplementaryView.indexSection = "A"
        case "B":
            supplementaryView.indexSection = "B"
        case "C":
            supplementaryView.indexSection = "C"
        case "D":
            supplementaryView.indexSection = "D"
        case "E":
            supplementaryView.indexSection = "E"
        case "F":
            supplementaryView.indexSection = "F"
        case "G":
            supplementaryView.indexSection = "G"
        case "H":
            supplementaryView.indexSection = "H"
        case "I":
            supplementaryView.indexSection = "I"
        case "J":
            supplementaryView.indexSection = "J"
        case "K":
            supplementaryView.indexSection = "K"
        case "L":
            supplementaryView.indexSection = "L"
        case "M":
            supplementaryView.indexSection = "M"
        case "N":
            supplementaryView.indexSection = "N"
        case "O":
            supplementaryView.indexSection = "O"
        case "P":
            supplementaryView.indexSection = "P"
        case "Q":
            supplementaryView.indexSection = "Q"
        case "R":
            supplementaryView.indexSection = "R"
        case "S":
            supplementaryView.indexSection = "S"
        case "T":
            supplementaryView.indexSection = "T"
        case "U":
            supplementaryView.indexSection = "U"
        case "V":
            supplementaryView.indexSection = "V"
        case "W":
            supplementaryView.indexSection = "W"
        case "X":
            supplementaryView.indexSection = "X"
        case "Y":
            supplementaryView.indexSection = "Y"
        case "Z":
            supplementaryView.indexSection = "Z"
        default:
            supplementaryView.indexSection = "-"

        }
       
        
        return supplementaryView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let titles = createSectionTitles()
        
        if altLayout {
            let cell = collectionView.cellForItem(at: indexPath) as! ViewControllerCVCell
            
            segueObject = cell.game
            self.performSegue(withIdentifier: "pagingVC", sender: self)
            
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! ViewControllerCVTableCell

            segueObject = cell.game
            self.performSegue(withIdentifier: "pagingVC", sender: self)

        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let titles = createSectionTitles()

        if altLayout {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath) as! ViewControllerCVCell

            switch titles[indexPath.section] {
                
            case "0-9":
                cell.game = numericGames[indexPath.item]
            case "A":
                cell.game = aGames[indexPath.item]
            case "B":
                cell.game = bGames[indexPath.item]
            case "C":
                cell.game = cGames[indexPath.item]
            case "D":
                cell.game = dGames[indexPath.item]
            case "E":
                cell.game = eGames[indexPath.item]
            case "F":
                cell.game = fGames[indexPath.item]
            case "G":
                cell.game = gGames[indexPath.item]
            case "H":
                cell.game = hGames[indexPath.item]
            case "I":
                cell.game = iGames[indexPath.item]
            case "J":
                cell.game = jGames[indexPath.item]
            case "K":
                cell.game = kGames[indexPath.item]
            case "L":
                cell.game = lGames[indexPath.item]
            case "M":
                cell.game = mGames[indexPath.item]
            case "N":
                cell.game = nGames[indexPath.item]
            case "O":
                cell.game = oGames[indexPath.item]
            case "P":
                cell.game = pGames[indexPath.item]
            case "Q":
                cell.game = qGames[indexPath.item]
            case "R":
                cell.game = rGames[indexPath.item]
            case "S":
                cell.game = sGames[indexPath.item]
            case "T":
                cell.game = tGames[indexPath.item]
            case "U":
                cell.game = uGames[indexPath.item]
            case "V":
                cell.game = vGames[indexPath.item]
            case "W":
                cell.game = wGames[indexPath.item]
            case "X":
                cell.game = xGames[indexPath.item]
            case "Y":
                cell.game = yGames[indexPath.item]
            case "Z":
                cell.game = zGames[indexPath.item]
            default:
                cell.game = aGames[indexPath.item]
                
            }
            
            return cell

        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tableCell", for: indexPath) as! ViewControllerCVTableCell

            switch titles[indexPath.section] {

            case "0-9":
                cell.game = numericGames[indexPath.item]
            case "A":
                cell.game = aGames[indexPath.item]
            case "B":
                cell.game = bGames[indexPath.item]
            case "C":
                cell.game = cGames[indexPath.item]
            case "D":
                cell.game = dGames[indexPath.item]
            case "E":
                cell.game = eGames[indexPath.item]
            case "F":
                cell.game = fGames[indexPath.item]
            case "G":
                cell.game = gGames[indexPath.item]
            case "H":
                cell.game = hGames[indexPath.item]
            case "I":
                cell.game = iGames[indexPath.item]
            case "J":
                cell.game = jGames[indexPath.item]
            case "K":
                cell.game = kGames[indexPath.item]
            case "L":
                cell.game = lGames[indexPath.item]
            case "M":
                cell.game = mGames[indexPath.item]
            case "N":
                cell.game = nGames[indexPath.item]
            case "O":
                cell.game = oGames[indexPath.item]
            case "P":
                cell.game = pGames[indexPath.item]
            case "Q":
                cell.game = qGames[indexPath.item]
            case "R":
                cell.game = rGames[indexPath.item]
            case "S":
                cell.game = sGames[indexPath.item]
            case "T":
                cell.game = tGames[indexPath.item]
            case "U":
                cell.game = uGames[indexPath.item]
            case "V":
                cell.game = vGames[indexPath.item]
            case "W":
                cell.game = wGames[indexPath.item]
            case "X":
                cell.game = xGames[indexPath.item]
            case "Y":
                cell.game = yGames[indexPath.item]
            case "Z":
                cell.game = zGames[indexPath.item]
            default:
                cell.game = aGames[indexPath.item]

            }

            return cell

    }
    }


    func setupCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
           
            if self.altLayout {
                return self.setupAltLayout()
            } else {
                return self.setupTableviewLayoutSection()
            }
            
        }
        
        
        return layout
    }
    
    
    fileprivate func setupAltLayout() -> NSCollectionLayoutSection {
        var itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .absolute(163), heightDimension: .fractionalHeight(1.0))
        
        itemSize = NSCollectionLayoutSize(widthDimension: .absolute(170), heightDimension: .fractionalHeight(1.0))
      
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width - 22.5), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.flexible(0)
        group.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: ViewController.sectionHeaderElementKind, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0)
        return section
    }
    
    
    fileprivate func setupTableviewLayoutSection() -> NSCollectionLayoutSection {
        var itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        if self.view.frame.width > 429 {
             itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        }
    
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width - 27.5), heightDimension: .absolute(198))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 0)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: ViewController.sectionHeaderElementKind, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 30, trailing: 0)
        return section
    }
    
    
    
    
    }
