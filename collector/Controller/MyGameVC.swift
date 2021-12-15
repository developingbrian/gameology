//
//  MyGameVC.swift
//  collector
//
//  Created by Brian on 11/19/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
import CoreData


class MyGameVC: UIViewController, PhotoCellDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    let persistenceManager = PersistenceManager.shared
    var game = GameObject()
    var images : Image?
    var userPhotos : [Photos] = [Photos]()
    var ownedGames = [SavedGames]()
    var singleGame : SavedGames?
    var gamePhotos : [Photos] = [Photos]()
    var manualPhotos : [Photos] = [Photos]()
    var boxPhotos : [Photos] = [Photos]()
    let network = Networking.shared
    let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)

    let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
    @IBOutlet weak var tableView: UITableView!
    
    
    deinit {
        
        print("mygamevc is now deallocated")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 45, left: 0, bottom: 0, right: 0)
        setAppearance()
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGestureReconizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureReconizer)
        
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//
//              // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        
        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getUserPhotos()

        print("mygamevc game = \(game)")
        self.ownedGames = persistenceManager.fetchSingleGameObjectByName(SavedGames.self, name: game.title!, platformID: game.platformID!)
        singleGame = ownedGames[0]
        setAppearance()
        reloadCollectionView()
        self.tableView.reloadData()
        
    }
    
    
    
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
    

    
    
    
    @objc func tap() {
        view.endEditing(true)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
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
    

    
    
    
    func getUserPhotos() {
        gamePhotos = persistenceManager.fetchUserPhotos(Photos.self, category: "gamePhoto", gameTitle: game.title!)
         print("there are \(gamePhotos.count) game photos")
         manualPhotos = persistenceManager.fetchUserPhotos(Photos.self, category: "manualPhoto", gameTitle: game.title!)
         
         boxPhotos = persistenceManager.fetchUserPhotos(Photos.self, category: "boxPhoto", gameTitle: game.title!)
         
         print("gamePhoto count = \(gamePhotos.count), manualPhotos count = \(manualPhotos.count), boxPhotos count = \(boxPhotos.count)")
       
        for photo in gamePhotos {
            print("photo category \(String(describing: photo.category))")
            print("photo game name \(String(describing: photo.gameTitle))")
            
        }
        for photo in manualPhotos {
            print("photo category \(String(describing: photo.category))")
            print("photo game name \(String(describing: photo.gameTitle))")
            
        }
        for photo in boxPhotos {
            print("photo category \(String(describing: photo.category))")
            print("photo game name \(String(describing: photo.gameTitle))")
            
        }
        
    }
    

    
    func setAppearance() {
        print("setting appearance")
        
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

            tableView.layer.backgroundColor = lightGray.cgColor

        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)

            tableView.layer.backgroundColor = darkGray.cgColor

        }
    }
    

    
}


extension MyGameVC: UITableViewDelegate, UITableViewDataSource {
    
    
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
            cell.parent = self
            print("cellforrowat game = \(self.game)")
            cell.gameObject = self.game
            cell.gamePhotos = self.gamePhotos
            cell.boxPhotos = self.boxPhotos
            cell.manualPhotos = self.manualPhotos
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "copyCell", for: indexPath) as! CopyCell
            cell.gameObject = self.game
            cell.savedGame = singleGame
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "priceCell", for: indexPath) as! PriceCell
            
            cell.gameObject = self.game
            
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as! NotesCell
            cell.gameObject = self.game
            cell.notesTextView.delegate = self

            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "completionCell", for: indexPath) as! CompletionCell
            cell.gameObject = self.game

            
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "conditionCell", for: indexPath) as? ConditionCell
            cell?.gameObject = self.game
 
            
            return cell!
        default:
            return initialCell
        }
        
        
        }
        
    
}



extension MyGameVC: UIImagePickerControllerDelegate {
    
    
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
        

        
    }
    
    
    
}
