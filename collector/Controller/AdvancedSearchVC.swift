//
//  AdvancedSearchVC.swift
//  collector
//
//  Created by Brian on 10/19/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

//protocol GenreSearchDelegate : AnyObject {
//    func updateSearchGenres(genres: [String])
//}
//
//protocol AgeSearchDelegate : AnyObject {
//
//    func updateSearchAges(yearRange: [Int])
//}
//
//protocol PlatformSearchDelegate : AnyObject {
//    func updateSearchPlatforms(platforms: [String])
//}
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
  
    func fetchTitle(title: String) {
        searchTitle = title
//        print("title was passed to parent view controller")
//        print ("Title is", title)
    }

  
    func updateSearchAges(yearRange: [Int]) {
//        print("age delegate 2 is good")
        //this will get age information from the table and have it ready for button press
        selectedYears = yearRange
//        print("selected years are")
        for year in selectedYears {
            print(year)
        }
 
    }
    
    func updateSearchPlatforms(platforms: [String]) {
//        print("platform delegate 2 is good")
         selectedPlatforms = platforms
        //this will get platform information from the table and have it ready for button press
//        print("selected platforms are")
        for platform in selectedPlatforms {
            print(platform)
        }
    }
    
    func updateSearchGenres(genres: [String]) {
//        print("genre delegate 2 is good")
        //this will get genre information from the table and have it ready for button press
        selectedGenres = genres
//        print("selected genres are")
//        for genre in selectedGenres {
//            print(genre)
//        }
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
//    var containerDelegate : ContainerDelegate?
//    var container : AdvancedSearchTableVC?
//    var testDelegate : AdvancedSearchDelegate?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "advancedSearchResults" {
//            let destination = segue.destination as! UINavigationController
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
        // Do any additional setup after loading the view.
//
        
        self.title = "Adv. Search"
        let logo = UIImage(named: "gameologylogo44")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
//        containerDelegate?.passSelf(viewController: self)
//        print("navigation controller", navigationController)
        
//        if let filterViewController = UIStoryboard(
//            name: "Main",
//            bundle: nil).instantiateViewController(withIdentifier: "FilterVC") as? FilterVC {
////
////            filterViewController.platformSearchDelegate = self
////
////            print(filterViewController.platformSearchDelegate)
////            filterViewController.genreSearchDelegate = self
//            print("delegates should be set")
//        } else {
//            print("Can't load VC. Check name")
//        }
//
//        if let ageRangeViewController = UIStoryboard(
//            name: "Main",
//            bundle: nil).instantiateViewController(withIdentifier: "AgeRange") as? AgeRangeVC {
////            print("delegates should be set")
//
////            ageRangeViewController.d
//        } else {
//            print("Can't load VC. Check name")
//        }
        
        
        
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGestureReconizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGestureReconizer)
        
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//
//              // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
//        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        
        
        
        
        
    }
    
    
    
    
    @objc func tap() {
        view.endEditing(true)
    }
    
//    @objc func adjustForKeyboard(notification: Notification) {
//        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
//
//        let keyboardScreenEndFrame = keyboardValue.cgRectValue
//        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
//
//        if notification.name == UIResponder.keyboardWillHideNotification {
//            tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
//        } else {
//
//            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
//        }
//
//        tableView.scrollIndicatorInsets = tableView.contentInset
//
//
//    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
//            print("keyboardWillShow()")
//        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//           // if keyboard size is not available for some reason, dont do anything
//           return
//        }
      
      // move the root view up by the distance of keyboard height
//      self.view.frame.origin.y = 0 - keyboardSize.height
//        tableView.contentSize = CGSize(width: tableView.frame.width, height: tableView.frame.height)
//        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
//         tableView.contentInset = contentInsets
//         tableView.scrollIndicatorInsets = contentInsets
//        print("content moved")
    }

    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
//      self.view.frame.origin.y = 0
//        print("keyboardWillHide()")
        
//        tableView.contentSize = CGSize(width: tableView.frame.width, height: tableView.frame.height)
//
//        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            
        
//        // reset back the content inset to zero after keyboard is gone
//        tableView.contentInset = contentInsets
//        tableView.scrollIndicatorInsets = contentInsets

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
        searchBtn.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)

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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destination = segue.destination as! FilterVC
//        destination.platformSearchDelegate = self
//        
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showNoSearchOptionsAlert() {
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        let alertController = UIAlertController(title: "No Search Option Selected", message: "You must search by at least one option.", preferredStyle: .alert)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    

    @IBAction func searchBtnPressed(_ sender: Any) {
//        print("search button pressed")
        
        if (searchTitle == "" && selectedPlatforms.isEmpty && selectedYears.isEmpty && selectedGenres.isEmpty) {
            showNoSearchOptionsAlert()
        } else {
        
        self.performSegue(withIdentifier: "advancedSearchResults", sender: self)
        }

        
        
        }
        
        
        
        
        
    

    

}

    
    
    
    

