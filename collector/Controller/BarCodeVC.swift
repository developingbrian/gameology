//
//  BarCodeVC.swift
//  collector
//
//  Created by Brian on 9/14/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit
import BarcodeScanner
import Lottie

class BarCodeVC: UIViewController, BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
    
    
    
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        print(error)
    }
    
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        print(code)
        print(type)
        
        let intCode = Int(code)
        print(intCode)
        
        lookupUPC(upc: code) { response in
            print("scanner should reset")
//            controller.reset()
            
            
            if let httpResponse = response as? HTTPURLResponse {

                
                if httpResponse.statusCode == 200 {
                        print("Couldnt find a match to that UPC at all.")
                        print("status code is 200, should do manual search by name")
                        
                        
    //                    while self.network.scannedGameResults.count == 0 {
            //            if self.network.scannedGameResults.count == 0 {
                        controller.dismiss(animated: true, completion: nil)

                        self.scanSuccess = false
                        self.animationView.isHidden = false
                        self.animationView.alpha = 1
                        self.barcodeTableView.alpha = 0
                        self.topLabel.alpha = 0
                        self.bottomLabel.alpha = 0

                    
                    }
    //                        print("should present alert")
    //                        let alert = UIAlertController(title: "No Result From Scan", message: "No results were found.  Would you like to enter the game name manually?", preferredStyle: .alert)
    //                    //                alert.addTextField()
    //
    //
    //
    //                        let okAction = UIAlertAction(title: "Yes", style: .default) { [weak self, weak alert] action in
    //
    //                            print("ok pressed")
    //
    //                            let namePrompt = UIAlertController(title: "Enter the game name", message: nil, preferredStyle: .alert)
    //                            namePrompt.addTextField()
    //
    //                            let nameAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak namePrompt] action in
    //                                guard let answer = namePrompt?.textFields?[0].text else { return }
    //
    //
    //                                self?.network.fetchGameFromUPC(gameName: answer, completed: { error in
    //
    //                                    self?.gameArray = (self?.network.scannedGameResults)!
    //                                    print("fetch complete")
    //                                    self?.barcodeTableView.reloadData()
    //
    //                                })
    //
    //                            }
    //
    //
    //                            namePrompt.addAction(nameAction)
    //                            self?.present(namePrompt, animated: true)
    //                        }
    //
    //                        alert.addAction(okAction)
    //                        print("self.present(alert, animated: true)")
    //                        self.present(alert, animated: true)
    ////                    }
    //
    //                    for game in self.network.scannedGameResults {
    //
    //                        print(game.title!)
    //                    }
    //                    self.gameArray = self.network.scannedGameResults
    //                    self.barcodeTableView.reloadData()
    //
    //                    UIView.animate(withDuration: 1) {
    //                        self.barcodeTableView.alpha = 1
    //                        self.bottomLabel.alpha = 1
    //                        self.topLabel.alpha = 1
    //                        self.scanButton.alpha = 1
    //
    //                    } completion: { complete in
    //                        print("tableview shown")
    //                    }
                        
                                    
            }
        }
        
//        network.fetchUPCInfo(UPC: code) { titleFromUPC in
//            print(titleFromUPC)
//
//
//
//            self.network.fetchGameFromUPC(gameName: titleFromUPC!) { error in
//                if error != nil {
//
//                print("BARCODE SCAN COMPLETE")
//                print("GAME IS")
//                print(self.network.scannedGameResults[0])
//                } else {
//                    print(error)
//                }
//            }
//        }
//        controller.reset()
    }
 
    let network = Networking.shared
    var session : URLSession?
    var gameArray : [GameObject] = []
    var segueObject : GameObject?
    let viewController = BarcodeScannerViewController()
    let gradientLayer = CAGradientLayer()
    
    @IBOutlet weak var animationView: AnimationView!
    var scanSuccess : Bool! {
//        didSet {
//            if let value = oldValue {
//            network.resultsReceived = value
//            }
//        }
        
        willSet {
            if newValue == false {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "noResultFromUPCSearch"), object: nil)

                
            } else {
                print("newValue is", newValue)
            }
        }
    }

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBOutlet weak var scanButton: UIButton!
    
    @IBOutlet weak var barcodeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        animationView.loopMode = .loop
        animationView.play()
        let color2 = UIColorFromRGB(0x2ECAD5)
        let color1 = UIColorFromRGB(0x2B95CE)

        gradientLayer.colors = [color2.cgColor
                                ,color1.cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.frame = scanButton.bounds
        gradientLayer.cornerRadius = 6
        gradientLayer.masksToBounds = false
        scanButton.layer.addSublayer(gradientLayer)
        scanButton.layer.cornerRadius = 6
        
        
        barcodeTableView.delegate = self
        barcodeTableView.dataSource = self
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        session?.configuration.httpCookieAcceptPolicy = .never
        NotificationCenter.default.addObserver(self, selector: #selector(showManualGameEntryAlert), name: NSNotification.Name(rawValue: "noResultFromUPCSearch"), object: nil)
//
//        present(viewController, animated: true, completion: nil)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setAppearance()
    }
    enum PriceChartingInfo {
        case platformID
        case title
    }

    func extractTitle(requestType: PriceChartingInfo, url:String) -> (Int,String) {
        
        do {
            let regex = try NSRegularExpression(pattern: "pricecharting.com/game/(.*)/(.*)?", options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: url, options: [], range: NSRange(location: 0, length: url.utf16.count))
            var platformName = ""
            var platformID = 0
            if let match = matches.first {
               
                let firstMatch = match.range(at: 1)
                if let firstRange = Range(firstMatch, in: url) {
                    let platformSS = url[firstRange]
                    var platform = String(platformSS)
//                     platform = platform.replacingOccurrences(of: "-", with: " ")
                    let pID = convertPriceChartingNameToPlatformID(name: platform)
                    print("platform id is", pID)
                    print(platform)
                  platformID = pID
                }
                
                let secondMatch = match.range(at: 2)
                if let secondRange = Range(secondMatch, in: url) {
                    let titleSS = url[secondRange]
                    var title = String(titleSS)
                    title = title.removingPercentEncoding!
                    title = title.replacingOccurrences(of: "-", with: " ")
//                    title = title.replacingOccurrences(of: "spiderman", with: "spider-man")

                    let titleComponents = title.components(separatedBy: "?")
                    title = titleComponents[0]
                    print(title)
                   platformName = title
                }
                
      
                
                
            }
            return (platformID, platformName)
        }
        catch {
          print("error")
            return (0,"")
        }
    }

    
    func lookupUPC(upc: String, completed: @escaping (URLResponse) -> () ) {
        let url = URL(string: "https://www.pricecharting.com/search-products?q=\(upc)&type=prices")!
//        let url = URL(string: "http://gmail.com")!
        var requestHeader = URLRequest.init(url: url)
        requestHeader.httpMethod = "HEAD"
        requestHeader.httpShouldHandleCookies = false
        requestHeader.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
//        session.dataTask(with: requestHeader, completionHandler: { (data, response, error)  in
//
//            print("data task")
//
//        }
//
//
//
//        ).resume()
        print("curl represent", requestHeader.curlString)
//        session?.dataTask(with: requestHeader).resume()
        session?.dataTask(with: requestHeader, completionHandler: { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                if let l = response.value(forHTTPHeaderField: "Location") {
                    print("location", l)
                }

                print(response)


            }
            print("data is here")
//            print(String(data: data!, encoding: .utf8))
            print(response?.url)
            DispatchQueue.main.async {
                completed(response!)

            }
        }).resume()
        
//        URLSession.shared.dataTask(with: requestHeader).resume()
//        URLSession.shared.dataTask(with: requestHeader) { (data, response, error) in
//
//            print(data)
//            print(response?.url)
//            if let httpResponse = response as? HTTPURLResponse, error == nil {
//                httpResponse.statusCode == 301
//                print(httpResponse.allHeaderFields)
//                print(httpResponse.value(forHTTPHeaderField: "Location"))
//            }
//
//
//        }.resume()
        
    }
    
    func convertPriceChartingNameToPlatformID(name: String) -> Int {
        switch name {
        case "3do"                                          :   return 50
        case "amiga-cd32"                                   :   return 114
        case "atari-2600"                                   :   return 59
        case "atari-5200"                                   :   return 66
        case "atari-7800"                                   :   return 60
        case "jaguar"                                       :   return 62
        case "atari-lynx"                                   :   return 61
        case "colecovision"                                 :   return 68
        case "fairchild-channel-f"                          :   return 127
        case "intellivision"                                :   return 67
        case "magnavox-odyssey"                             :   return 88
        case "xbox"                                         :   return 11
        case "xbox-360"                                     :   return 12
        case "xbox-one"                                     :   return 49
        case "xbox-series-x"                                :   return 169
        case "neo-geo-aes"                                  :   return 80
        case "neo-geo-cd"                                   :   return 136
        case "Neo Geo Pocket"                               :   return 119
        case "neo-geo-pocket-color"                         :   return 120
        case "game-&-watch"                                 :   return 307
        case "nes"                                          :   return 18
        case "super-nintendo"                               :   return 19
        case "virtual-boy"                                  :   return 87
        case "nintendo-64"                                  :   return 4
        case "gamecube"                                     :   return 21
        case "wii"                                          :   return 5
        case "wii-u"                                        :   return 41
        case "nintendo-switch"                              :   return 130
        case "gameboy"                                      :   return 33
        case "gameboy-color"                                :   return 22
        case "gameboy-advance"                              :   return 24
        case "nintendo-ds"                                  :   return 20
        case "Nintendo DSi"                                 :   return 159
        case "nintendo-3ds"                                 :   return 37
        case "New Nintendo 3DS"                             :   return 137
        case "pokemon-mini"                                 :   return 166
        case "n-gage"                                       :   return 42
        case "Nuon"                                         :   return 122
        case "turbografx-16"                                :   return 86
        case "jp-pc-engine"                                 :   return 128
        case "cd-i"                                         :   return 117
        case "jp-sega-mark-iii"                             :   return 84
        case "sega-master-system"                           :   return 64
        case "sega-genesis"                                 :   return 29
        case "sega-cd"                                      :   return 78
        case "sega-32x"                                     :   return 30
        case "sega-saturn"                                  :   return 32
        case "sega-dreamcast"                               :   return 23
        case "sega-game-gear"                               :   return 35
        case "sega-pico"                                    :   return 339
        case "playstation"                                  :   return 7
        case "playstation-2"                                :   return 8
        case "playstation-3"                                :   return 9
        case "playstation-4"                                :   return 48
        case "playstation-5"                                :   return 167
        case "psp"                                          :   return 38
        case "playstation-vita"                             :   return 46
        case "vectrex"                                      :   return 70
        case "wonderswan"                                   :   return 57
        case "wonderswan-color"                             :   return 123
        case "Zeebo"                                        :   return 240
        default                                             :   return 18
        }
        
    }
    
   @objc func showManualGameEntryAlert() {
        
        print("should present alert")
        let alert = UIAlertController(title: "No Result From Scan", message: "No results were found.  Would you like to enter the game name manually?", preferredStyle: .alert)
    //                alert.addTextField()
       
        
        
        let okAction = UIAlertAction(title: "Yes", style: .default) { [weak self, weak alert] action in
            
            print("ok pressed")
            
            let namePrompt = UIAlertController(title: "Enter the game name", message: nil, preferredStyle: .alert)
            namePrompt.addTextField()
            
            let nameAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak namePrompt] action in
                guard let answer = namePrompt?.textFields?[0].text else { return }
               
                
                self?.network.fetchGameFromUPC(gameName: answer, platformID: [], completed: { error in
                    
                    self?.gameArray = (self?.network.scannedGameResults)!
                    print("fetch complete")
                    if self?.network.scannedGameResults.count == 0 {
                        print("scannedGameResults count is", self?.network.scannedGameResults.count)
                        print("scanSuccess false")
                        self?.animationView.alpha = 1
                        self?.animationView.isHidden = false
                        self?.topLabel.alpha = 0
                        self?.bottomLabel.alpha = 0
                        self?.barcodeTableView.alpha = 0
                        self?.scanSuccess = false
                        
                    } else {
                        print("scannedGameResults count is", self?.network.scannedGameResults.count)
                        print("scanSuccess true")

                        
                        self?.scanButton.setTitle("Scan Another Game", for: .normal)

                        
                        UIView.animate(withDuration: 1) {
                            self?.animationView.alpha = 0
                        
                            self?.barcodeTableView.alpha = 1
                            self?.bottomLabel.alpha = 1
                            self?.topLabel.alpha = 1
                        } completion: { complete in
                            print("tableview shown")
                            self?.animationView.isHidden = true
                        }
                        
                        self?.scanSuccess = true
                        
                        
                    }
                    self?.barcodeTableView.reloadData()
                    
                })
                
            }
            
            
            namePrompt.addAction(nameAction)
            self?.present(namePrompt, animated: true)
        }
        
        alert.addAction(okAction)
        print("self.present(alert, animated: true)")
        self.present(alert, animated: true)
        
        
    }
  
    
    @IBAction func scanButtonPressed(_ sender: Any) {
        
        viewController.reset()
        present(viewController, animated: true, completion: nil)
        
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
            topLabel.backgroundColor = lightGray
            bottomLabel.backgroundColor = lightGray
            let lightAnimation = Animation.named("barcodescanner")
            animationView.animation = lightAnimation
            animationView.play()

        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
            view.backgroundColor = darkGray
            topLabel.backgroundColor = darkGray
            bottomLabel.backgroundColor = darkGray
            let darkAnimation = Animation.named("barcodescannerwhite")

            animationView.animation = darkAnimation
            animationView.play()
        }
        
     
        }
        

    
    
    
}

extension BarCodeVC: URLSessionTaskDelegate, URLSessionDelegate, URLSessionDataDelegate {

    
    
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        print("stop redirect")
        print(response.allHeaderFields)
        print(response.url)
        print(request.url)
        
        let requestString = (request.url?.absoluteString)!
        let platformInfo = extractTitle(requestType: .title,url: requestString)
        let platformID = platformInfo.0
        let title = platformInfo.1
        var selectedPlatforms : [Int] = []
        switch platformID {
        case 120:
            selectedPlatforms = [119,120]
        case 22:
            selectedPlatforms = [33,22]
        case 37:
            selectedPlatforms = [37,137]
        default:
            selectedPlatforms.append(platformID)
        }
        print("selected platforms =", selectedPlatforms)
        
        self.network.fetchGameFromUPC(gameName: title, platformID: selectedPlatforms) { error in
            print("search results are")
 
            
            if self.network.scannedGameResults.count == 0 {
                print("search produced no results, starting manual search request")
                self.viewController.dismiss(animated: true) {
                    
                }
                self.scanSuccess = false
                self.animationView.alpha = 1
                self.barcodeTableView.alpha = 0
                self.topLabel.alpha = 0
                self.bottomLabel.alpha = 0
            } else {
                print("search was successful")
                self.viewController.dismiss(animated: true) {
                    
                }
                self.scanSuccess = true
                
                self.scanButton.setTitle("Scan Another Game", for: .normal)
                UIView.animate(withDuration: 1) {
                    self.animationView.alpha = 0
                    
                    self.barcodeTableView.alpha = 1
                    self.bottomLabel.alpha = 1
                    self.topLabel.alpha = 1
                    
                } completion: { complete in
                    print("tableview shown")
                    self.animationView.isHidden = true
                }

            }
            
            for game in self.network.scannedGameResults {
                
                print(game.title!)
            }
            self.gameArray = self.network.scannedGameResults
            self.barcodeTableView.reloadData()

        }
        completionHandler(nil)
        
    }
    

    
  
    
}




extension BarCodeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return network.scannedGameResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = barcodeTableView.dequeueReusableCell(withIdentifier: "barcodeCell", for: indexPath) as? BarcodeTableViewCell
        let game = network.scannedGameResults[indexPath.row]
        let platformName = formatPlatformIDToPlatformName(ID: game.platformID!)
        cell?.gameNameLabel.text = game.title
        cell?.platformLabel.text = platformName
        if let imageFileName = game.boxartFrontImage {
            let urlString =   baseURL.coverSmall.rawValue + imageFileName
            let url = URL(string: urlString)!
        
        cell?.boxartImageView.setImageAnimated(imageUrl: url, placeholderImage: nil, completed: {
            
        })
        }
        cell?.labelView.layer.cornerRadius = 6
        cell?.labelView.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        cell?.labelView.layer.shadowOpacity = 0.75
        cell?.labelView.layer.shadowRadius = 2
        
        return cell!
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        
////        let cell = tableView.cellForRow(at: indexPath) as! BarcodeTableViewCell
////        print("test \(cell.frontImageName)")
//        print("game array count",gameArray.count)
//        segueObject = gameArray[indexPath.row]
//        
//        print("game array is", gameArray)
//        print("segue object is", segueObject)
////        if let image = cell.tableViewCoverImage.image {
////            print("setting boxartimage")
////            segueObject?.boxartImage = image
////        }
////        print(segueObject)
//
//        self.performSegue(withIdentifier: "pagingBarcodeVC", sender: self)
//        
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("prepare for segue")
        if let destination = segue.destination as? PagingDetailVC {
            let index = barcodeTableView.indexPathForSelectedRow
            segueObject = gameArray[index!.row]
            destination.game = segueObject!

            print("destination.game \(destination.game)")
                        
            print("destination2.game", destination.game)

        }
        
    }
    
    
    
    
}

extension URLRequest {

    /**
     Returns a cURL command representation of this URL request.
     */
    public var curlString: String {
        guard let url = url else { return "" }
        var baseCommand = #"curl "\#(url.absoluteString)""#

        if httpMethod == "HEAD" {
            baseCommand += " --head"
        }

        var command = [baseCommand]

        if let method = httpMethod, method != "GET" && method != "HEAD" {
            command.append("-X \(method)")
        }

        if let headers = allHTTPHeaderFields {
            for (key, value) in headers where key != "Cookie" {
                command.append("-H '\(key): \(value)'")
            }
        }

        if let data = httpBody, let body = String(data: data, encoding: .utf8) {
            command.append("-d '\(body)'")
        }

        return command.joined(separator: " \\\n\t")
    }

}
