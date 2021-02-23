//
//  WishlistVC.swift
//  collector
//
//  Created by Brian on 1/27/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit
import SDWebImage
import SPAlert

protocol WishlistDelegate {
    func didPressManageButton(_ sender: WishlistCollectionViewCell)
}

class WishlistVC: UIViewController {
    struct SectionData {
        
        var isOpen : Bool
        var game : [WishList]
        
    }
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let persistenceManager = PersistenceManager.shared
    var wishlist : [WishList] = []
    var items : [String] = []
    var images : [UIImage?] = []
    var platforms : [String] = []
    var platform : [WishList] = []
    var twoDimensionalArray : [ExpandablePlatforms] = []
    var sectionArray : [SectionData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        items = wishlist[0].platformName
//        wishlistCollectionView.dataSource = self
//        wishlistCollectionView.delegate = self
        setupCollectionView()
        
        
//        loadImages()

//        wishlistCollectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewwillappear")
        wishlist = persistenceManager.fetch(WishList.self)
        print(wishlist.count)
//        loadImages()
        items = wishlist.map({$0.platformName!})
        print("wishlist count \(wishlist.count)")
        platforms = wishlist.map( {$0.platformName!} )

        platforms.removeDuplicates()
        platforms.sort {
            
            $0 < $1
        }
        createSectionData()
    
        print("reloaded")
        self.collectionView.reloadData()
        print ("****\(sectionArray)")

        print("platforms \(platforms)")
//        collectionView.reloadData()
//        wishlistCollectionView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getPlatformImage(platformName: String, mode: UIUserInterfaceStyle) -> UIImage {
       
        let platformID = changePlatformNameToID(platformName: platformName)
        
        let platformIcon = setPlatformIcon(platformID: platformID, mode: mode)
        print("platformIcon \(platformIcon)")
        guard let platformImage = UIImage(named: platformIcon) else { fatalError("no platform icon was found") }
        
        return platformImage
    }

}




extension WishlistVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let yourWidth = collectionView.bounds.width/3.0
//        let yourHeight = yourWidth
//
//        return CGSize(width: yourWidth, height: yourHeight)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets.zero
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

       if collectionView.numberOfItems(inSection: section) == 1 {

            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

           return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: collectionView.frame.width - flowLayout.itemSize.width)

       }

       return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)

   }
    
    
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {


  
//    for platform in platforms {
//        print("gamesbyplatform \(gamesByPlatform)")
//
//        let section = SectionData(isOpen: false, game: gamesByPlatform)
//        sectionArray.append(section)
//    }
    
//    print("section array \(sectionArray)")
//    platform = wishlist.filter( {$0.platformName == "\(platforms[section])" })
//    print("platform = \(platform)")
////    print("platform count = \(platform.count)")
//    print("items in section = \(platform.count)")
////    return platform.count
//    if sectionArray.count > 0 {
//        return sectionArray.count
//    } else {
//        return 0
//    }
    
    print("number of items in section = \(sectionArray[section].game.count)")
    if !sectionArray[section].isOpen {
        if sectionArray[section].game.count < 3 {
            return sectionArray[section].game.count
        } else {
      return 3
        }
    }
    return sectionArray[section].game.count

  }
  
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        guard
          let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "WishlistHeader",
            for: indexPath) as? WishlistHeaderView
          else {
            fatalError("Invalid view type")
        }
        let platformName = platforms[indexPath.section]
        let platformImage = getPlatformImage(platformName: platformName, mode: self.traitCollection.userInterfaceStyle)
        headerView.sectionHeaderDelegate = self
        headerView.moreButton.tag = indexPath.section
        headerView.headerImageView.image = platformImage
        
        if sectionArray[indexPath.section].game.count < 3 {
            headerView.moreButton.isHidden = true
        } else {
            headerView.moreButton.isHidden = false
        }
        
        let open = sectionArray[indexPath.section].isOpen
        if open {
            headerView.moreButton.setTitle("Less", for: .normal)
        } else {
            headerView.moreButton.setTitle("More", for: .normal)
        }
        
        
        return headerView
        
    }
    
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let section = indexPath.section
    let selectedIndexPath = indexPath
    
    platform = wishlist.filter( {$0.platformName == "\(platforms[section])" } )
    print("platform in cellforitem at \(platform)")
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wishlistCell", for: indexPath) as! WishlistCollectionViewCell
    
    cell.wishlistDelegate = self
    
    
    
    
    
    
    
    if sectionArray.count > 0 {
        print("indexPath \(indexPath.item)")
        print(sectionArray[indexPath.section].game.count)
        let boxartURL = sectionArray[indexPath.section].game[indexPath.item].boxartImageURL!
    
    let url = URL(string: ImageURL.medium.rawValue + boxartURL)!
//    cell.boxartImageView.loadImage(from: url) {
//        print(url)
//        print("boxart loaded")
//    }
    let placeholder = UIImage(named: "noArtNES")!
    cell.boxartImageView.setImageAnimated(imageUrl: url, placeholderImage: placeholder)
//    cell.boxartImageView.clipsToBounds = true
//    cell.addToLibraryButton.layer.cornerRadius = 15
    guard let title = sectionArray[indexPath.section].game[indexPath.item].title else { return cell }
    
    cell.gameTitleLabel.text = title
    }
    cell.addToLibraryButton.setTitle("Manage", for: .normal)
    cell.addToLibraryButton.setTitleColor(.white, for: .normal)
    
    let lightBlue = UIColorFromRGB(0x2B95CE)
    let blue = UIColorFromRGB(0x2ECAD5)
//    cell.addToLibraryButton.applyGradient(colors: [blue.cgColor, lightBlue.cgColor])
//    cell.addToLibraryButton.applyGradientRounded(layoutIfNeeded: false, colors: [blue.cgColor, lightBlue.cgColor])
    
    
    return cell
    
    
  }
  
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return platforms.count
    }
}

extension WishlistVC: SectionHeaderDelegate {

    
    
    
    func didPressButton(isOpen: Bool, section: Int) {
        print("protocol working")
        var indexPaths = [IndexPath]()
        for row in sectionArray[section].game.indices {
            print("didpressbutton 0, \(row)")
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        let open = sectionArray[section].isOpen
        sectionArray[section].isOpen = !open
        if open {
            
        } else {
            
        }
//        if open {
//            collectionView.deleteItems(at: indexPaths)
//        } else {
//            collectionView.insertItems(at: indexPaths)
//        }
        let offsetBeforeReload = collectionView.contentOffset
        let indexSet = IndexSet(integer: section)
        collectionView.reloadSections(indexSet)

        collectionView.performBatchUpdates({

        }, completion: { _ in
            self.collectionView.setContentOffset(offsetBeforeReload, animated: false)
        })
//        collectionView.reloadData()
    }
//
//
//
//        //        for section in sectionArray {
////            for game in section.game.enumerated() {
////                if sectionTitle == game.element.platformName {
////                    print("Item \(game.element) at index \(game.offset)")
//////                    sectionArray[game.offset].isOpen = isOpen
////                }
////            }
////        }
//    }
    
    
    
    
}

extension WishlistVC {
    
    func loadImages() {
        //we need to get a count of all images
        var boxarturls = wishlist.map( {$0.boxartImageURL})
        print(boxarturls)
        var imageData = wishlist.map( {$0.boxartImage})
        print(imageData)
        var images: [UIImage?] = []
        for image in imageData {
            guard let data = image else { continue }
            let image = UIImage(data: data)
        }
        let image : UIImage?
        var imageArray : [UIImage] = []
        
        for url in boxarturls {
            let imageURL = URL(string: ImageURL.medium.rawValue + url!)
            
            SDWebImageManager.shared.loadImage(with: imageURL, options: SDWebImageOptions.highPriority, progress: nil) { (image, data, error, cacheType, downloading, downloadURL) in
                
                if let error = error {
                    print("error")
                } else {
                    imageArray.append(image!)
                    self.images.append(contentsOf: imageArray)
                }
            }
        }
        self.collectionView.reloadData()
        print("images count is \(images.count)")

    }
    
    func setupCollectionView() {
      collectionView.delegate = self
      collectionView.dataSource = self
        let lightGray = UIColor(red: (246/255), green: (246/255), blue: (246/255), alpha: 1)
        collectionView.backgroundColor = lightGray
//        collectionView.contentInset = UIEdgeInsets  (top: 50, left: 0, bottom: 50, right: 0)

        self.title = "Wishlist"
        let logo = UIImage(named: "glogo44")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
   
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.backgroundColor = lightGray
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        if self.traitCollection.userInterfaceStyle == .light {
       
               collectionView.backgroundColor = UIColor(red: (246/255), green: (246/255), blue: (246/255), alpha: 1)
//            tableView.backgroundColor = UIColor.white
      
             
           } else {
//
//                tableView.backgroundColor = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
               
               collectionView.backgroundColor = UIColor.black

       }
    }
    
    func createSectionData() {
        sectionArray.removeAll()
        for platform in platforms {
        let gamesByPlatform = wishlist.filter( {$0.platformName == "\(platform)" })
                let gameSection = SectionData(isOpen: false, game: gamesByPlatform)
            if sectionArray.contains(where: { $0.game == gameSection.game }) {
                
                print("section exists")
                
            } else {
                print("section doesnt exist, adding")
                sectionArray.append(gameSection)

            }
        
        }
        print("*sectionArray \(sectionArray)")
    }
    
    
    

}


extension WishlistVC : WishlistDelegate{
func didPressManageButton(_ sender: WishlistCollectionViewCell) {
    let wishlistAction = UIAlertAction(title: "Remove from Wishlist", style: .default) { (action) in
        // Respond to selection
        let indexPath = self.collectionView.indexPath(for: sender)!
//        self.persistenceManager.delete(self.wishlist[indexPath.item])
//        self.sectionArray.remove(at: indexPath.)
        
        guard let title = self.sectionArray[indexPath.section].game[indexPath.item].title else { return }
        let gameID = self.sectionArray[indexPath.section].game[indexPath.item].gameID
        let id = Int(gameID)
        
        if self.checkForGameInWishList(name: title, id: id) {
            
            self.deleteGameFromWishList(title: title, id: id)
            self.wishlist = self.persistenceManager.fetch(WishList.self)

            self.platforms = self.wishlist.map( {$0.platformName!} )

            self.platforms.removeDuplicates()
            self.platforms.sort {
                
                $0 < $1
            }
            self.createSectionData()
//            getWishlist()
        }
        
        let image = UIImage(systemName: "trash.circle")!
        let alertView = SPAlertView(title: "Game successfully removed from wishlist.", preset: .custom(image))
        alertView.present(duration: 2.5)
//        self.collectionView.reloadSections(IndexSet(integer: indexPath.section))
        self.collectionView.reloadData()
    }
    
    let libraryAction = UIAlertAction(title: "Add to Library", style: .default) { (alert) in
        //Respond to selection
        let alertView = SPAlertView(title: "Success!!\nGame has been added to your library.\nIt will now be removed from your wishlist.", preset: .done)
        alertView.present(duration: 3)
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert) in
        //Respond to selection
    }
    
    let alertController = UIAlertController(title: "Wishlist Management", message: "Please make a selection.\n Note:\n  Adding a game to your library will remove it from your wishlist.", preferredStyle: .alert)
    alertController.addAction(libraryAction)

    alertController.addAction(wishlistAction)
    alertController.addAction(cancelAction)
    self.present(alertController, animated: true) {
        print("alert")
    }
}
    
    func checkForGameInWishList(name: String, id: Int) -> Bool {
        print("Checking for game in wishlist")
        let savedGames = persistenceManager.fetch(WishList.self)
        
        for savedGame in savedGames {
            
             if savedGame.title == name && savedGame.gameID == id {
                print("Game is in wishlist")
                return true
        }
          

    }
        
        print("Game is not in wishlist")
        return false
    
    }
    
    func deleteGameFromWishList(title: String, id: Int) {
        
        let savedGames = persistenceManager.fetch(WishList.self)
        for currentGame in savedGames {
            
            if currentGame.title == title && currentGame.gameID == id {
                
                persistenceManager.delete(currentGame)
                persistenceManager.save()
            }
        }
        
    }

}
