//
//  ViewController.swift
//  collector
//
//  Created by Brian on 3/10/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var platformPicker: UIPickerView!
    @IBOutlet weak var tableviewPlatformImage: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var clearButton: UIButton!
    
    var games = [Game]()
    var game : Game?
    var companies = [Companies]()
    var platforms = [Platform]()
    var platform : Platform?
    var company : Companies?
    var pickerData : [String] = [String]()
    var picked : Int = 18
    var gdbPlatformID : Int = 7
    var imageName = ""
    var gameNamed : String?
    var searchString : String?
    var currentOffset : Int = 0
    var currentPlatform : String?
    var currentGame : String?
    var initialOffset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.platformPicker.delegate = self
        self.platformPicker.dataSource = self
        
        games.removeAll()
        
        pickerData = ["NES", "SNES", "Nintendo 64", "Gamecube", "Game Boy", "Gameboy Advance", "Sega Genesis", "Sega CD"]
        
        
        
        //        if searchTextField.text == nil {
        //            clearButton.titleLabel?.text = nil
        //            searchString =  nil
        //        } else {
        //            clearButton.titleLabel?.text = "clear"
        //            searchString = "search \"\(gameName)\";"
        //        }
        //
        print("out")
        
        downloadJSON(platformSelected: "18", gameName: nil, offset: nil) {
            
            print("in")
            
            print("platform image id is ** \(self.games[0].platforms?[0].versions?[0].platformLogo?.imageID)")
            
            //            if self.games[0].platforms?[0].platformLogo?.imageID != nil {
            //                    let logoID = (self.games[0].platforms?[0].versions?[0].platformLogo?.imageID)!
            //
            //                    self.setLogoImage(from: "https://images.igdb.com/igdb/image/upload/t_logo_med/\(logoID).png")
            //
            //                  }
            
            self.setPlatformIcon()
            
            self.tableviewPlatformImage.image = UIImage(named: "\(self.imageName)")
            
            self.tableView.reloadData()
        }
        
        
        //        downloadJSONPostman(platformSelected: 18) {
        //            self.tableView.reloadData()
        //        }
        
        //        downloadCompaniesJSON {
        //            print("Success Companies JSON")
        //        }
        //////
        //        downloadPlatformsJSON {
        //            print("Success Platforms JSON")
        //        }
        //
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        //creating game object
        let game1 : Game
        game1 = games[indexPath.row]
        
        //update the Game Name fields text to be capitialized
        cell.tableViewGameName.text = game1.name?.capitalized
        
        //check if on last cell
        if indexPath.row == games.count - 1 {
            //this will run if we are on the last cell in the tableview
            currentOffset += 100
            downloadJSON(platformSelected: currentPlatform, gameName: currentGame, offset: "\(currentOffset)") {
                print("pagination json request")
            }
            
        }
        
        if game1.firstReleaseDate != nil {
            let date = Date(timeIntervalSince1970: game1.firstReleaseDate!)
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "MST") //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "MM-dd-yyyy" //Specify your format that you want
            let strDate = dateFormatter.string(from: date)
            if strDate != nil {
                cell.tableViewReleaseDateLabel.text =  strDate
            } else {
                cell.tableViewReleaseDateLabel.text = " "
            }
        }
        
        if game1.involvedCompanies?[0].company?.name != nil {
            cell.tableViewCompanyLabel.text = game1.involvedCompanies?[0].company?.name
        } else {
            cell.tableViewCompanyLabel.text = " "
        }
        
        
//        if game1.genres != nil {
            cell.tableViewGenreLabel.text = game1.genres.compactMap { $0.name }.joined(separator: " / ")

//        } else {
//            cell.tableViewAgeRatingLabel.text = " "
//        }
        
        switch game1.ageRating?[0].rating {
            
        case 6:
            cell.tableViewAgeRatingLabel.text = "RP - Rating Pending"
        case 7:
            cell.tableViewAgeRatingLabel.text = "EC - Early Childhood"
        case 8:
            cell.tableViewAgeRatingLabel.text = "E - Everyone"
        case 9:
            cell.tableViewAgeRatingLabel.text = "E 10+ - Everyone Ten Plus"
        case 10:
            cell.tableViewAgeRatingLabel.text = "T - Teen"
        case 11:
            cell.tableViewAgeRatingLabel.text = "M - Mature"
        case 12:
            cell.tableViewAgeRatingLabel.text = "AO- Adults Only"
        default:
            cell.tableViewAgeRatingLabel.text = " "
            print("Invalid Age Rating")
        }
        
        
        
 
        
        
        
        
        func setCoverImage(from url: String) {
            guard let imageURL = URL(string: url) else { return }
            
            // just not to cause a deadlock in UI!
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
                
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    cell.tableViewCoverImage.image = image
                }
            }
        }
        
        if (game1.cover?.imageID) != nil {
            let coverID = ((game1.cover?.imageID)!)
            setCoverImage(from: "https://images.igdb.com/igdb/image/upload/t_cover_big/\(coverID).jpg")
            
        } else {
            cell.tableViewCoverImage.image = UIImage(named: "noArtNES")
            
        }
        
        
        return cell
        
        
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            
            destination.game = games[(tableView.indexPathForSelectedRow?.row)!]
            
            //            destination.platform = platforms[(tableView.indexPathForSelectedRow?.row)!]
            //
            //            destination.company =  companies[(tableView.indexPathForSelectedRow?.row)!]
            
        }
    }
    //cover.image_id,name,summary, total_rating,platforms.category,platforms,popularity
  
    func downloadJSON(platformSelected: String?, gameName: String?, offset: String?, completed: @escaping () -> () ) {
        print("downloadJSON() triggered")
        let fields = "age_ratings.rating, age_ratings.category, genres.name,  cover.image_id, name, first_release_date, summary, involved_companies.company.name, total_rating, platforms.category, platforms, cover.id, popularity, platforms.versions.platform_logo.image_id, platforms.platform_logo.image_id, platforms.platform_logo.url, screenshots.image_id"
        let gameCategory = "1"
        let limit =  "100"
        let sortField = "name"
        
        currentPlatform = platformSelected
        currentGame = gameName
        
        if gameName != nil {
            searchString = "\"\(gameName!)\""
            print(searchString!)
        }

        var parameters = ""
        if platformSelected != nil { if currentOffset == 0 {
            parameters = "fields \(fields);\nlimit \(limit);\noffset 0;\nwhere platforms = \(platformSelected!);\nsort \(sortField) asc;"
        } else {parameters = "fields \(fields);\nlimit \(limit);\noffset \(currentOffset);\nwhere platforms = \(platformSelected!);\nsort \(sortField) asc;" }
            
            } else if gameName != nil  {
            parameters =  "fields \(fields);\nlimit \(limit);\nsearch \(searchString!);\noffset \(offset);"}
        let postData = parameters.data(using: .utf8)
        print("\(platformSelected)")
        //        let url = URL(string: "https://api-v3.igdb.com/games/?where=platforms=\(platformSelected)%26category=\(gameCategory)&fields=\(fields)&limit=\(limit)&offset=\(offset)&order=\(sortField):asc")!
        let url = URL(string: "https://api-v3.igdb.com/games/")!
        let apiKey = "\(Constants.igdbAPIKey)"
        var requestHeader = URLRequest.init(url: url )
        requestHeader.httpBody = postData
        requestHeader.httpMethod = "POST"
        requestHeader.setValue(apiKey, forHTTPHeaderField: "user-key")
        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
        print("line before URLSession working")
        URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
            print("line after URLSession")
            print(data)
            if error != nil {
                print(error)
            }
            
            if error == nil {
                do {
                    let json = String(data: data!, encoding: .utf8)
                    print("\(json)")
                    
//                    self.games = try JSONDecoder().decode([Game].self, from: data!)
                    
                    let decodedJSON = try JSONDecoder().decode([Game]?.self, from: data!)
                    if let parseJSON = decodedJSON {
                        
                        var items = self.games
                        items.append(contentsOf: parseJSON)
                        
                        if self.initialOffset < items.count {
                            self.games = items
                            self.initialOffset = items.count
                            
                            
                            
                        } else {
                            self.games = items
                        }
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//                        }
                        
                    }
                    
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    
                    print(error)
                    
                }
            }
        }.resume()
        
        self.tableView.reloadData()
        
    }
    func downloadCompaniesJSON(completed: @escaping () -> () ) {
        let url = URL(string: "https://api-v3.igdb.com/companies")!
        let apiKey = "\(Constants.igdbAPIKey)"
        var requestHeader = URLRequest.init(url: url )
        requestHeader.httpBody = "fields name;limit 50;".data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "POST"
        requestHeader.setValue(apiKey, forHTTPHeaderField: "user-key")
        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
            
            if error == nil {
                do {
                    self.companies = try JSONDecoder().decode([Companies].self, from: data!)
                    
                    let json = String(data: data!, encoding: .utf8)
                    print("\(json)")
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    
                    print(error)
                    
                }
            }
        }.resume()
        
    }
    
    
    func downloadPlatformsJSON(completed: @escaping () -> () ) {
        let url = URL(string: "https://api-v3.igdb.com/platforms")!
        let apiKey = "\(Constants.igdbAPIKey)"
        var requestHeader = URLRequest.init(url: url )
        requestHeader.httpBody = "fields id,name,platform_logo.image_id;limit 500;".data(using: .utf8, allowLossyConversion: false)
        requestHeader.httpMethod = "POST"
        requestHeader.setValue(apiKey, forHTTPHeaderField: "user-key")
        requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
            
            if error == nil {
                do {
                    self.platforms = try JSONDecoder().decode([Platform].self, from: data!)
                    
                    let json = String(data: data!, encoding: .utf8)
                    print("\(json)")
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    
                    print(error)
                    
                }
            }
        }.resume()
        
    }
    
    
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("\(row), \(component)")
        
        
        
        switch row {
        case 0:
            //NES
            picked = 18
            gdbPlatformID = 7
        //            image.
        case 1:
            //SNES
            picked = 19
            gdbPlatformID = 6
        case 2:
            //N64
            picked = 4
            gdbPlatformID = 3
        case 3:
            //GC
            picked = 21
            gdbPlatformID = 2
        case 4:
            //GB
            picked = 33
            gdbPlatformID = 4
        case 5:
            //GBA
            picked = 24
            gdbPlatformID = 5
            
        case 6:
            //SG
            picked = 29
            gdbPlatformID = 18
        case 7:
            //SCD
            picked = 78
            gdbPlatformID = 21
        default:
            print("invalid selection")
        }
        self.games.removeAll()
        self.tableView.reloadData()
        downloadJSON(platformSelected: "\(picked)", gameName: nil, offset: "\(initialOffset)") {
          
            print("pickview JSON downloaded")
//            print("platform image id is ** \(self.games[0].platforms?[0].versions?[0].platformLogo?.imageID)?")
            
            //                  if self.games[0].platforms?[0].platformLogo?.imageID != nil {
            //                          let logoID = (self.games[0].platforms?[0].versions?[0].platformLogo?.imageID)!
            //
            //                          self.setLogoImage(from: "https://images.igdb.com/igdb/image/upload/t_logo_med/\(logoID).png")
            //
            //                        }
            self.setPlatformIcon()
            
            self.tableviewPlatformImage.image = UIImage(named: "\(self.imageName)")
            
            self.tableView.reloadData()
        }
        
        print("gamesArray \(self.games)")

        
        
        
        
    }
    
    func setPlatformIcon() {
        switch self.games[0].platforms![0].id {
            
        case 18:
            if self.traitCollection.userInterfaceStyle == .light {
                //Light Mode
                self.imageName = "NESLogo"
            } else {
                //Dark Mode
                self.imageName = "NESLogoInverse"
                
            }
            
        case 19:
            if self.traitCollection.userInterfaceStyle == .light {
                //Light Mode
                self.imageName = "SNESLogo1"
            } else {
                //Dark Mode
                self.imageName = "SNESLogo1Inverse"
                
            }
        case 4:
            if self.traitCollection.userInterfaceStyle == .light {
                //Light Mode
                self.imageName = "N64Logo"
            } else {
                //Dark Mode
                self.imageName = "N64LogoInverse"
                
            }
        case 21:
            if self.traitCollection.userInterfaceStyle == .light {
                //Light Mode
                self.imageName = "GCLogo"
            } else {
                //Dark Mode
                self.imageName = "GCLogoInverse"
                
            }
        case 33:
            if self.traitCollection.userInterfaceStyle == .light {
                //Light Mode
                self.imageName = "GBLogo"
            } else {
                //Dark Mode
                self.imageName = "GBLogoInverse"
                
            }
        case 24:
            if self.traitCollection.userInterfaceStyle == .light {
                //Light Mode
                self.imageName = "GBALogo"
            } else {
                //Dark Mode
                self.imageName = "gbaLogoInverse"
                
            }
        case 29:
            if self.traitCollection.userInterfaceStyle == .light {
                //Light Mode
                self.imageName = "SegaGenesisLogo"
            } else {
                //Dark Mode
                self.imageName = "SegaGenesisLogoInverse"
                
            }
        case 78:
            if self.traitCollection.userInterfaceStyle == .light {
                //Light Mode
                self.imageName = "SegaCDLogo"
            } else {
                //Dark Mode
                self.imageName = "SegaCDLogoInverse"
                
            }
            
        default:
            print("Invalid Platform")
            
        }
        
    }
    @IBAction func searchButtonPressed(_ sender: Any) {
        
        if searchTextField.text != nil {
            gameNamed = searchTextField.text
            print("game named \(gameNamed!)")
            downloadJSON(platformSelected: nil, gameName: "\(gameNamed!)", offset: nil) {
                print("search executed")
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        
        searchTextField.text = nil
    }
    
    //    func setLogoImage(from url: String) {
    //        guard let imageURL = URL(string: url) else { return }
    //        // just not to cause a deadlock in UI!
    //             DispatchQueue.global().async {
    //                 guard let imageData = try? Data(contentsOf: imageURL) else { return }
    //
    //                 let image = UIImage(data: imageData)
    //                 DispatchQueue.main.async {
    //                    self.tableviewPlatformImage.image = image
    //                 }
    //             }
    //
    //    }
    
    
}



// "fields age_ratings,aggregated_rating,artworks,cover,name,rating,screenshots,summary;"
