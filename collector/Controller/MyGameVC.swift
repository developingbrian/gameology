//
//  MyGameVC.swift
//  collector
//
//  Created by Brian on 11/19/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
import CoreData


class MyGameVC: UIViewController, UITableViewDelegate, UITableViewDataSource, PhotoCellDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate {
    
    let persistenceManager = PersistenceManager.shared
    var game = GameObject()
    var images : Image?
    var userPhotos : [Photos] = [Photos]()
    var ownedGames = [SavedGames]()
    var singleGame : SavedGames?
    var gamePhotos : [Photos] = [Photos]()
    var manualPhotos : [Photos] = [Photos]()
    var boxPhotos : [Photos] = [Photos]()
    
    func reloadCollectionView() {
        print("reloadCollectionView")
        
    }
    
    func addPhotoButton(_ sender: PhotoCell) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
        print("addPhotoButton Pressed")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        var categoryString = ""
        // Create the action buttons for the alert.
        let gameAction = UIAlertAction(title: "Game Photo",
                                       style: .default) { (action) in
         // Respond to user selection of the action.
            
            categoryString = "gamePhoto"
            print("inside action categorystring \(categoryString)")
            
            guard let image = info[.editedImage] as? UIImage else {
                print("No image found")
                return
            }
            guard let title = self.game.title else { return }
            
            print("categoryString = \(categoryString)")
            self.savePhotoToCoreData(image: image, category: categoryString, gameTitle: title)
        }
        
        let manualAction = UIAlertAction(title: "Manual Photo",
                             style: .default) { (action) in
         // Respond to user selection of the action.
            categoryString = "manualPhoto"
            
            guard let image = info[.editedImage] as? UIImage else {
                print("No image found")
                return
            }
            guard let title = self.game.title else { return }
            
            print("categoryString = \(categoryString)")
            self.savePhotoToCoreData(image: image, category: categoryString, gameTitle: title)
        }
        
        let boxAction = UIAlertAction(title: "Box Photo", style: .default) { (action) in
            // Respond to user selection of the action.
            
            categoryString = "boxPhoto"
            
            guard let image = info[.editedImage] as? UIImage else {
                print("No image found")
                return
            }
            guard let title = self.game.title else { return }
            
            print("categoryString = \(categoryString)")
            self.savePhotoToCoreData(image: image, category: categoryString, gameTitle: title)
        }
        
        let alert = UIAlertController(title: "Category", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(gameAction)
        alert.addAction(manualAction)
        alert.addAction(boxAction)
        
        self.present(alert, animated: true) {
            
        }
        
        

//
//        let imageData = image.pngData()
//
//        let photos = Photos(context: persistenceManager.context)
//        guard let title = game.title else { return }
//        photos.category = categoryString
//        photos.photo = imageData
//        photos.gameTitle = title
////        retrieve saved game
//        //save photo to core data by category
//
//        singleGame?.addToPhoto(photos)
//        persistenceManager.save()
//
////        savePhotoToCoreData(image: image, category: "gamePhoto")
//        //        var array : [UIImage] = []
////        array.append(image)
////        print(array)
////        print(array.count)
////        images?.userPhotos = array
////        userPhotos.append(image)
//        // print out the image size as a test
////        self.reloadCollectionView()
//
//        print("userphotos count = \(singleGame?.photo?.count)")
//        var myRow = 0 // include the index path row of your table view cell
//        var mySection = 0 // and the index path section
//
//         DispatchQueue.main.async(execute: {
//                if let index = IndexPath(row: myRow, section: mySection) as? IndexPath {
////                     if let cell = self.tableView.dequeueReusableCell(withIdentifier: "UserPhotos", for: index) as? PhotoCell {
////                        cell.collectionReloadData()
////
////
////                     }
//
//                    if let cell = self.tableView.cellForRow(at: index) as? PhotoCell {
//
//                        cell.collectionReloadData()
//                    }
//               }
//        })

//        print(image.size)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Photos"
        case 1:
            return "Details"
        case 2:
            return nil
        case 3:
            return nil
        case 4:
            return "Completion Status"
        case 5:
            return "Condition"
        default:
            print("Invalid Section")
            return nil
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var initialCell = UITableViewCell()
        
        switch indexPath.section {
        
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserPhotos", for: indexPath) as! PhotoCell
            initialCell = cell
            cell.delegate = self
//            cell?.userPhotos = userPhotos
            print("cellforrowat game = \(self.game)")
            cell.gameObject = self.game
            cell.gamePhotos = self.gamePhotos
            cell.boxPhotos = self.boxPhotos
            cell.manualPhotos = self.manualPhotos
            print("cell.game = \(cell.gameObject)")
            cell.addPhotoButton.layer.cornerRadius = 10
            
            if traitCollection.userInterfaceStyle == .light {
                let lightGray = UIColor(red: (246/255), green: (246/255), blue: (246/255), alpha: 1)
                cell.photoCellBackgroundView.backgroundColor = lightGray
                cell.addPhotoButton.backgroundColor = .white
                cell.BoxCollectionView.backgroundColor = lightGray
                cell.GameCollectionView.backgroundColor = lightGray
                cell.ManualCollectionView.backgroundColor = lightGray

            } else {
                cell.addPhotoButton.backgroundColor = .tertiarySystemBackground
                cell.photoCellBackgroundView.backgroundColor = .black
                cell.BoxCollectionView.backgroundColor = .black
                cell.GameCollectionView.backgroundColor = .black
                cell.ManualCollectionView.backgroundColor = .black
                
            }

            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "copyCell", for: indexPath) as! CopyCell
            cell.gameObject = self.game
            cell.savedGame = singleGame
            
            let savedGames = persistenceManager.fetch(SavedGames.self)
            for savedGame in savedGames {
                if savedGame.title == game.title {
                    print("physicalcopy \(savedGame.physicalCopy)")
                    if savedGame.physicalCopy == true {
                        cell.physicalCopySwitch.setOn(true, animated: false)
                    } else {
                        cell.physicalCopySwitch.setOn(false, animated: false)
                        
                    }
                    
                    if savedGame.digitalCopy == true {
                        cell.digitalCopySwitch.setOn(true, animated: false)
                    } else {
                        cell.digitalCopySwitch.setOn(false, animated: false)
                    }
                    
                }
            }
            
            if traitCollection.userInterfaceStyle == .light {
                cell.copyCellBackgroundView.backgroundColor = UIColor(red: (246/255), green: (246/255), blue: (246/255), alpha: 1)
            } else {
                cell.copyCellBackgroundView.backgroundColor = .black
            }
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "priceCell", for: indexPath) as? PriceCell
            
            cell?.gameObject = self.game
            let savedGames = persistenceManager.fetch(SavedGames.self)
            for savedGame in savedGames {
                if savedGame.title == game.title {
                    if let price = savedGame.pricePaid {
                    cell?.priceTextField.text = price
                    }
                    
                    
                }
            }
            cell?.priceTextField.layer.cornerRadius = 10
            
            if traitCollection.userInterfaceStyle == .light {
                cell?.priceCellBackgroundView.backgroundColor = UIColor(red: (246/255), green: (246/255), blue: (246/255), alpha: 1)
            } else {
                cell?.priceCellBackgroundView.backgroundColor = .black
            }
            
            return cell!
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as? NotesCell
            cell?.gameObject = self.game
            let savedGames = persistenceManager.fetch(SavedGames.self)
            for savedGame in savedGames {
                if savedGame.title == game.title {
                    let notes = savedGame.notes
                    cell?.notesTextView.delegate = self
                    cell?.notesTextView.text = notes
                    
                    
                }
            }
            if traitCollection.userInterfaceStyle == .light {
                cell?.notesCellBackgroundView.backgroundColor = UIColor(red: (246/255), green: (246/255), blue: (246/255), alpha: 1)
            } else {
                cell?.notesCellBackgroundView.backgroundColor = .black
            }
            
            return cell!
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "completionCell", for: indexPath) as? CompletionCell
            cell?.gameObject = self.game
            let savedGames = persistenceManager.fetch(SavedGames.self)
            for savedGame in savedGames {
                if savedGame.title == game.title {
                    print("physicalcopy \(savedGame.physicalCopy)")
                    if savedGame.hasCompleted == true {
                        cell?.completeSwitch.setOn(true, animated: false)
                    } else {
                        cell?.completeSwitch.setOn(false, animated: false)
                        
                    }
                    
                    if savedGame.hasBeaten == true {
                        cell?.beatSwitch.setOn(true, animated: false)
                    } else {
                        cell?.beatSwitch.setOn(false, animated: false)
                    }
                    
                    
                    cell?.completionSlider.setValue(savedGame.percentComplete, animated: false)
                    cell?.completionLabel.text = "\(savedGame.percentComplete)"
                    
                }
            }
            
            if traitCollection.userInterfaceStyle == .light {
                cell?.completionCellBackgroundView.backgroundColor = UIColor(red: (246/255), green: (246/255), blue: (246/255), alpha: 1)
            } else {
                cell?.completionCellBackgroundView.backgroundColor = .black
            }
            return cell!
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "conditionCell", for: indexPath) as? ConditionCell
            cell?.gameObject = self.game
            let savedGames = persistenceManager.fetch(SavedGames.self)
            for savedGame in savedGames {
                if savedGame.title == game.title {
                    if savedGame.gameOwned == true {
                        cell?.gameOwnedSwitch.setOn(true, animated: false)
                        cell?.gameConditionSlider.isEnabled = true
                        cell?.gameConditionSlider.layer.opacity = 1
                        cell?.gameConditionSlider.setValue(savedGame.gameCondition, animated: false)
                        let gameCondition = Int(savedGame.gameCondition)
                        cell?.gameConditionLbl.text = "\(gameCondition)"
                    } else {
                        cell?.gameOwnedSwitch.setOn(false, animated: false)
                        cell?.gameConditionSlider.isEnabled = false
                        cell?.gameConditionSlider.layer.opacity = 0.5
                        cell?.gameConditionLbl.text = "-"

                    }
                    
                    
                    if savedGame.boxOwned == true {
                        cell?.boxOwnedSwitch.setOn(true, animated: false)
                        cell?.boxConditionSlider.isEnabled = true
                        cell?.boxConditionSlider.layer.opacity = 1
                        cell?.boxConditionSlider.setValue(savedGame.boxCondition, animated: false)
                        let boxCondition = Int(savedGame.boxCondition)
                        cell?.manualConditionLbl.text = "\(boxCondition)"
                    } else {
                        cell?.boxOwnedSwitch.setOn(false, animated: false)
                        cell?.boxConditionSlider.isEnabled = false
                        cell?.boxConditionSlider.layer.opacity = 0.5
                        cell?.boxConditionLbl.text = "-"

                    }
                    
                    if savedGame.manualOwned == true {
                        cell?.manualOwnedSwitch.setOn(true, animated: false)
                        cell?.manualConditionSlider.isEnabled = true
                        cell?.manualConditionSlider.layer.opacity = 1
                        cell?.manualConditionSlider.setValue(savedGame.manualCondition, animated: false)
                        let manualCondition = Int(savedGame.manualCondition)
                        cell?.manualConditionLbl.text = "\(manualCondition)"

                    } else {
                        cell?.manualOwnedSwitch.setOn(false, animated: false)
                        cell?.manualConditionSlider.isEnabled = false
                        cell?.manualConditionSlider.layer.opacity = 0.5
                        cell?.manualConditionLbl.text = "-"

                    }
                    

                    

                }
            }
            
            if traitCollection.userInterfaceStyle == .light {
                cell?.conditionCellBackgroundView.backgroundColor = UIColor(red: (246/255), green: (246/255), blue: (246/255), alpha: 1)
            } else {
                cell?.conditionCellBackgroundView.backgroundColor = .black
            }
            
            return cell!
        default:
            return initialCell
        }
        
        
        }
        
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGestureReconizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureReconizer)
        
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
//            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//
//              // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
//            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        
        // Do any additional setup after loading the view.
    }
    
    @objc func tap() {
        view.endEditing(true)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            tableView.contentInset = .zero
        } else {
            
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }

        tableView.scrollIndicatorInsets = tableView.contentInset


    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
            print("keyboardWillShow()")
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      
      // move the root view up by the distance of keyboard height
//      self.view.frame.origin.y = 0 - keyboardSize.height
        tableView.contentSize = CGSize(width: tableView.frame.width, height: tableView.frame.height)
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
         tableView.contentInset = contentInsets
         tableView.scrollIndicatorInsets = contentInsets
        print("content moved")
    }

    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
//      self.view.frame.origin.y = 0
        print("keyboardWillHide()")
        tableView.contentSize = CGSize(width: tableView.frame.width, height: tableView.frame.height)

        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            
        
        // reset back the content inset to zero after keyboard is gone
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getUserPhotos()

        print("mygamevc game = \(game)")
        self.ownedGames = persistenceManager.fetchSingleGameObjectByName(SavedGames.self, name: game.title!, platformID: game.platformID!)
        singleGame = ownedGames[0]
        self.tableView.reloadData()
    }
    
    func getUserPhotos() {
        gamePhotos = persistenceManager.fetchUserPhotos(Photos.self, category: "gamePhoto", gameTitle: game.title!)
         print("there are \(gamePhotos.count) game photos")
         manualPhotos = persistenceManager.fetchUserPhotos(Photos.self, category: "manualPhoto", gameTitle: game.title!)
         
         boxPhotos = persistenceManager.fetchUserPhotos(Photos.self, category: "boxPhoto", gameTitle: game.title!)
         
         print("gamePhoto count = \(gamePhotos.count), manualPhotos count = \(manualPhotos.count), boxPhotos count = \(boxPhotos.count)")
       
        for photo in gamePhotos {
            print("photo category \(photo.category)")
            print("photo game name \(photo.gameTitle)")
            
        }
        for photo in manualPhotos {
            print("photo category \(photo.category)")
            print("photo game name \(photo.gameTitle)")
            
        }
        for photo in boxPhotos {
            print("photo category \(photo.category)")
            print("photo game name \(photo.gameTitle)")
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//    func savePhotoToCoreData(image: UIImage, category: String, gameTitle: String) {
//        
//        let imageData = image.pngData()
//        
//        let photo = Photos(context: persistenceManager.context)
//        photo.photo = imageData
//        photo.category = category
//        photo.gameTitle = gameTitle
//        
//        persistenceManager.save()
//        
//        let deadline = DispatchTime.now() + 2
//        
//        DispatchQueue.main.asyncAfter(deadline: deadline) {
//            
//            self.getSavedPhotos()
//        }
//        if let index = IndexPath(row: 0, section: 0) as? IndexPath {
//        if let cell = self.tableView.cellForRow(at: index) as? PhotoCell {
//            
//            cell.collectionReloadData()
//        }
//        }
//    }
    
}
