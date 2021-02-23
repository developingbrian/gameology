//
//  MyGameTableViewCells.swift
//  collector
//
//  Created by Brian on 11/19/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
import CoreData

protocol PhotoCellDelegate : class {
    func addPhotoButton(_ sender: PhotoCell)
    
    func reloadCollectionView()
    
}

class PhotoCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var ManualCollectionView: UICollectionView!
    
    @IBOutlet weak var GameCollectionView: UICollectionView!
    
    @IBOutlet weak var BoxCollectionView: UICollectionView!
    
    @IBOutlet weak var photoCellBackgroundView: UIView!
    
    @IBOutlet weak var addPhotoButton: UIButton!
    var persistenceManager = PersistenceManager.shared
    var images : Image?
    var vc : MyGameVC?
    var userPhotos: [Photos] = []
    var gamePhotos : [Photos] = []
    var boxPhotos:  [Photos] = []
    var manualPhotos: [Photos] = []
    var ownedGames = [SavedGames]()
    var singleGame : SavedGames?
    var gameObject = GameObject()
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        
        
        

        print("numberOfItems = \(userPhotos.count)")
//        return (vc?.userPhotos.count)!
        var photoCount = 0
        if collectionView == GameCollectionView {
            print("COLLECTION gamephotos \(gamePhotos.count)")
//            photoCount = gamePhotos.count
            return gamePhotos.count
        } else if collectionView == ManualCollectionView {
//            photoCount = manualPhotos.count
            print("COLLECTION manualPhotos \(manualPhotos.count)")

            return manualPhotos.count
        } else if collectionView == BoxCollectionView {
//            photoCount = boxPhotos.count
            print("COLLECTION boxPhotos \(boxPhotos.count)")
            return boxPhotos.count

        } else {
            
            photoCount = 0
        }
        print("returnPhotoCount = \(photoCount)")
        return photoCount
//        return userPhotos.count
        //        if let userPhotos = vc.userPhotos {
//            return userPhotos.count
//        } else {
//            return 0
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cell game = \(gameObject)")
        let cell = GameCollectionView.dequeueReusableCell(withReuseIdentifier: "userPhotoCell", for: indexPath) as? MyGameCollectionViewCell
        if collectionView == self.GameCollectionView {
            print("gamePhotos = \(gamePhotos.count)")
            if let image = gamePhotos[indexPath.row].photo {
            cell?.photoImageView.image = UIImage(data: image)
            }
            cell?.deleteButton.tag = indexPath.row
            cell?.deleteButton.addTarget(self, action: #selector(deleteGamePhoto(sender:)), for: .touchUpInside)
            
        } else if collectionView == self.ManualCollectionView {
            if let image = manualPhotos[indexPath.row].photo {
                cell?.photoImageView.image = UIImage(data: image)
                cell?.deleteButton.tag = indexPath.row
                cell?.deleteButton.addTarget(self, action: #selector(deleteManualPhoto(sender:)), for: .touchUpInside)
            }
//        if let userPhotos = images?.userPhotos {

//        }
        
        } else {
            if let image = boxPhotos[indexPath.row].photo {
                cell?.photoImageView.image = UIImage(data: image)
                cell?.deleteButton.tag = indexPath.row
                cell?.deleteButton.addTarget(self, action: #selector(deleteBoxPhoto(sender:)), for: .touchUpInside)
            }
            
            
            
        }
        
        
        return cell!
    }

    @objc func deleteGamePhoto(sender:UIButton) {
        print("Delete button pressed")
        let imageCell = sender.tag
        guard let image = gamePhotos[imageCell].photo else { return }
        guard let category = gamePhotos[imageCell].category else { return }
        deletePhotoFromCoreData(image: image, category: category)
        gamePhotos.remove(at: imageCell)
        collectionReloadData()
    }
    
    
    @objc func deleteBoxPhoto(sender:UIButton) {
        print("Delete button pressed")
        let imageCell = sender.tag
        guard let image = boxPhotos[imageCell].photo else { return }
        guard let category = boxPhotos[imageCell].category else { return }
        deletePhotoFromCoreData(image: image, category: category)
        boxPhotos.remove(at: imageCell)
        collectionReloadData()
    }
    
    @objc func deleteManualPhoto(sender:UIButton) {
        print("Delete button pressed")
        let imageCell = sender.tag
        guard let image = manualPhotos[imageCell].photo else { return }
        guard let category = manualPhotos[imageCell].category else { return }
        deletePhotoFromCoreData(image: image, category: category)
        manualPhotos.remove(at: imageCell)
        collectionReloadData()
    }

    weak var delegate : PhotoCellDelegate?
    
        override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//            self.gameObject = vc!.game
//            print("game object = \(gameObject)")

            
            ManualCollectionView.delegate = self
            ManualCollectionView.dataSource = self
            GameCollectionView.delegate = self
            GameCollectionView.dataSource = self
            BoxCollectionView.delegate = self
            BoxCollectionView.dataSource = self


//            
//            self.GameCollectionView.reloadData()
//            self.BoxCollectionView.reloadData()
//            self.ManualCollectionView.reloadData()
//            collectionReloadData()
    }
    
    override func didMoveToSuperview() {
        
//       gamePhotos = persistenceManager.fetchUserPhotos(Photos.self, category: "gamePhoto", gameTitle: gameObject.title!)
//        print("there are \(gamePhotos.count) game photos")
//        manualPhotos = persistenceManager.fetchUserPhotos(Photos.self, category: "manualPhoto", gameTitle: gameObject.title!)
//        
//        boxPhotos = persistenceManager.fetchUserPhotos(Photos.self, category: "boxPhoto", gameTitle: gameObject.title!)
//        
//        print("gamePhoto count = \(gamePhotos.count), manualPhotos count = \(manualPhotos.count), boxPhotos count = \(boxPhotos.count)")
        
//                    ownedGames = persistenceManager.fetchSingleGameObjectByName(SavedGames.self, name: gameObject.title!, platformID: (gameObject.platformID!))
//                    singleGame = ownedGames[0]
//
//        let userPhotos = persistenceManager.fetch(Photos.self)
//        print("singleGame = \(singleGame?.photo)")
////                    userPhotos = persistenceManager.fetch(Photos.self)
//        collectionReloadData()
//                    let savedGame = singleGame?.photo as! Set<Photos>
//        print(savedGame.count)
//        guard let title = gameObject.title else { return }
//        gamePhotos = userPhotos.filter({ $0.category == "gamePhotos" && $0.gameTitle == title})
//        boxPhotos = savedGame.filter({ $0.category == "boxPhotos" && $0.gameTitle == title})
//        manualPhotos = savedGame.filter({ $0.category == "manualPhotos" && $0.gameTitle == title})
//        print("\(gamePhotos.count)")
//        print("gamePhotosSuperView \(gamePhotos[0].photo)")
        self.GameCollectionView.reloadData()
        self.BoxCollectionView.reloadData()
        self.ManualCollectionView.reloadData()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionReloadData(){
         DispatchQueue.main.async(execute: {
//            self.ManualCollectionView.delegate = self
//            self.ManualCollectionView.dataSource = self
//            self.GameCollectionView.delegate = self
//            self.GameCollectionView.dataSource = self
//            self.BoxCollectionView.delegate = self
//            self.BoxCollectionView.dataSource = self
            print("collectionView Reloaded")
             self.ManualCollectionView.reloadData()
            self.BoxCollectionView.reloadData()
            self.GameCollectionView.reloadData()
         })
    }

    @IBAction func addPhotoButton(_ sender: Any) {
        print("photo cell add photo pressed")
        delegate?.addPhotoButton(self)
        
    }
    
    func reloadCollectionView() {
        delegate?.reloadCollectionView()
    }
    
    
}



class CopyCell : UITableViewCell {
    @IBOutlet weak var physicalCopySwitch: UISwitch!
    @IBOutlet weak var digitalCopySwitch: UISwitch!
    
    
    var gameObject = GameObject()
    var savedGame : SavedGames?
    var persistenceManager = PersistenceManager.shared

    @IBOutlet weak var copyCellBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func physicalCopySwitched(_ sender: Any) {
        if physicalCopySwitch.isOn {

            persistenceManager.updatePhysicalCopyOwned(objectType: SavedGames.self, gameTitle: gameObject.title!, physicalCopy: true)

            if digitalCopySwitch.isOn {
                digitalCopySwitch.setOn(false, animated: true)
                persistenceManager.updateDigitalCopyOwned(objectType: SavedGames.self, gameTitle: gameObject.title!, digitalCopy: false)
                            }
//            physicalCopySwitch.setOn(true, animated: true)
        } else {
            persistenceManager.updatePhysicalCopyOwned(objectType: SavedGames.self, gameTitle: gameObject.title!, physicalCopy: false)

//            physicalCopySwitch.setOn(false, animated: true)
            
        }
        
        
    }
    
    @IBAction func digitalCopySwitched(_ sender: Any) {
        if digitalCopySwitch.isOn {
            persistenceManager.updateDigitalCopyOwned(objectType: SavedGames.self, gameTitle: gameObject.title!, digitalCopy: true)
            if physicalCopySwitch.isOn {
                physicalCopySwitch.setOn(false, animated: true)

                persistenceManager.updatePhysicalCopyOwned(objectType: SavedGames.self, gameTitle: gameObject.title!, physicalCopy: false)
            }

//            digitalCopySwitch.setOn(true, animated: true)
            
        } else {
            persistenceManager.updateDigitalCopyOwned(objectType: SavedGames.self, gameTitle: gameObject.title!, digitalCopy: false)

//            digitalCopySwitch.setOn(false, animated: true)
            
        }
        
    }
    
}

class PriceCell : UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var priceCellBackgroundView: UIView!
    let persistenceManager = PersistenceManager.shared
    var gameObject = GameObject()
    var amt = 0
    lazy var numberFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
        
    }()

    @IBOutlet weak var priceTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        priceTextField.delegate = self
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func textFieldEditingDidEnd(_ sender: Any) {
//        let pricePaid = priceTextField.text!
//        persistenceManager.updatePricePaid(objectType: SavedGames.self, gameTitle: gameObject.title!, pricePaid: pricePaid)
        
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        

        
        if let digit = Int(string) {
            amt = amt * 10 + digit
            
            priceTextField.text = updateTextField()
            let pricePaid = priceTextField.text!
            persistenceManager.updatePricePaid(objectType: SavedGames.self, gameTitle: gameObject.title!, pricePaid: pricePaid)
        }
        
        if string == "" {
            amt = amt/10
            
            priceTextField.text = updateTextField()
            let pricePaid = priceTextField.text!
            persistenceManager.updatePricePaid(objectType: SavedGames.self, gameTitle: gameObject.title!, pricePaid: pricePaid)
        }
        return false
    }
    
    func updateTextField() -> String? {
        
        let number = Double(amt/100) + Double(amt%100)/100
        return numberFormatter.string(from: NSNumber(value: number))
    }
    

}

class NotesCell : UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var notesCellBackgroundView: UIView!
    @IBOutlet weak var notesTextView: UITextView!
    var persistenceManager = PersistenceManager.shared
    var gameObject = GameObject()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        notesTextView.delegate = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        persistenceManager.updateNotes(objectType: SavedGames.self, gameTitle: gameObject.title!, notes: notesTextView.text)
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        if(text == "\n") {
//            textView.resignFirstResponder()
//            return false
//        }
//        return true
//    }
    
}

class CompletionCell : UITableViewCell {
    @IBOutlet weak var beatSwitch: UISwitch!
    @IBOutlet weak var completeSwitch: UISwitch!
    @IBOutlet weak var completionSlider: UISlider!
    @IBOutlet weak var completionCellBackgroundView: UIView!
    @IBOutlet weak var completionLabel: UILabel!
    var persistenceManager = PersistenceManager.shared
    var gameObject = GameObject()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func beatSwitched(_ sender: Any) {
        if beatSwitch.isOn {
            persistenceManager.updateBeatStatus(objectType: SavedGames.self, gameTitle: gameObject.title!, beat: true)
            beatSwitch.setOn(true, animated: true)
        } else {
            persistenceManager.updateBeatStatus(objectType: SavedGames.self, gameTitle: gameObject.title!, beat: false)
            beatSwitch.setOn(false, animated: false)
            
        }
        
        
    }
    
    @IBAction func completionSwitched(_ sender: Any) {
        if completeSwitch.isOn {
            persistenceManager.updateCompletedStatus(objectType: SavedGames.self, gameTitle: gameObject.title!, completed:  true)
            completeSwitch.setOn(true, animated: true)
            completionSlider.setValue(100, animated: true)
            completionLabel.text = "100"
            persistenceManager.updateCompletedPercent(objectType: SavedGames.self, gameTitle: gameObject.title!, completedValue: 100)
        } else {
            persistenceManager.updateCompletedStatus(objectType: SavedGames.self, gameTitle: gameObject.title!, completed:  false)
            completeSwitch.setOn(false, animated: false)
            
        }
        
    }
    
    @IBAction func completionSliderDidSlide(_ sender: UISlider) {
//        sender.setValue(sender.value.rounded(.down), animated: true)
        let value = Int(sender.value)
        completionLabel.text = "\(value)"
        persistenceManager.updateCompletedPercent(objectType: SavedGames.self, gameTitle: gameObject.title!, completedValue: completionSlider.value)
        
        if sender.value == 100 {
            completeSwitch.setOn(true, animated: true)
            persistenceManager.updateCompletedStatus(objectType: SavedGames.self, gameTitle: gameObject.title!, completed:  true)
            
        } else {
            completeSwitch.setOn(false, animated: true)
            persistenceManager.updateCompletedStatus(objectType: SavedGames.self, gameTitle: gameObject.title!, completed:  false)
        }
        
    }
}

class ConditionCell : UITableViewCell {
    @IBOutlet weak var conditionCellBackgroundView: UIView!
    @IBOutlet weak var gameOwnedSwitch: UISwitch!
    @IBOutlet weak var manualOwnedSwitch: UISwitch!
    @IBOutlet weak var boxOwnedSwitch: UISwitch!
    @IBOutlet weak var gameConditionSlider: UISlider!
    @IBOutlet weak var boxConditionSlider: UISlider!
    @IBOutlet weak var manualConditionSlider: UISlider!
    @IBOutlet weak var gameConditionLbl: UILabel!
    @IBOutlet weak var boxConditionLbl: UILabel!
    @IBOutlet weak var manualConditionLbl: UILabel!
    var persistenceManager = PersistenceManager.shared
    var gameObject = GameObject()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func gameConditionSliderDidSlide(_ sender: UISlider) {
        
//        sender.setValue(sender.value.rounded(.down), animated: true)
        let value = Int(sender.value)
        gameConditionLbl.text = "\(value)"
        persistenceManager.updateGameConditionPercent(objectType: SavedGames.self, gameTitle: gameObject.title!, gameCondition: sender.value)

        
    }
    
    @IBAction func boxConditionSliderDidSlide(_ sender: UISlider) {
//        sender.setValue(sender.value.rounded(.down), animated: true)
        let value = Int(sender.value)
        boxConditionLbl.text = "\(value)"
        persistenceManager.updateBoxConditionPercent(objectType: SavedGames.self, gameTitle: gameObject.title!, boxCondition: sender.value)
    }
    
    @IBAction func manualConditionSliderDidSlide(_ sender: UISlider) {
//        sender.setValue(sender.value.rounded(.down), animated: true)
        let value = Int(sender.value)
        manualConditionLbl.text = "\(value)"
        persistenceManager.updateManualConditionPercent(objectType: SavedGames.self, gameTitle: gameObject.title!, manualCondition: sender.value)
        
    }
    
    
    @IBAction func gameOwnedSwitched(_ sender: Any) {
        if gameOwnedSwitch.isOn {
            persistenceManager.updateGameOwned(objectType: SavedGames.self, gameTitle: gameObject.title!, gameOwned: true)
            gameConditionSlider.layer.opacity = 1
            gameConditionSlider.setValue(0, animated: true)
            gameConditionLbl.text = "0"
            gameConditionSlider.isEnabled = false

        } else {
            persistenceManager.updateGameOwned(objectType: SavedGames.self, gameTitle: gameObject.title!, gameOwned: false)
            gameConditionSlider.setValue(0, animated: true)
            gameConditionLbl.text = "-"
            gameConditionSlider.layer.opacity = 0.5
            gameConditionSlider.isEnabled = true
        }
        
    }
    
    
    @IBAction func boxOwnedSwitched(_ sender: Any) {
        if boxOwnedSwitch.isOn {
            persistenceManager.updateBoxOwned(objectType: SavedGames.self, gameTitle: gameObject.title!, boxOwned: true)
            boxConditionSlider.layer.opacity = 1
            boxConditionSlider.setValue(0, animated: true)
            boxConditionLbl.text = "0"
            boxConditionSlider.isEnabled = true

        } else {
            persistenceManager.updateBoxOwned(objectType: SavedGames.self, gameTitle: gameObject.title!, boxOwned: false)
            boxConditionSlider.setValue(0, animated: true)
            boxConditionLbl.text = "-"
            boxConditionSlider.layer.opacity = 0.5
            boxConditionSlider.isEnabled = false

        }
        
    }
    
    @IBAction func manualOwnedSwitched(_ sender: Any) {
        if manualOwnedSwitch.isOn {
            persistenceManager.updateManualOwned(objectType: SavedGames.self, gameTitle: gameObject.title!, manualOwned: true)
            manualConditionSlider.layer.opacity = 1
            manualConditionSlider.setValue(0, animated: true)
            manualConditionLbl.text = "0"
            manualConditionSlider.isEnabled = true

        } else {
            persistenceManager.updateManualOwned(objectType: SavedGames.self, gameTitle: gameObject.title!, manualOwned: false)
            manualConditionSlider.setValue(0, animated: true)
            manualConditionLbl.text = "-"
            manualConditionSlider.layer.opacity = 0.5
            manualConditionSlider.isEnabled = false

        }
        
    }
    
}
