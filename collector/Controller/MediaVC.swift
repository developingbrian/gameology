//
//  MediaVC.swift
//  collector
//
//  Created by Brian on 11/13/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit
import SDWebImage
import YoutubePlayer

class MediaVC: UIViewController {
   
    
    

    
    deinit {
        
            print("MediaVC in paging detail vc is deallocated now")
//        webView.stopLoading()
//        webView.configuration.userContentController.removeScriptMessageHandler(forName: "dummy")
        }
    
    
        
    @IBOutlet weak var youTubeView: YoutubePlayerView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var mediaTableView: UITableView!
//    @IBOutlet var clearlogoImageView: UIImageView!
    @IBOutlet weak var fanartImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    let gradient = CAGradientLayer()
    @IBOutlet weak var viewForButton: UIView!
    var game = GameObject()
    var extraImages : Image?
    

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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("MEDIAVC LOADED")
        if game.youtubePath != nil {
            loadYouTubeView()
        }
        
        configureInitialAppearance()
    }
 
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        youTubeView.stop()
 
    }


    override func viewWillAppear(_ animated: Bool) {
        setAppearance()
        fanartImageView.alpha = 1
        playButton.alpha = 1
        youTubeView.isHidden = true
        youTubeView.alpha = 0
        
        gradient.isHidden = false
        fanartImageView.isHidden = false
//        clearlogoImageView.isHidden = false
        playButton.isHidden = false
        gameNameLabel.isHidden = false

        mediaTableView.reloadData()
        
        if game.youtubePath == nil {
            playButton.isHidden = true
        } else {
            playButton.isHidden = false
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("**Viewdidappear")

        


        
        if let screenshots = game.screenshots {
            if screenshots.count > 0 {
            let random = screenshots.randomElement()
            let image = (random?.imageID)! + ".jpg"
            let url = URL(string: baseURL.screenshotMedium.rawValue + image)
            fanartImageView.setImageAnimated(imageUrl: url!, placeholderImage: nil) {
                print("screenshot set")
            }
            } else {
                fanartImageView.image = UIImage(named: "arcadeBackground")

            }
        } else {
            fanartImageView.image = UIImage(named: "arcadeBackground")
        }
            
//                print("youtubePath = \(game.youtubePath)")

        
        gradient.frame = fanartImageView.bounds
        gradient.locations = [0.75, 1]
        gradient.opacity = 0.75

            fanartImageView.layer.mask = gradient

        setAppearance()
    }
    
    
    
    @IBAction func playButtonPressed(_ sender: Any) {
        print("playbutton pressed")
        
        youTubeView.isHidden = false
        gradient.isHidden = true
        gameNameLabel.isHidden = true
        self.playButton.isHidden = true

        UIView.animate(withDuration: 2, delay: 0) {
            
            self.fanartImageView.alpha = 0
            self.youTubeView.alpha = 1
        } completion: { complete in
            self.fanartImageView.isHidden = true
            self.youTubeView.play()
        }


        
    }
    
    func loadYouTubeView() {
    var url : URL
if let youtubePath = game.youtubePath {
if (youtubePath.hasPrefix("https")) {
    url = URL(string: (youtubePath))!
    do {
       
        
        try self.youTubeView.loadVideo(withUrl: url, playerVars: .init(playsInline: .true))
        
    }

    catch {

        print("error loading video")
    }
    
    
    print("loading with url")
    } else {
       
        do {
            print("loading with video id ", youtubePath)

            try self.youTubeView.loadVideo(withId: youtubePath, playerVars: .init(playsInline: .true))
        }
        catch {
            print("error loading video")
        }
        
    }

    }
        
    }
    
    
    func configureInitialAppearance() {
        
        let darkBlue = UIColorFromRGB(0x2B95CE)

        let lightBlue = UIColorFromRGB(0x2ECAD5)
        gameNameLabel.text = game.title
        
        
        guard let symbol = UIImage(systemName: "play.circle") else { fatalError("No symbol by that name") }
        let mask = CALayer()
        mask.contents = symbol.cgImage

        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [lightBlue.cgColor, darkBlue.cgColor]
        gradientLayer.frame = playButton.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        

        
        mask.frame = gradientLayer.bounds
        gradientLayer.mask = mask
        playButton.layer.addSublayer(gradientLayer)
        
        playButton.layer.shadowOffset = .zero
        playButton.layer.shadowColor = UIColor.black.cgColor
        playButton.layer.shadowRadius = 1.5
        playButton.layer.shadowOpacity = 1

        mediaTableView.delegate = self
        mediaTableView.dataSource = self

        setAppearance()
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
            backgroundView.layer.backgroundColor = lightGray.cgColor

            mediaTableView.layer.backgroundColor = lightGray.cgColor
            gradient.colors = [UIColor.lightGray.cgColor, UIColor.clear.cgColor ]

        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1)

            backgroundView.layer.backgroundColor = darkGray.cgColor
            gradient.colors = [UIColor.darkGray.cgColor, UIColor.clear.cgColor ]

            mediaTableView.layer.backgroundColor = darkGray.cgColor

        }
    }
    
    


}






extension MediaVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        

//        print("screenshot! \(game.screenshots)")
        
        if game.boxartFrontImage != nil {
        if (game.screenshots) != nil {
            if (game.screenshots!.count) > 0 {
                print("screenshot cell")
            return 2
        }
        }
            
            return 1
            
        }
        
        
        return 0
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
            cell?.setAppearance()
            cell?.parent = self
            cell?.images = extraImages
            cell?.game = game
            return cell!
        }
        else if indexPath.section == 1 {
            if (game.screenshots?.count)! > 0 {
            let cell = mediaTableView.dequeueReusableCell(withIdentifier: "screenshotCell", for: indexPath) as? ScreenshotTableViewCell
                cell?.parent = self
                cell?.game = game
            return cell!
            }
        }
       
        return boxartCell
        
    }
    
    
    
}
