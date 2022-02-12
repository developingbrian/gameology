//
//  AdvancedSearchTableVC.swift
//  collector
//
//  Created by Brian on 10/21/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

protocol AdvancedSearchDelegate  {
    func headerButtonPressed(section: Int)
}

protocol GenreSearchDelegate {
    func updateSearchGenres(genres: [String])
}

protocol AgeSearchDelegate {
    func updateSearchAges(yearRange: [Int])
}

protocol YearRemovalDelegate {
    func removeAllSelectedYears()
}

protocol PlatformSearchDelegate {
    func updateSearchPlatforms(platforms: [String])
}

protocol PlatformPassDelegate {
    func updateSelectedPlatforms(platforms: [String])
}

protocol GenrePassDelegate {
    func updateSelectedGenres(genres: [String])
    
}

protocol TitlePassDelegate {
    func updateTitle(title: String)
}

protocol LayoutUpdateDelegate {
    func layoutIfNeeded(index: IndexPath)
    
}


class AdvancedSearchTableVC: UITableViewController, GenreSearchDelegate, AgeSearchDelegate, PlatformSearchDelegate, PlatformPassDelegate, GenrePassDelegate, YearRemovalDelegate, TitlePassDelegate, LayoutUpdateDelegate {
    
    
    let network = Networking.shared
    var advancedSearchVC : UIViewController?
    var platformDelegate : PassPlatformDelegate?
    var genreDelegate : PassGenreDelegate?
    var ageDelegate : PassAgeDelegate?
    var titleDelegate : PassTitleDelegate?
    var selectedGenres : [String] = []
    var selectedPlatforms : [String] = []
    var selectedYears : [Int] = []
    let lightGray = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
    @IBOutlet weak var platformCell: PlatformSearchCell!
    @IBOutlet weak var titleCell: TitleSearchCell!
    @IBOutlet weak var yearCell: YearSearchCell!
    @IBOutlet weak var genreCell: GenreSearchCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(
            AdvancedSearchHeaderView.self,
            forHeaderFooterViewReuseIdentifier:
                AdvancedSearchHeaderView.reuseIdentifier
        )
        
        self.network.fetchIGDBGenreData {
            error in
            
            if error == nil {
                
                self.network.fetchIGDBPlatformData { error in
                    
                }
            }
        }
        
        tableView.reloadData()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setAppearance()
        
        tableView.reloadData()
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
            
            tableView.backgroundColor = lightGray
            view.backgroundColor = lightGray
            
            
        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
            tableView.backgroundColor = darkGray
            view.backgroundColor = darkGray
            
        }
        
        
    }
    
    
    
    func updateTitle(title: String) {
        
        titleDelegate?.fetchTitle(title: title)
    }
    
    func fetchTitle(title: String){
        
        titleDelegate?.fetchTitle(title: title)
        
    }
    
    func removeAllSelectedYears() {
        selectedYears.removeAll()
        
    }
    
    func updateSelectedPlatforms(platforms: [String]) {
        
        selectedPlatforms = platforms
        platformDelegate?.updateSearchPlatforms(platforms: selectedPlatforms)
    }
    
    func updateSelectedGenres(genres: [String]) {
        
        selectedGenres = genres
        genreDelegate?.updateSearchGenres(genres: genres)
    }
    
    func updateSearchGenres(genres: [String]) {
        
        //this will get genre information that can be used as datasource for collectionview
        selectedGenres = genres
        tableView.reloadData()
        self.view.layoutIfNeeded()
        genreDelegate?.updateSearchGenres(genres: genres)
        
        let index = IndexPath(row: 0, section: 2)
        if let cell = self.tableView.cellForRow(at: index) as? GenreSearchCell {
            cell.selectedGenres = selectedGenres
            
            cell.genresCollectionView.reloadData()
            cell.genresCollectionView.layoutIfNeeded()
            
            self.tableView.reloadData()
            self.view.layoutIfNeeded()
            self.tableView.layoutIfNeeded()
        }
    }
    
    func layoutIfNeeded(index: IndexPath) {
        
        self.tableView.reloadData()
        self.view.layoutIfNeeded()
        self.tableView.layoutIfNeeded()
    }
    
    func updateSearchAges(yearRange: [Int]) {
        
        //this will get age information that can be used as datasource for label
        selectedYears = yearRange
        
        ageDelegate?.updateSearchAges(yearRange: yearRange)
        if yearRange.count >= 2 {
            let earliestYear = String(yearRange.first!)
            let latestYear = String(yearRange.last!)
            yearCell.yearsBtn.setTitle(earliestYear + " - " + latestYear, for: .normal)
            yearCell.yearsBtn.isHidden = false
        }
        
        
    }
    
    func updateSearchPlatforms(platforms: [String]) {
        
        //this will get platform information that can be used as datasource for collectionview
        selectedPlatforms = platforms
        tableView.reloadData()
        self.view.layoutIfNeeded()
        
        platformDelegate?.updateSearchPlatforms(platforms: platforms)
        
        let index = IndexPath(row: 0, section: 1)
        if let cell = self.tableView.cellForRow(at: index) as? PlatformSearchCell {
            cell.selectedPlatforms = selectedPlatforms
            
            cell.platformsCollectionView.reloadData()
            cell.platformsCollectionView.layoutIfNeeded()
            
            self.view.layoutIfNeeded()
            self.tableView.reloadData()
            self.tableView.layoutIfNeeded()
            
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: AdvancedSearchHeaderView.reuseIdentifier)
                as? AdvancedSearchHeaderView
        else {
            return nil
        }
        view.searchDelegate = self
        
        view.sectionIndex = section
        
        switch section {
            
        case 0 :
            view.headerBtn.isHidden = true
        case 1 :
            view.headerBtn.isHidden = false
        case 2 :
            view.headerBtn.isHidden = false
        case 3 :
            view.headerBtn.isHidden = false
        default:
            print("invalid section")
        }
        
        return view
        
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.section {
            
        case 0 :
            titleCell.delegate = self
            titleCell.titleField.delegate = self
            return titleCell
        case 1 :
            platformCell.selectedPlatformsDelegate = self
            platformCell.layoutDelegate = self
            return platformCell
        case 2 :
            genreCell.selectedGenresDelegate = self
            genreCell.layoutDelegate = self
            genreCell.selectedGenres = selectedGenres
            return genreCell
        case 3 :
            yearCell.yearDelegate = self
            return yearCell
            
        default :
            
            
            return titleCell
            
        }
    }
    
    
}



extension AdvancedSearchTableVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
    
}


extension AdvancedSearchTableVC : AdvancedSearchDelegate {
    
    func headerButtonPressed(section: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let platformFilterVC = storyboard.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        let ageRangeVC = storyboard.instantiateViewController(withIdentifier: "AgeRange") as! AgeRangeVC
        
        if section == 1 {
            
            network.sourceTag = 3
            platformFilterVC.platformSearchDelegate = self
            platformFilterVC.selectedPlatforms = selectedPlatforms
            self.present(platformFilterVC, animated: true, completion: nil)
        }
        
        if section == 2 {
            
            platformFilterVC.genreSearchDelegate = self
            platformFilterVC.selectedGenres = selectedGenres
            var genreArray : [String] = []
            for genre in network.genres {
                
                genreArray.append(genre.name!)
                
            }
            
            platformFilterVC.genres = genreArray
            network.sourceTag = 2
            self.present(platformFilterVC, animated: true, completion: nil)
        }
        
        if section == 3 {
            network.sourceTag = 4
            ageRangeVC.selectedDates = selectedYears
            ageRangeVC.ageSearchDelegate = self
            self.present(ageRangeVC, animated: true, completion: nil)
        }
        
    }
    
}
