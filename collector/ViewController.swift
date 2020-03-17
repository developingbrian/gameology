//
//  ViewController.swift
//  collector
//
//  Created by Brian on 3/10/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var games = [GameDetail]()
    var game : GameDetail?
    var companies = [Companies]()
    var platforms = [Platform]()
    var platform : Platform?
    var company : Companies?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        downloadJSON {
            self.tableView.reloadData()
        }
        
        downloadCompaniesJSON {
            print("Success Companies JSON")
        }
        
        downloadPlatformsJSON {
            print("Success Platforms JSON")
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = games[indexPath.row].name.capitalized
        return cell
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            
            destination.game = games[(tableView.indexPathForSelectedRow?.row)!]
            
            destination.platform = platforms[(tableView.indexPathForSelectedRow?.row)!]
            
            destination.company =  companies[(tableView.indexPathForSelectedRow?.row)!]
            
        }
    }
    
    func downloadJSON(completed: @escaping () -> () ) {
    let url = URL(string: "https://api-v3.igdb.com/games")!
    let apiKey = "cb4d31574547c1aae77a34959ef2dfa6"
        var requestHeader = URLRequest.init(url: url )
    requestHeader.httpBody = "fields cover.image_id,name,summary, total_rating,platforms.category,platforms,popularity;limit 50;where platforms.category = (1) & platforms = 19;sort popularity desc;".data(using: .utf8, allowLossyConversion: false)
    requestHeader.httpMethod = "POST"
    requestHeader.setValue(apiKey, forHTTPHeaderField: "user-key")
    requestHeader.setValue("application/json", forHTTPHeaderField: "Accept")
    URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
        
        if error == nil {
            do {
                self.games = try JSONDecoder().decode([GameDetail].self, from: data!)
                
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
     func downloadCompaniesJSON(completed: @escaping () -> () ) {
        let url = URL(string: "https://api-v3.igdb.com/companies")!
        let apiKey = "cb4d31574547c1aae77a34959ef2dfa6"
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
        let apiKey = "cb4d31574547c1aae77a34959ef2dfa6"
            var requestHeader = URLRequest.init(url: url )
        requestHeader.httpBody = "fields name,platform_logo.image_id;limit 50;".data(using: .utf8, allowLossyConversion: false)
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
}



// "fields age_ratings,aggregated_rating,artworks,cover,name,rating,screenshots,summary;"
