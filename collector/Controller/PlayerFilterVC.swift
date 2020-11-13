//
//  PlayerFilterVC.swift
//  collector
//
//  Created by Brian on 10/29/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
import MultiSlider

class PlayerFilterVC: UIViewController {
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var submitButton: UIButton!

    @IBOutlet var bottomStackView: UIStackView!
    @IBOutlet var topStackView: UIStackView!
    var persistenceManager = PersistenceManager.shared
    var id: Int?
    var maxPlayerArray : [Int] = []
    var delegate : MaxPlayerDelegate?
    let slider = MultiSlider()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var gameArray = persistenceManager.fetchGame(SavedGames.self, platformID: id, selectedGenres: nil)
        var maxPlayers : Int?
        var array : [Int] = []
        for game in gameArray {
            maxPlayers = Int(game.maxPlayers)
            array.append(maxPlayers!)
        }
        maxPlayerArray = uniqueElementsFrom(array: array).sorted()
        print("maxPlayerArray = \(maxPlayerArray)")
        
        
        slider.minimumValue = CGFloat(maxPlayerArray.first!)
        slider.maximumValue = CGFloat(maxPlayerArray.last!)
        
        slider.value = [slider.minimumValue, slider.maximumValue]
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged) // continuous changes
        slider.thumbCount = 2
        slider.trackWidth = 1
        slider.valueLabelPosition = .topMargin
        slider.hasRoundTrackEnds = true
        slider.orientation = .horizontal
        slider.valueLabelFormatter.roundingMode = .down
        slider.valueLabelFormatter.roundingIncrement = 1
        slider.valueLabelFormatter.alwaysShowsDecimalSeparator = false
        sliderView.addConstrainedSubview(slider, constrain: .leftMargin, .rightMargin, .bottomMargin)
//        sliderView.addSubview(slider)
        sliderView.layoutMargins = UIEdgeInsets(top: 1, left: 10, bottom: 1, right: 10)
//        slider.addTarget(self, action: #selector(sliderDragEnded(_:)), for: . touchUpInside) // sent when drag ends
        // Do any additional setup after loading the view.
        
        if self.traitCollection.userInterfaceStyle == .light {
            backgroundView.layer.shadowColor = UIColor.black.cgColor
            backgroundView.layer.shadowOpacity = 0.50
            backgroundView.layer.shadowOffset = .zero
            backgroundView.layer.shadowRadius = 15
            topStackView.layer.cornerRadius = 10
            backgroundView.layer.cornerRadius = 10
            cancelButton.layer.cornerRadius = 5
            submitButton.layer.cornerRadius = 5
            bottomStackView.layer.cornerRadius = 10
            slider.outerTrackColor = .lightGray
            slider.showsThumbImageShadow = true
            slider.tintColor = .black
            
        } else {
            backgroundView.layer.shadowColor = UIColor.white.cgColor
            backgroundView.layer.shadowOpacity = 0.50
            backgroundView.layer.shadowOffset = .zero
            backgroundView.layer.shadowRadius = 15
            topStackView.layer.cornerRadius = 10
            backgroundView.layer.cornerRadius = 10
            cancelButton.layer.cornerRadius = 10
            submitButton.layer.cornerRadius = 10
            bottomStackView.layer.cornerRadius = 10
        }

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        

        
        
        
    }
    
    
    @objc func sliderChanged(slider: MultiSlider) {
        print("thumb \(slider.draggedThumbIndex) moved")
        print("now thumbs are at \(slider.value)") // e.g., [1.0, 4.5, 5.0]
        var sliderValues = slider.value
        var newArray : [Int] = []
        for value in sliderValues {
            var newValue = Int(value)
            newArray.append(newValue)
            
        }
        print("Thumbs are at years \(newArray.first!) and \(newArray.last!)")
    }

    
    func uniqueElementsFrom(array: [Int]) -> [Int] {
        //Create an empty Set to track unique items
        var set = Set<Int>()
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
    

    
    @IBAction func cancelButtonPressed(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
        self.presentingViewController?.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        var sliderValues = slider.value
        var playerRange : [Int] = []
        for value in sliderValues {
            var playerValue = Int(value)
            playerRange.append(playerValue)
        }
        print("playerRange = \(playerRange)")
        print("id == \(id)")
        delegate?.changeMaxPlayerRange(playerRange: playerRange, platformID: id!)
        print("submit button pressed")
        self.presentingViewController?.dismiss(animated: true, completion: nil)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


