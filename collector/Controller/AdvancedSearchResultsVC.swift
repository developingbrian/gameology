//
//  AdvancedSearchResultsVC.swift
//  collector
//
//  Created by Brian on 10/29/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage


class AdvancedSearchResultsVC: UIViewController {
    var altLayout = false
    var numericGames : [GameObject] = []
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
            
        }
    }
    
    var name = ""
    var platforms : [String] = []
    var genres : [String] = []
    var years : [Int] = []
    let sectionTitles = "0ABCDEFGHIJKLMNOPQRSTUVWXYZ".map(String.init)
    var persistenceManager = PersistenceManager.shared
    var wishList : [WishList] = [WishList]()
    var savedGames: [SavedGames] = [SavedGames]()
    var savedPlatforms: [Platform] = [Platform]()
    var savedGenres: [GameGenre] = [GameGenre]()
    
    var layoutButton = UIButton(type: .system)
    @IBOutlet weak var searchResultsLbl: UILabel!
    @IBOutlet weak var searchResultsCount: UILabel!
    
    
    @IBOutlet weak var spinView: UIView!
    
    @IBOutlet var collectionView: UICollectionView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        altLayout = UserDefaults.standard.bool(forKey: "searchAltLayout")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(VCHeaderView.self, forSupplementaryViewOfKind: ViewController.sectionHeaderElementKind, withReuseIdentifier: VCHeaderView.reuseIdentifier)
        collectionView.register(ViewControllerCVTableCell.self  , forCellWithReuseIdentifier: ViewControllerCVTableCell.cellIdentifier)
        collectionView.register(ViewControllerCVCell.self, forCellWithReuseIdentifier: ViewControllerCVCell.cellIdentifier)
        collectionView.collectionViewLayout = setupCollectionViewLayout()
        prepareData()
        
        layoutButton.setImage( altLayout == true ? UIImage(systemName: "rectangle.grid.1x2") : UIImage(systemName: "rectangle.grid.2x2"), for: .normal)
        layoutButton.addTarget(self, action: #selector(setLayout), for: .touchUpInside)
        let layout = UIBarButtonItem(customView: layoutButton)
        self.navigationItem.rightBarButtonItem = layout
        
        let logo = UIImage(named: "gameologylogo44")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setAppearance()
        self.collectionView.reloadData()
    }

    func checkForGameInWishList(name: String, id: Int) -> Bool {
        
        let savedGames = persistenceManager.fetch(WishList.self)
        
        for savedGame in savedGames {
            
            if savedGame.title == name && savedGame.gameID == id {
                
                return true
            }
            
            
        }
        
        return false
        
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
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.aGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.bGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.cGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.dGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.eGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.fGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.gGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.hGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.iGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.jGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        
        self.kGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        
        self.lGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.mGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.nGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.oGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.pGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.qGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.rGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.sGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.tGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        
        self.uGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.vGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.wGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        self.xGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.yGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
        
        self.zGames.sort() {
            firstGame, secondGame in
            
            
            let title1 = removeLeadingArticle(fromString: firstGame.title!)
            let title2 = removeLeadingArticle(fromString: secondGame.title!)
            return title1.localizedCaseInsensitiveCompare(title2) == .orderedAscending
            
        }
    }
    
    @objc func setLayout() {
//        altLayout.toggle()

        if altLayout == false {
            UserDefaults.standard.set(true, forKey: "searchAltLayout")
        } else {
            UserDefaults.standard.set(false, forKey: "searchAltLayout")
        }
        
        
        altLayout = UserDefaults.standard.bool(forKey: "searchAltLayout")

        layoutButton.setImage( altLayout == true ? UIImage(systemName: "rectangle.grid.1x2") : UIImage(systemName: "rectangle.grid.2x2"), for: .normal)
        collectionView.reloadData()
        collectionView.setCollectionViewLayout(setupCollectionViewLayout(), animated: false)
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
            collectionView.backgroundColor = lightGray
            view.backgroundColor = lightGray
            navigationController?.view.backgroundColor = .white
            
        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
            collectionView.backgroundColor = darkGray
            view.backgroundColor = darkGray
            navigationController?.view.backgroundColor = .black
            
        }
    }

    func prepareData() {
        
        var selectedPlatformIDs : [Int] = []
        var selectedGenreIDs : [Int] = []
        
        if platforms.count > 0 {
            for platform in platforms {
                let platformID = gameArray[0].formatPrettyPlatformNameToID(platformName: platform)
                selectedPlatformIDs.append(platformID)
            }
        }
        
        if genres.count > 0 {
            for genre in network.genres {
                
                let genreName = genre.name
                for selectedGenre in genres {
                    
                    if selectedGenre == genreName {
                        if let genreID = genre.id {
                            selectedGenreIDs.append(genreID)
                        }
                    }
                }
            }
        }
        spinView.isHidden = true
        self.showSpinner(onView: spinView, userInterfaceStyle: traitCollection.userInterfaceStyle)

        network.fetchAdvancedSearchData(title: name, platforms: selectedPlatformIDs, genres: selectedGenreIDs, yearRange: years) {
            
            self.gameArray = network.searchResultsData
            self.collectionView.reloadData()
            self.removeSpinner()
            self.searchResultsCount.text = String(self.gameArray.count)

            UIView.animate(withDuration: 3) {
                self.searchResultsLbl.alpha = 1
                self.searchResultsCount.alpha = 1
            } completion: { complete in
                
            }
        }
    }

    func createSectionTitles()-> [String] {
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






extension AdvancedSearchResultsVC : UICollectionViewDelegate, UICollectionViewDataSource {

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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let titles = createSectionTitles()

        if altLayout == true {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVCell", for: indexPath) as! ViewControllerCVCell
            cell.showPlatformFlag = true

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
            cell.showPlatformFlag = true
            
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

        let VC = self.storyboard?.instantiateViewController(withIdentifier: "paging") as! PagingDetailVC

        if altLayout == true {
            let cell = collectionView.cellForItem(at: indexPath) as! ViewControllerCVCell
            guard let game = cell.game else { return }
            VC.game = game
            navigationController?.pushViewController(VC, animated: true)


        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! ViewControllerCVTableCell
            guard let game = cell.game else { return }
            VC.game = game
            navigationController?.pushViewController(VC, animated: true)


    }
    }
    
    func setupCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
           
            if self.altLayout == true {
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width - 22.5), heightDimension: .absolute(325))
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width - 27.5), heightDimension: .absolute(223))
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
