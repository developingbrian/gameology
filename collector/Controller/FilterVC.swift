//
//  FilterVC.swift
//  collector
//
//  Created by Brian on 10/23/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
 

class FilterVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    

    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterByLbl: UILabel!
    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    let persistenceManager = PersistenceManager.shared
    var genreArray : [String] = []
    var selectedItems : [String] = []
    var delegate: ModalDelegate?
    var id : Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.allowsMultipleSelection = true
        self.tableView.allowsMultipleSelectionDuringEditing = true
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        selectedItems.removeAll()
        
       
        
        if self.traitCollection.userInterfaceStyle == .light {
            filterByLbl.backgroundColor = UIColor(red: (246/255), green: (246/255), blue: (246/255), alpha: 1)
            topLbl.backgroundColor = UIColor(red: (246/255), green: (246/255), blue: (246/255), alpha: 1)
            tableView.backgroundColor = UIColor(red: (246/255), green: (246/255), blue: (246/255), alpha: 1)
            backgroundView.layer.shadowColor = UIColor.black.cgColor
            backgroundView.layer.shadowOpacity = 0.50
            backgroundView.layer.shadowOffset = .zero
            backgroundView.layer.shadowRadius = 15
            cancelButton.backgroundColor = UIColor(red: (246/255), green: (246/255), blue: (246/255), alpha: 1)
            cancelButton.setTitleColor(UIColor.black, for: .normal)
            submitButton.backgroundColor = UIColor(red: (246/255), green: (246/255), blue: (246/255), alpha: 1)
            submitButton.setTitleColor(UIColor.black, for: .normal)
            
            cancelButton.layer.shadowColor = UIColor.gray.cgColor
            cancelButton.layer.shadowOpacity = 0.75
            cancelButton.layer.shadowOffset = .zero
            cancelButton.layer.shadowRadius = 5
            submitButton.layer.shadowColor = UIColor.gray.cgColor
            submitButton.layer.shadowOpacity = 0.75
            submitButton.layer.shadowOffset = .zero
            submitButton.layer.shadowRadius = 5
            
            filterByLbl.layer.masksToBounds = false
            filterByLbl.layer.shadowRadius = 4
            filterByLbl.layer.shadowOpacity = 0.25
            filterByLbl.layer.shadowColor = UIColor.gray.cgColor
            filterByLbl.layer.shadowOffset = CGSize(width: 0 , height:10)
            
        } else {

            tableView.backgroundColor = UIColor(red: (15/255), green: (15/255), blue: (15/255), alpha: 1)
            filterByLbl.backgroundColor = UIColor(red: (15/255), green: (15/255), blue: (15/255), alpha: 1)
            topLbl.backgroundColor = UIColor(red: (15/255), green: (15/255), blue: (15/255), alpha: 1)
            backgroundView.layer.shadowColor = UIColor.white.cgColor
            backgroundView.layer.shadowOpacity = 0.50
            backgroundView.layer.shadowOffset = .zero
            backgroundView.layer.shadowRadius = 15
            cancelButton.backgroundColor = UIColor(red: (15/255), green: (15/255), blue: (15/255), alpha: 1)
            submitButton.backgroundColor = UIColor(red: (15/255), green: (15/255), blue: (15/255), alpha: 1)
            cancelButton.setTitleColor(UIColor.white, for: .normal)
            submitButton.setTitleColor(UIColor.white, for: .normal)
            
            cancelButton.layer.shadowColor = UIColor.white.cgColor
            cancelButton.layer.shadowOpacity = 0.50
            cancelButton.layer.shadowOffset = .zero
            cancelButton.layer.shadowRadius = 15
            submitButton.layer.shadowColor = UIColor.white.cgColor
            submitButton.layer.shadowOpacity = 0.50
            submitButton.layer.shadowOffset = .zero
            submitButton.layer.shadowRadius = 15

        
        }
            print("FilterVC id = \(id)")
            let gameArray = persistenceManager.fetchGame(SavedGames.self, platformID: id, selectedGenres: nil)
         
        var array: [String] = []
        for game in gameArray {
            print(game)
            array.append(contentsOf: game.genres!)
        }
        
        genreArray = uniqueElementsFrom(array: array)
        
        print("genreArray = \(genreArray)")
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if genreArray != nil {
            return genreArray.count }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as? FilterVCTableViewCell else { fatalError("Cannot connect to cell") }
        cell.filterChoiceLbl.text = genreArray[indexPath.row]
        if self.traitCollection.userInterfaceStyle == .light {
            cell.filterChoiceLbl.textColor = UIColor.black
            
        } else {
            cell.filterChoiceLbl.textColor = UIColor.white
            
            
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FilterVCTableViewCell
        if cell.isSelected {
            selectedItems.append(cell.filterChoiceLbl.text!)
            print(selectedItems)
        } 
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FilterVCTableViewCell
        if cell.isSelected == false {
            selectedItems.removeAll { $0 == "\(cell.filterChoiceLbl.text!)" }
            print(selectedItems)
        }
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? OwnedGamesViewController {
//            destination.filterSelections = selectedItems
//        }
//    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func submitButtonPressed(_ sender: Any) {
        
//        if let presenter = presentingViewController as? OwnedGamesViewController {
//
//            presenter.filterSelections.append(contentsOf: selectedItems)
//            print("presenter \(presenter.filterSelections)")
//        } else {
//            print("presenter invalid")
//            print("presetningVC \(presentingViewController)")
//        }
        
//        if let delegate = self.delegate {
//            delegate.changeValue(value: selectedItems)
//        }
        
        delegate?.changeValue(value: selectedItems, platformID: id)
//
        self.presentingViewController?.dismiss(animated: true, completion: nil)
//        self.navigationController?.popViewController(animated: true)
        print("submit button pressed")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: view)
            print(position)
        }
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
    
  
    
}
