//
//  AdvancedSearchVC.swift
//  collector
//
//  Created by Brian on 10/19/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit


protocol PassGenreDelegate {
    func updateSearchGenres(genres: [String])
}

protocol PassAgeDelegate {
    func updateSearchAges(yearRange: [Int])
}

protocol PassPlatformDelegate {
    func updateSearchPlatforms(platforms: [String])
}

protocol PassTitleDelegate {
    func fetchTitle(title: String)
    
}

class AdvancedSearchVC: UIViewController, PassAgeDelegate, PassPlatformDelegate, PassGenreDelegate, PassTitleDelegate {
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        
    }
    
    func fetchTitle(title: String) {
        searchTitle = title
        
    }
    
    
    func updateSearchAges(yearRange: [Int]) {
        
        //this will get age information from the table and have it ready for button press
        selectedYears = yearRange
        
    }
    
    func updateSearchPlatforms(platforms: [String]) {
        
        selectedPlatforms = platforms
        //this will get platform information from the table and have it ready for button press

    }
    
    
    func updateSearchGenres(genres: [String]) {
        
        //this will get genre information from the table and have it ready for button press
        selectedGenres = genres
        
    }
    
    @IBOutlet weak var searchBtn: UIButton!
    var searchTitle = ""
    var selectedPlatforms : [String] = []
    var selectedGenres : [String] = []
    var selectedYears : [Int] = []
    var startYear = 0
    var endYear = 0
    var gameArray : [GameObject] = []
    var gradientLayer = CAGradientLayer()
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "advancedSearchResults" {
            
            let vc = segue.destination as! AdvancedSearchResultsVC
            vc.name = searchTitle
            vc.genres = selectedGenres
            vc.platforms = selectedPlatforms
            vc.years = selectedYears
            
        } else
        
        if segue.identifier == "containerViewSegue" {
            let destination = segue.destination as! AdvancedSearchTableVC
            destination.platformDelegate = self
            destination.genreDelegate = self
            destination.ageDelegate = self
            destination.titleDelegate = self
            let indexPath = IndexPath(row: 0, section: 3)
            if let cell = destination.tableView.cellForRow(at: indexPath) as? YearSearchCell {
                cell.removeYearsDelegate = self
            }
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton()
        
        self.title = "Adv. Search"
        let logo = UIImage(named: "gameologylogo44")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGestureReconizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureReconizer)
        
        
    }
    
    
    
    
    @objc func tap() {
        view.endEditing(true)
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        setAppearance()
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
            
            view.backgroundColor = lightGray
            navigationController?.view.backgroundColor = .white
            
            
            
        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
            
            view.backgroundColor = darkGray
            navigationController?.view.backgroundColor = .black
            
            
        }
        
        
        
        
    }
    
    
    func setupButton() {
        let color2 = UIColorFromRGB(0x2ECAD5)
        let color1 = UIColorFromRGB(0x2B95CE)
        self.searchBtn.layoutIfNeeded()
        searchBtn.layer.cornerRadius = 6
        searchBtn.backgroundColor = .red

        gradientLayer.colors = [color2.cgColor
                                ,color1.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.frame = searchBtn.bounds
        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false
        gradientLayer.cornerRadius = 6
        searchBtn.layer.insertSublayer(gradientLayer, at: 0)
        if let imageView = searchBtn.imageView {
            searchBtn.bringSubviewToFront(imageView)
        }
    }
    
    
    func showNoSearchOptionsAlert() {
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let alertController = UIAlertController(title: "No Search Option Selected", message: "You must search by at least one option.", preferredStyle: .alert)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func searchBtnPressed(_ sender: Any) {
        
        if (searchTitle == "" && selectedPlatforms.isEmpty && selectedYears.isEmpty && selectedGenres.isEmpty) {
            showNoSearchOptionsAlert()
        } else {
            
            self.performSegue(withIdentifier: "advancedSearchResults", sender: self)
        }
        
        
        
    }
    
    
}




    

