//
//  ViewController.swift
//  collector
//
//  Created by Brian on 3/4/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController, PriceChartPresentationProtocol {


    @IBOutlet weak var tableView: UITableView!
    var game = GameObject()
    var network = Networking.shared
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        setAppearance()
      
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        setAppearance()

        beginAppearanceTransition(true, animated: false)

        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
 
        definesPresentationContext = true

        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        


    }

    
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)


    }
        
        
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()

        return true
    }
    

    
    func setAppearance() {
        print("setting appearance")
        
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
          
            tableView.layer.backgroundColor = lightGray.cgColor
        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)
            tableView.layer.backgroundColor = darkGray.cgColor
           
        }
    }

    func presentPriceCharting(controller: UIViewController) {
//            navigationController?.pushViewController(controller, animated: true)
        controller.modalTransitionStyle = .flipHorizontal
                self.present(controller, animated: true) {

        }
        
        
    }
    
}



extension DetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let initialCell = UITableViewCell()
        var boxartURL = baseURL.coverLarge.rawValue
        if let frontBoxArtImage = game.boxartFrontImage {
            boxartURL += frontBoxArtImage
        }
        print("indexPath Section = \(indexPath.section)")
        switch indexPath.row {

        case 0:
            print(indexPath.row)
            let cell = tableView.dequeueReusableCell(withIdentifier: "boxartCell", for: indexPath) as! BoxartCell
            
            cell.game = game
            
            return cell
            
        case 1:
            print(indexPath.section)

            let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! TitleCell
            
            cell.game = game
        
            return cell
        case 2:
            print(indexPath.section)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "valueCell", for: indexPath) as! ValueCell
            
            cell.game = game
            cell.delegate = self
            return cell
            
        case 3:
            print(indexPath.section)

            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoCell
            
            cell.game = game

            return cell
        case 4:
            print(indexPath.section)

            let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath) as! SummaryCell
            
            cell.game = game
            
            return cell
            
        
        default:
            print(indexPath.section)

            return initialCell
        
        
        }
    }
  
}
