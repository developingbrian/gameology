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
        
        
        
        
//
//        self.tableView.rowHeight = UITableView.automaticDimension
//        self.tableView.estimatedRowHeight = 50
        
//        self.tableView.register(TitleSearchCell.self, forCellReuseIdentifier: "titleCell")
//        self.tableView.register(PlatformSearchCell.self, forCellReuseIdentifier: "platformSearchCell")
//        self.tableView.register(GenreSearchCell.self, forCellReuseIdentifier: "genreSearchCell")
//        self.tableView.register(YearSearchCell.self, forCellReuseIdentifier: "yearSearchCell")
        
        
//        self.tableView.register(UINib(nibName: "TitleSearchCell", bundle: nil), forCellReuseIdentifier: "titleCell")
//        self.tableView.register(UINib(nibName: "PlatformSearchCell", bundle: nil), forCellReuseIdentifier: "platormSearchCell")
//        self.tableView.register(UINib(nibName: "GenreSearchCell", bundle: nil), forCellReuseIdentifier: "genreSearchCell")
//        self.tableView.register(UINib(nibName: "YearSearchCell", bundle: nil), forCellReuseIdentifier: "yearSearchCell")

        
//        if let searchVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "advancedSearch") as? AdvancedSearchVC {
//            print("title delegates should be set")
//            searchVC.titleDelegate = self
////            searchVC.containerDelegate = self
//        } else {
//            print("Can't load VC. Check name")
//        }
        
        
        self.network.fetchIGDBGenreData {
            error in
            
            if error == nil {
                print("network genres count", self.network.genres.count)
                self.network.fetchIGDBPlatformData { error in
                    
                }
            }
        }
        
        


        
        tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        func passSelf(viewController: UIViewController) {
//        }
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
//        print("title was passed to tableview controller")
//        print("title is", title)
        titleDelegate?.fetchTitle(title: title)
    }
    
    func fetchTitle(title: String){
//        print("updated title")

        titleDelegate?.fetchTitle(title: title)
        
    }
    
    func removeAllSelectedYears() {
        selectedYears.removeAll()
        
    }
    
    func updateSelectedPlatforms(platforms: [String]) {
//        print("updated selected platforms")
        selectedPlatforms = platforms
        platformDelegate?.updateSearchPlatforms(platforms: selectedPlatforms)
    }
    
    func updateSelectedGenres(genres: [String]) {
//        print("updated selected genres")
        selectedGenres = genres
        genreDelegate?.updateSearchGenres(genres: genres)
    }
    
    func updateSearchGenres(genres: [String]) {
//        print("search genre delegate works")
        //this will get genre information that can be used as datasource for collectionview
        selectedGenres = genres
        tableView.reloadData()
        self.view.layoutIfNeeded()
        genreDelegate?.updateSearchGenres(genres: genres)
   
        let index = IndexPath(row: 0, section: 2)
        if let cell = self.tableView.cellForRow(at: index) as? GenreSearchCell {
            cell.selectedGenres = selectedGenres
//            print("collection should reload")
            cell.genresCollectionView.reloadData()
            cell.genresCollectionView.layoutIfNeeded()
            
//                let height = cell.genresCollectionView.collectionViewLayout.collectionViewContentSize.height + 25
            
//            print("setting height", height)
//            cell.genreHeight.constant = height
            
//            platformCVHeight.constant = height
            
            self.tableView.reloadData()
            self.view.layoutIfNeeded()
            self.tableView.layoutIfNeeded()
    }
    }
    
    func layoutIfNeeded(index: IndexPath) {
        print("laying out if needed")
        
//        self.tableView.reloadSections([index.section], with: .automatic)
//        self.tableView.reloadRows(at: [index], with: .automatic)
        self.tableView.reloadData()
        self.view.layoutIfNeeded()
        self.tableView.layoutIfNeeded()
    }
    
    func updateSearchAges(yearRange: [Int]) {
//        print("search age delegate works")
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
//        print("search platform delegate works")
        
        //this will get platform information that can be used as datasource for collectionview
        selectedPlatforms = platforms
        tableView.reloadData()
        self.view.layoutIfNeeded()
//        print("selected platform count", selectedPlatforms.count)
        platformDelegate?.updateSearchPlatforms(platforms: platforms)
        
        let index = IndexPath(row: 0, section: 1)
        if let cell = self.tableView.cellForRow(at: index) as? PlatformSearchCell {
            cell.selectedPlatforms = selectedPlatforms
//            print("collection should reload")
            cell.platformsCollectionView.reloadData()
            cell.platformsCollectionView.layoutIfNeeded()
            
            
//            let height = cell.platformsCollectionView.collectionViewLayout.collectionViewContentSize.height + 15
            
//            print("setting height", height)
//            cell.platformHeight.constant = height
//            platformCVHeight.constant = height
            self.view.layoutIfNeeded()
            self.tableView.reloadData()
            self.tableView.layoutIfNeeded()
            
//           print("section header height", tableView.sectionHeaderHeight)
//            cell.platformsCollectionView.layoutIfNeeded()


    }
    }
//    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
//        let destination = unwindSegue.destination as! AdvancedSearchVC
//        destination.platformDelegate = self
//    }

    // MARK: - Table view data source
//        override func viewDidLayoutSubviews() {
//            super.viewDidLayoutSubviews()
//            let index = IndexPath(row: 0, section: 1)
//
//            if let cell = self.tableView.cellForRow(at: index) as? PlatformSearchCell {
//                let height = cell.platformsCollectionView.collectionViewLayout.collectionViewContentSize.height
//                print("setting height", height)
//                platformCVHeight.constant = height
//                self.view.layoutIfNeeded()
//            }
//
//        }
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        
//        print("section is", section)
//        print("Button is", view.headerBtn)
//        print("button bounds", view.headerBtn.bounds)
               
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


    
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

//        print("Delegate is working")

        if section == 1 {
            
            network.sourceTag = 3
            platformFilterVC.platformSearchDelegate = self
            platformFilterVC.selectedPlatforms = selectedPlatforms
            self.present(platformFilterVC, animated: true, completion: nil)
        }
        
        if section == 2 {
//            print("section 2")
            platformFilterVC.genreSearchDelegate = self
            platformFilterVC.selectedGenres = selectedGenres
//            let genres = network.genres
//            print("genres count", genres.count)
            var genreArray : [String] = []
            for genre in network.genres {
//                print("adding a genre, genre is", genre.name)
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
