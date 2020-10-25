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
    let persistenceManager = PersistenceManager.shared
    var genreArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let ownedGames = persistenceManager.fetchAscending(SavedGames.self)
        var array: [String] = []
        for game in ownedGames {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as? FilterVCTableViewCell
        cell?.filterChoiceLbl.text = genreArray[indexPath.row]
        return cell!
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
    }
    @IBAction func submitButtonPressed(_ sender: Any) {
        print("submit button pressed")
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
