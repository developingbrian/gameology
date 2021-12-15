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
    @IBOutlet weak var backgroundStackView: UIStackView!
    
    @IBOutlet var bottomStackView: UIStackView!
    @IBOutlet var topStackView: UIStackView!
    var persistenceManager = PersistenceManager.shared
    var id: Int?
    var dateArray : [String] = []
    var delegate : AgeRangeDelegate?
    var ageSearchDelegate : AgeSearchDelegate?
    let slider = MultiSlider()
    let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
    var selectedDates : [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

       configureMultiSlider()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setAppearance()
        
        
    }
    
    func setAppearance() {
        let lightBlue =  UIColorFromRGB(0x2B95CE)

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
//            let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
//            topStackView.backgroundColor = lightGray
//            cancelButton.backgroundColor = lightGray
//            submitButton.backgroundColor = lightGray
            //            topLbl.backgroundColor = lightGray
//            filterByLbl.backgroundColor = lightGray
            

        } else if traitCollection.userInterfaceStyle == .dark {
//            let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
//            topStackView.backgroundColor = darkGray
//            cancelButton.backgroundColor = darkGray
//            submitButton.backgroundColor = darkGray
//            topLbl.backgroundColor = darkGray
//            filterByLbl.backgroundColor = darkGray
        }
        

        backgroundStackView.layer.cornerRadius = 10
    
        topStackView.layer.cornerRadius = 10
        topStackView.clipsToBounds = true
        topStackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cancelButton.clipsToBounds = true
        cancelButton.layer.cornerRadius = 5
        cancelButton.layer.maskedCorners = [ .layerMinXMaxYCorner]

        submitButton.layer.cornerRadius = 5
        submitButton.clipsToBounds = true
        submitButton.layer.maskedCorners = [.layerMaxXMaxYCorner]

        bottomStackView.clipsToBounds = true
        bottomStackView.layer.cornerRadius = 10
        bottomStackView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        slider.outerTrackColor = .lightGray
        slider.tintColor = lightBlue

        

        
        
        
    }
    
    func configureMultiSlider() {
 
        
        let gameArray = persistenceManager.fetchGame(SavedGames.self, byGameTitle: nil, platformID: id, selectedGenres: nil, selectedPlatforms: nil, selectedDateRange: nil)
//        let leftThumb = UIImage(named: "Switch_Left_Stick65")
//        let rightThumb = UIImage(named: "Switch_Right_Stick65")
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
        
            if network.sourceTag == 4 {
                let currentYear = Calendar.current.component(.year, from: Date())
                slider.minimumValue = CGFloat(1972)
                slider.maximumValue = CGFloat(currentYear)            } else {
        slider.minimumValue = CGFloat(Int(dateArray.first!)!)
        slider.maximumValue = CGFloat(Int(dateArray.last!)!)
            }
        
        if selectedDates.count >= 2 {
            let firstDate = CGFloat(selectedDates.first!)
            let lastDate = CGFloat(selectedDates.last!)
        slider.value = [firstDate, lastDate]
        }
        else {
            slider.value = [slider.minimumValue, slider.maximumValue]
        }
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged) // continuous changes
        slider.thumbCount = 2
        
        slider.trackWidth = 1
        

//        print(" left right thumb", leftThumb, rightThumb)
//        print("thumbs", slider.thumbViews[0].image, slider.thumbViews[1].image)
        slider.valueLabelPosition = .top
        slider.hasRoundTrackEnds = true
        slider.orientation = .horizontal
        slider.valueLabelFormatter.roundingMode = .down
        slider.valueLabelFormatter.roundingIncrement = 1
        slider.valueLabelFormatter.alwaysShowsDecimalSeparator = false
        slider.showsThumbImageShadow = false
        slider.layer.frame = sliderView.bounds
        
        sliderView.addConstrainedSubview(slider, constrain: .leftMargin, .rightMargin, .bottomMargin, .topMargin)
        sliderView.layoutMargins = UIEdgeInsets(top: 1, left: 20, bottom: 1, right: 20)

        
        slider.thumbViews[0].image = UIImage(named: "Switch_Left_Stick")
        slider.thumbViews[1].image = UIImage(named: "Switch_Right_Stick")
                slider.showsThumbImageShadow = true

        
    }
    
    @objc func sliderChanged(slider: MultiSlider) {
        print("thumb \(slider.draggedThumbIndex) moved")
        print("now thumbs are at \(slider.value)") // e.g., [1.0, 4.5, 5.0]
        let sliderValues = slider.value
        var newArray : [Int] = []
        for value in sliderValues {
            let newValue = Int(value)
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
        let sliderValues = slider.value
        var dateRange : [Int] = []
        for value in sliderValues {
            let dateValue = Int(value)
            dateRange.append(dateValue)
        }
        print("dateRange = \(dateRange)")
//        print("id == \(id)")
        //if sourceTag == 4? then do this, this works with the owned games controller
        if network.sourceTag == 4 {
            
            ageSearchDelegate?.updateSearchAges(yearRange: dateRange)
            
        }
        
        if network.sourceTag == 5 {
            
            delegate?.changeDateRange(dateRange: dateRange, platformID: id!)

        }
        //otherwise we need to implement delegate to pass to advanced search
        
        
        
        
        print("submit button pressed")
        self.presentingViewController?.dismiss(animated: true, completion: nil)

    }
 

}


extension String {

  func toLengthOf(length:Int) -> String {
            if length <= 0 {
                return self
            } else if let to = self.index(self.startIndex, offsetBy: length, limitedBy: self.endIndex) {
                return String(self[to...])


            } else {
                return ""
            }
        }
}
