//
//  MediaVC.swift
//  collector
//
//  Created by Brian on 11/13/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
import SDWebImage
import WebKit

class MediaVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mediaTableView: UITableView!
    @IBOutlet var clearlogoImageView: UIImageView!
    @IBOutlet var fanartImageView: UIImageView!
    @IBOutlet var gameNameLabel: UILabel!
    @IBOutlet var webView: WKWebView!
    @IBOutlet var playButton: UIButton!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if extraImages?.screenshotArray != nil && extraImages?.fanartArray != nil {
        if (extraImages?.screenshotArray!.count)! > 0 && (extraImages?.fanartArray!.count)! > 0 {
        return 3
        
        
        } else if (extraImages?.screenshotArray!.count)! == 0 && (extraImages?.fanartArray!.count)! > 0 {
            return 2
        } else if (extraImages?.screenshotArray!.count)! > 0 && extraImages?.fanartArray?.count == 0 {
            return 2
        } else {
            return 1
        }
            
        } else {
        return 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var boxartCell = UITableViewCell()
        
        if indexPath.section == 0 {
            let cell = mediaTableView.dequeueReusableCell(withIdentifier: "boxartCell", for: indexPath ) as? BoxartTableViewCell
            boxartCell = cell!
            cell?.images = extraImages
            return cell!
        }
        else if indexPath.section == 1 {
            if (extraImages?.screenshotArray!.count)! > 0 {
            let cell = mediaTableView.dequeueReusableCell(withIdentifier: "screenshotCell", for: indexPath) as? ScreenshotTableViewCell
            cell?.images = extraImages
            return cell!
            }
        }
        else {
            if (extraImages?.fanartArray!.count)! > 0 {
            let cell = mediaTableView.dequeueReusableCell(withIdentifier: "fanartCell", for: indexPath) as? FanartTableViewCell
            cell?.images = extraImages
            return cell!
            }
        }
        return boxartCell
        
    }
    
    
    var game = GameObject()
    var extraImages : Image?
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        var returnValue : Int
//
//        if section == 0 {
//            if extraImages?.boxartArray != nil {
//                returnValue = (extraImages?.boxartArray!.count)!
//            } else { returnValue = 0 }
//        }
//        if section == 1 {
//            if extraImages?.screenshotArray != nil {
//                returnValue = (extraImages?.screenshotArray!.count)!
//            } else { returnValue = 0 }
//        }
//        if section == 2 {
//            if extraImages?.fanartArray != nil {
//                returnValue = (extraImages?.fanartArray!.count)!
//            } else { returnValue = 0 }
//        }
//            else {
//            returnValue = 0
//        }
//
//        return returnValue
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MediaCollectionViewCell
//
//
//        let section = indexPath.section
//
//        if section == 0 {
//            let imageName = extraImages?.boxartArray?[indexPath.row]
//
//            cell?.mediaImageView.loadImage(from: baseURL.small.rawValue + imageName!, completed: {
//                print("image downloaded")
//            })
//        } else if section == 1 {
//            let imageName = extraImages?.screenshotArray?[indexPath.row]
//
//            cell?.mediaImageView.loadImage(from: baseURL.small.rawValue + imageName!, completed: {
//                print("image downloaded")
//            })
//        } else if section == 2 {
//            let imageName = extraImages?.fanartArray?[indexPath.row]
//
//            cell?.mediaImageView.loadImage(from: baseURL.small.rawValue + imageName!, completed: {
//                print("image downloaded")
//            })
//        }
//        return cell!
//    }
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 3
//    }
    
    
//    @IBOutlet weak var mediaCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        mediaCollectionView.delegate = self
//        mediaCollectionView.dataSource = self
        mediaTableView.delegate = self
        mediaTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        webView.layer.cornerRadius = 10
        webView.layer.masksToBounds = false
        
        if (extraImages?.fanartArray!.count)! > 0 {
            fanartImageView.isHidden =
                false
            let image = (extraImages?.fanartArray?[0])!
            fanartImageView.loadImage(from: baseURL.medium.rawValue + image) {
                print("fanartImageView image loaded")
            }
            
            if game.youtubePath == nil {
                webView.isHidden = true
                playButton.isHidden = true
            } else {
                webView.isHidden = true
                playButton.isHidden = false
            }
            

       let gradient = CAGradientLayer()
       gradient.frame = fanartImageView.bounds
       gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor ]
        gradient.locations = [0.5, 1]
            var webViewGradient = CAGradientLayer()
            webViewGradient.frame = webView.bounds
            webViewGradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
            webViewGradient.locations = [0.5, 1]
            webView.layer.mask = webViewGradient
            fanartImageView.layer.mask = gradient

        }
        
        if extraImages?.clearLogo != "" {
            print("clearlogo is not nil")
            print(extraImages?.clearLogo)
            clearlogoImageView.isHidden = false
            gameNameLabel.isHidden = true
            let image = (extraImages?.clearLogo)!
            clearlogoImageView.loadImage(from: baseURL.small.rawValue + image) {
                print("clearlogo image loaded")
            }
        } else {
            print("clearlogo is nil")
            gameNameLabel.isHidden = false
            clearlogoImageView.isHidden = true
                let strokeTextAttributes = [
                    NSAttributedString.Key.strokeColor: UIColor.black,
                    NSAttributedString.Key.foregroundColor: UIColor.white,
                    NSAttributedString.Key.strokeWidth: -3.0,
                    NSAttributedString.Key.font: UIFont(name: "Avenir Next Demi Bold", size: 30)!

                ] as [NSAttributedString.Key : Any]

                gameNameLabel.attributedText = NSMutableAttributedString(string: "\(game.title!)", attributes: strokeTextAttributes)
//            gameNameLabel.text = "\(game.title)"
            
        }
        
    }

    
    @IBAction func playButtonPressed(_ sender: Any) {
                webView.isHidden = false
        fanartImageView.isHidden = true
        clearlogoImageView.isHidden = true
        playButton.isHidden = true
                    let embedURLString = Constants.youtubeEmbedURL
                var url : URL
        if game.youtubePath != nil {
            if (game.youtubePath?.hasPrefix("https"))! {
                url = URL(string: (game.youtubePath!))!
                } else {
                    url = URL(string: embedURLString + (game.youtubePath!))!
                }
                print ("youtube URL = \(url)")
                let request = URLRequest(url: url)
                       webView.load(request)
                } else {
                    playButton.isHidden = true
                    webView.isHidden = true
                }
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
