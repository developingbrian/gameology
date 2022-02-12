//
//  ViewController.swift
//  collector
//
//  Created by Brian on 3/4/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
import SDWebImage


class DetailViewController: UIViewController, PriceChartPresentationProtocol {
    
    
    @IBOutlet weak var tableView: UITableView!
    var gameTitle : String?
    var game = GameObject() {
        didSet {
            gameTitle = game.title
            gameTitle = gameTitle?.replacingOccurrences(of: "Expansion Pass", with: "")
            gameTitle = gameTitle?.replacingOccurrences(of: "Special Edition", with: "")
            gameTitle = gameTitle?.replacingOccurrences(of: "Game of the Year Edition", with: "")
            gameTitle = gameTitle?.replacingOccurrences(of: "Game Of The Year Edition", with: "")
            gameTitle = gameTitle?.replacingOccurrences(of: "Premium Online Edition", with: "")
            gameTitle = gameTitle?.replacingOccurrences(of: "Gold Edition", with: "")
            gameTitle = gameTitle?.replacingOccurrences(of: "Complete Edition", with: "")
            gameTitle = gameTitle?.replacingOccurrences(of: "Deluxe Edition", with: "")
            gameTitle = gameTitle?.replacingOccurrences(of: "Directors Cut", with: "")
            
            
            
            gameTitle = (gameTitle?.removingPercentEncoding)!
            gameTitle = gameTitle?.replacingOccurrences(of: "'", with: "")
            gameTitle = gameTitle?.replacingOccurrences(of: ":", with: "")
            gameTitle = gameTitle?.replacingOccurrences(of: " & ", with: "+")
            gameTitle = gameTitle?.replacingOccurrences(of: ".", with: "")
            gameTitle = gameTitle?.replacingOccurrences(of: "!", with: "")
            gameTitle = gameTitle?.replacingOccurrences(of: "?", with: "")
            gameTitle = gameTitle?.replacingOccurrences(of: "/", with: "")
            gameTitle = gameTitle?.replacingOccurrences(of: "-", with: "+")
            gameTitle = gameTitle?.replacingOccurrences(of: "³", with: "+3")
            gameTitle = gameTitle?.replacingOccurrences(of: " ", with: "+")
            
            
        }
    }
    var network = Networking.shared
    var priceInfo : PriceInfo?
    
    
    deinit {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        clearImageCacheFromMemory()
    }
    
    override func didReceiveMemoryWarning() {
        clearImageCacheFromMemory()
    }
    
    func clearImageCacheFromMemory() {
        let imageCache = SDImageCache.shared
        imageCache.clearMemory()
    }
    
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
        
        DispatchQueue.global().async {
            
            guard let gameName = self.gameTitle else { return }
            
            self.network.scrapePriceCharting(platformID: self.game.platformID!, gameName: gameName, uneditedGameName: self.game.title!) { priceObject in
                
                self.priceInfo = priceObject
                
                let indexPath = IndexPath(row: 3, section: 0)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
                
            }
        }
        
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
        
        switch indexPath.row {
            
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "boxartCell", for: indexPath) as! BoxartCell
            
            cell.game = game
            
            return cell
            
        case 1:
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! TitleCell
            
            cell.game = game
            
            return cell
        case 2:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoCell
            
            cell.game = game
            
            return cell
            
            
        case 3:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "valueCell", for: indexPath) as! ValueCell
            
            cell.game = game
            if let priceInfo = priceInfo {
                cell.priceInfo = priceInfo
            }
            cell.delegate = self
            
            if cell.valueTitle.text != "" {
                if cell.valueTitle.text != "N/A" {
                    cell.valueTitle.isHidden = false
                    cell.newPrice.isHidden = false
                    cell.loosePrice.isHidden = false
                    cell.cibPrice.isHidden = false
                    cell.visitPCLabel.isHidden = false
                    cell.priceChartingButton.isHidden = false
                    cell.valueActivityIndicator.isHidden = true
                    cell.cibActivityIndicator.isHidden = true
                    cell.looseActivityIndicator.isHidden = true
                    cell.newActivityIndicator.isHidden = true
                } else {
                    cell.valueTitle.isHidden = false
                    cell.newPrice.isHidden = false
                    cell.loosePrice.isHidden = false
                    cell.cibPrice.isHidden = false
                    cell.visitPCLabel.isHidden = true
                    cell.priceChartingButton.isHidden = true
                    cell.valueActivityIndicator.isHidden = true
                    cell.cibActivityIndicator.isHidden = true
                    cell.looseActivityIndicator.isHidden = true
                    cell.newActivityIndicator.isHidden = true
                    
                }            }
            
            
            return cell
        case 4:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath) as! SummaryCell
            
            cell.game = game
            
            return cell
            
            
        default:
            
            return initialCell
            
            
        }
    }
    
}
