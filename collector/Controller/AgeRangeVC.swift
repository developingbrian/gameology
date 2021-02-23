//
//  AgeRangeVC.swift
//  collector
//
//  Created by Brian on 10/27/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
import MultiSlider

class AgeRangeVC: UIViewController {
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var submitButton: UIButton!

    @IBOutlet var bottomStackView: UIStackView!
    @IBOutlet var topStackView: UIStackView!
    var persistenceManager = PersistenceManager.shared
    var id: Int?
    var dateArray : [String] = []
    var delegate : AgeRangeDelegate?
    let slider = MultiSlider()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var gameArray = persistenceManager.fetchGame(SavedGames.self, platformID: id, selectedGenres: nil)
        var releaseDate : String?
        var array : [String] = []
        for game in gameArray {
            releaseDate = game.releaseDate
            var truncatedReleaseDate: String?
            truncatedReleaseDate = releaseDate?.toLengthOf(length: 6)
            array.append(truncatedReleaseDate!)
        }
        dateArray = uniqueElementsFrom(array: array).sorted()
        print("dateArray = \(dateArray)")
        
        
        slider.minimumValue = CGFloat(Int(dateArray.first!)!)
        slider.maximumValue = CGFloat(Int(dateArray.last!)!)
        
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
    

    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)

        
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        var sliderValues = slider.value
        var dateRange : [Int] = []
        for value in sliderValues {
            var dateValue = Int(value)
            dateRange.append(dateValue)
        }
        print("dateRange = \(dateRange)")
        print("id == \(id)")
        delegate?.changeDateRange(dateRange: dateRange, platformID: id!)
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


extension String {

  func toLengthOf(length:Int) -> String {
            if length <= 0 {
                return self
            } else if let to = self.index(self.startIndex, offsetBy: length, limitedBy: self.endIndex) {
                return self.substring(from: to)

            } else {
                return ""
            }
        }
}
