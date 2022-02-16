//
//  MyGameTableViewCells.swift
//  collector
//
//  Created by Brian on 11/19/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
import CoreData

class CopyCell : UITableViewCell {
    @IBOutlet weak var physicalCopySwitch: UISwitch!
    @IBOutlet weak var digitalCopySwitch: UISwitch!
    let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    
    let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
    
    
    var gameObject : GameObject? {
        didSet {
            configureCell()
        }
    }
    var savedGame : SavedGames?
    var persistenceManager = PersistenceManager.shared
    
    @IBOutlet weak var copyCellBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    func configureCell() {
        setAppearance()
        
        guard let title = gameObject?.title else { return }
        let savedGames = persistenceManager.fetch(SavedGames.self)
        for savedGame in savedGames {
            if savedGame.title == title {
                
                if savedGame.physicalCopy == true {
                    physicalCopySwitch.setOn(true, animated: false)
                } else {
                    physicalCopySwitch.setOn(false, animated: false)
                    
                }
                
                if savedGame.digitalCopy == true {
                    digitalCopySwitch.setOn(true, animated: false)
                } else {
                    digitalCopySwitch.setOn(false, animated: false)
                }
                
            }
        }
        
    }
    
    func setAppearance() {
        
        if traitCollection.userInterfaceStyle == .light {
            copyCellBackgroundView.backgroundColor = lightGray
        } else {
            copyCellBackgroundView.backgroundColor = darkGray
        }
        
    }
    
    
    @IBAction func physicalCopySwitched(_ sender: Any) {
        guard let title = gameObject?.title else { return }
        if physicalCopySwitch.isOn {
            
            persistenceManager.updatePhysicalCopyOwned(objectType: SavedGames.self, gameTitle: title, physicalCopy: true)
            
            if digitalCopySwitch.isOn {
                digitalCopySwitch.setOn(false, animated: true)
                guard let title = gameObject?.title else { return }
                persistenceManager.updateDigitalCopyOwned(objectType: SavedGames.self, gameTitle: title, digitalCopy: false)
            }
        } else {
            persistenceManager.updatePhysicalCopyOwned(objectType: SavedGames.self, gameTitle: title, physicalCopy: false)
            
            
        }
        
        
    }
    
    @IBAction func digitalCopySwitched(_ sender: Any) {
        guard let title = gameObject?.title else { return }
        
        if digitalCopySwitch.isOn {
            persistenceManager.updateDigitalCopyOwned(objectType: SavedGames.self, gameTitle: title, digitalCopy: true)
            if physicalCopySwitch.isOn {
                physicalCopySwitch.setOn(false, animated: true)
                
                persistenceManager.updatePhysicalCopyOwned(objectType: SavedGames.self, gameTitle: title, physicalCopy: false)
            }
            
            
        } else {
            persistenceManager.updateDigitalCopyOwned(objectType: SavedGames.self, gameTitle: title, digitalCopy: false)
            
        }
        
    }
    
}

class PriceCell : UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var priceCellBackgroundView: UIView!
    let persistenceManager = PersistenceManager.shared
    var gameObject : GameObject? {
        didSet {
            configureCell()
        }
    }
    let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    
    let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
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
    
    func configureCell() {
        setAppearance()
        guard let title = gameObject?.title else { return }
        let savedGames = persistenceManager.fetch(SavedGames.self)
        for savedGame in savedGames {
            if savedGame.title == title {
                if let price = savedGame.pricePaid {
                    priceTextField.text = price
                }
                
                
            }
        }
        priceTextField.layer.cornerRadius = 10
        
        
    }
    
    
    func setAppearance () {
        
        if traitCollection.userInterfaceStyle == .light {
            priceCellBackgroundView.backgroundColor = lightGray
        } else {
            priceCellBackgroundView.backgroundColor = darkGray
        }
        
    }
    
    @IBAction func textFieldEditingDidEnd(_ sender: Any) {
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let title = gameObject?.title else { return false }
        
        
        if let digit = Int(string) {
            amt = amt * 10 + digit
            
            priceTextField.text = updateTextField()
            let pricePaid = priceTextField.text!
            persistenceManager.updatePricePaid(objectType: SavedGames.self, gameTitle: title, pricePaid: pricePaid)
        }
        
        if string == "" {
            amt = amt/10
            
            priceTextField.text = updateTextField()
            let pricePaid = priceTextField.text!
            persistenceManager.updatePricePaid(objectType: SavedGames.self, gameTitle: title, pricePaid: pricePaid)
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
    var gameObject : GameObject? {
        didSet {
            
            configureCell()
        }
    }
    let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    
    let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        notesTextView.delegate = self
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell() {
        setAppearance()
        
        guard let title = gameObject?.title else { return }
        
        let savedGames = persistenceManager.fetch(SavedGames.self)
        for savedGame in savedGames {
            if savedGame.title == title {
                let notes = savedGame.notes
                
                notesTextView.text = notes
                
                
            }
        }
        
        
    }
    
    
    func setAppearance() {
        if traitCollection.userInterfaceStyle == .light {
            notesCellBackgroundView.backgroundColor = lightGray
        } else {
            notesCellBackgroundView.backgroundColor = darkGray
        }
        
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let title = gameObject?.title else { return }
        persistenceManager.updateNotes(objectType: SavedGames.self, gameTitle: title, notes: notesTextView.text)
    }
    
    
    
}

class CompletionCell : UITableViewCell {
    @IBOutlet weak var beatSwitch: UISwitch!
    @IBOutlet weak var completeSwitch: UISwitch!
    @IBOutlet weak var completionSlider: UISlider!
    @IBOutlet weak var completionCellBackgroundView: UIView!
    @IBOutlet weak var completionLabel: UILabel!
    var persistenceManager = PersistenceManager.shared
    var gameObject : GameObject? {
        didSet {
            
            configureCell()
        }
    }
    let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    
    let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell() {
        setAppearance()
        
        guard let title = gameObject?.title else { return }
        
        let savedGames = persistenceManager.fetch(SavedGames.self)
        for savedGame in savedGames {
            if savedGame.title == title{
                
                if savedGame.hasCompleted == true {
                    completeSwitch.setOn(true, animated: false)
                } else {
                    completeSwitch.setOn(false, animated: false)
                    
                }
                
                if savedGame.hasBeaten == true {
                    beatSwitch.setOn(true, animated: false)
                } else {
                    beatSwitch.setOn(false, animated: false)
                }
                
                
                completionSlider.setValue(savedGame.percentComplete, animated: false)
                completionLabel.text = "\(savedGame.percentComplete)"
                
            }
        }
        
        
    }
    
    func setAppearance() {
        
        if traitCollection.userInterfaceStyle == .light {
            completionCellBackgroundView.backgroundColor = lightGray
        } else {
            completionCellBackgroundView.backgroundColor = darkGray
        }
        
        
    }
    
    @IBAction func beatSwitched(_ sender: Any) {
        
        guard let title = gameObject?.title else { return }
        
        if beatSwitch.isOn {
            persistenceManager.updateBeatStatus(objectType: SavedGames.self, gameTitle: title, beat: true)
            beatSwitch.setOn(true, animated: true)
        } else {
            persistenceManager.updateBeatStatus(objectType: SavedGames.self, gameTitle: title, beat: false)
            beatSwitch.setOn(false, animated: false)
            
        }
        
        
    }
    
    @IBAction func completionSwitched(_ sender: Any) {
        guard let title = gameObject?.title else { return }
        
        if completeSwitch.isOn {
            persistenceManager.updateCompletedStatus(objectType: SavedGames.self, gameTitle: title, completed:  true)
            completeSwitch.setOn(true, animated: true)
            completionSlider.setValue(100, animated: true)
            completionLabel.text = "100"
            persistenceManager.updateCompletedPercent(objectType: SavedGames.self, gameTitle: title, completedValue: 100)
        } else {
            persistenceManager.updateCompletedStatus(objectType: SavedGames.self, gameTitle: title, completed:  false)
            completeSwitch.setOn(false, animated: false)
            
        }
        
    }
    
    @IBAction func completionSliderDidSlide(_ sender: UISlider) {
        
        guard let title = gameObject?.title else { return }
        let value = Int(sender.value)
        completionLabel.text = "\(value)"
        persistenceManager.updateCompletedPercent(objectType: SavedGames.self, gameTitle: title, completedValue: completionSlider.value)
        
        if sender.value == 100 {
            completeSwitch.setOn(true, animated: true)
            persistenceManager.updateCompletedStatus(objectType: SavedGames.self, gameTitle: title, completed:  true)
            
        } else {
            completeSwitch.setOn(false, animated: true)
            persistenceManager.updateCompletedStatus(objectType: SavedGames.self, gameTitle: title, completed:  false)
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
    var gameObject : GameObject? {
        didSet {
            configureCell()
            
        }
    }
    let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    
    let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func configureCell() {
        setAppearance()
        
        guard let title = gameObject?.title else { return }
        let savedGames = persistenceManager.fetch(SavedGames.self)
        for savedGame in savedGames {
            if savedGame.title == title {
                if savedGame.gameOwned == true {
                    gameOwnedSwitch.setOn(true, animated: false)
                    gameConditionSlider.isEnabled = true
                    gameConditionSlider.layer.opacity = 1
                    gameConditionSlider.setValue(savedGame.gameCondition, animated: false)
                    let gameCondition = Int(savedGame.gameCondition)
                    gameConditionLbl.text = "\(gameCondition)"
                } else {
                    gameOwnedSwitch.setOn(false, animated: false)
                    gameConditionSlider.isEnabled = false
                    gameConditionSlider.layer.opacity = 0.5
                    gameConditionLbl.text = "-"
                    
                }
                
                
                if savedGame.boxOwned == true {
                    boxOwnedSwitch.setOn(true, animated: false)
                    boxConditionSlider.isEnabled = true
                    boxConditionSlider.layer.opacity = 1
                    boxConditionSlider.setValue(savedGame.boxCondition, animated: false)
                    let boxCondition = Int(savedGame.boxCondition)
                    manualConditionLbl.text = "\(boxCondition)"
                } else {
                    boxOwnedSwitch.setOn(false, animated: false)
                    boxConditionSlider.isEnabled = false
                    boxConditionSlider.layer.opacity = 0.5
                    boxConditionLbl.text = "-"
                    
                }
                
                if savedGame.manualOwned == true {
                    manualOwnedSwitch.setOn(true, animated: false)
                    manualConditionSlider.isEnabled = true
                    manualConditionSlider.layer.opacity = 1
                    manualConditionSlider.setValue(savedGame.manualCondition, animated: false)
                    let manualCondition = Int(savedGame.manualCondition)
                    manualConditionLbl.text = "\(manualCondition)"
                    
                } else {
                    manualOwnedSwitch.setOn(false, animated: false)
                    manualConditionSlider.isEnabled = false
                    manualConditionSlider.layer.opacity = 0.5
                    manualConditionLbl.text = "-"
                    
                }
                
                
                
                
            }
        }
        
        
    }
    
    
    func setAppearance() {
        
        if traitCollection.userInterfaceStyle == .light {
            conditionCellBackgroundView.backgroundColor = lightGray
        } else {
            conditionCellBackgroundView.backgroundColor = darkGray
        }
        
        
    }
    
    
    @IBAction func gameConditionSliderDidSlide(_ sender: UISlider) {
        
        guard let title = gameObject?.title else { return }
        let value = Int(sender.value)
        gameConditionLbl.text = "\(value)"
        persistenceManager.updateGameConditionPercent(objectType: SavedGames.self, gameTitle: title, gameCondition: sender.value)
        
        
    }
    
    @IBAction func boxConditionSliderDidSlide(_ sender: UISlider) {
        guard let title = gameObject?.title else { return }
        
        let value = Int(sender.value)
        boxConditionLbl.text = "\(value)"
        persistenceManager.updateBoxConditionPercent(objectType: SavedGames.self, gameTitle: title, boxCondition: sender.value)
    }
    
    @IBAction func manualConditionSliderDidSlide(_ sender: UISlider) {
        
        guard let title = gameObject?.title else { return }
        
        let value = Int(sender.value)
        manualConditionLbl.text = "\(value)"
        persistenceManager.updateManualConditionPercent(objectType: SavedGames.self, gameTitle: title, manualCondition: sender.value)
        
    }
    
    
    @IBAction func gameOwnedSwitched(_ sender: Any) {
        guard let title = gameObject?.title else { return }
        
        if gameOwnedSwitch.isOn {
            persistenceManager.updateGameOwned(objectType: SavedGames.self, gameTitle: title, gameOwned: true)
            gameConditionSlider.layer.opacity = 1
            gameConditionSlider.setValue(0, animated: true)
            gameConditionLbl.text = "0"
            gameConditionSlider.isEnabled = false
            
        } else {
            persistenceManager.updateGameOwned(objectType: SavedGames.self, gameTitle: title, gameOwned: false)
            gameConditionSlider.setValue(0, animated: true)
            gameConditionLbl.text = "-"
            gameConditionSlider.layer.opacity = 0.5
            gameConditionSlider.isEnabled = true
        }
        
    }
    
    
    @IBAction func boxOwnedSwitched(_ sender: Any) {
        guard let title = gameObject?.title else { return }
        
        if boxOwnedSwitch.isOn {
            persistenceManager.updateBoxOwned(objectType: SavedGames.self, gameTitle: title, boxOwned: true)
            boxConditionSlider.layer.opacity = 1
            boxConditionSlider.setValue(0, animated: true)
            boxConditionLbl.text = "0"
            boxConditionSlider.isEnabled = true
            
        } else {
            persistenceManager.updateBoxOwned(objectType: SavedGames.self, gameTitle: title, boxOwned: false)
            boxConditionSlider.setValue(0, animated: true)
            boxConditionLbl.text = "-"
            boxConditionSlider.layer.opacity = 0.5
            boxConditionSlider.isEnabled = false
            
        }
        
    }
    
    @IBAction func manualOwnedSwitched(_ sender: Any) {
        guard let title = gameObject?.title else { return }
        
        if manualOwnedSwitch.isOn {
            persistenceManager.updateManualOwned(objectType: SavedGames.self, gameTitle: title, manualOwned: true)
            manualConditionSlider.layer.opacity = 1
            manualConditionSlider.setValue(0, animated: true)
            manualConditionLbl.text = "0"
            manualConditionSlider.isEnabled = true
            
        } else {
            persistenceManager.updateManualOwned(objectType: SavedGames.self, gameTitle: title, manualOwned: false)
            manualConditionSlider.setValue(0, animated: true)
            manualConditionLbl.text = "-"
            manualConditionSlider.layer.opacity = 0.5
            manualConditionSlider.isEnabled = false
            
        }
        
    }
    
    
}
