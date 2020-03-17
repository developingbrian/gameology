//
//  ViewController.swift
//  collector
//
//  Created by Brian on 3/4/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var boxArtImage: UIImageView!
    
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var gameDetailView: UIView!
    
    @IBOutlet weak var gameNameLabel: UILabel!
    
    @IBOutlet weak var summaryText: UILabel!
    
    @IBOutlet weak var publisherLabel: UILabel!
    
    @IBOutlet weak var ratingStarOne: UIImageView!
    
    @IBOutlet weak var ratingStarTwo: UIImageView!
    
    @IBOutlet weak var ratingStarThree: UIImageView!
    
    @IBOutlet weak var ratingStarFour: UIImageView!
    
    @IBOutlet weak var ratingStarFive: UIImageView!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    var screenshotImageData = ["screenshot1", "screenshot2", "screenshot3", "screenshot4"]
    
    var imageCounter = 0
    
    var game : GameDetail?
    var company : Companies?
    var platform: Platform?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("\(game?.cover?.imageID)")
        print("platform logo image id is \(platform?.platformLogo?.imageID)")
        if game?.cover?.imageID != nil {
            let coverID = (game?.cover?.imageID)!
            setCoverImage(from: "https://images.igdb.com/igdb/image/upload/t_cover_big/\(coverID).jpg")
            
        }
        
        if platform?.platformLogo?.imageID != nil {
            let logoID = (platform?.platformLogo?.imageID)!
            setLogoImage(from: "https://images.igdb.com/igdb/image/upload/t_logo_med/\(logoID).jpg")
            
        }
    
        print("")
        
        boxArtImage.layer.cornerRadius = 20
        boxArtImage.layer.masksToBounds = true
        titleView.layer.cornerRadius = 10
        titleView.layer.masksToBounds = false
        gameDetailView.layer.cornerRadius = 10
        gameDetailView.layer.masksToBounds = false
        gameNameLabel.text = game?.name
        summaryText.text = game?.summary
        publisherLabel.text = company?.name
        
        
        print("\(boxArtImage.image)")
        if game?.totalRating != nil {
            let ratingConvert = (((game!.totalRating!)/10)/2)
            
            print(ratingConvert)
            
            switch ratingConvert {
                case 0.5..<1:
                    let halfRating = String(format: "%.2f", ratingConvert)
                    ratingLabel.text = String(halfRating)
                    ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarTwo.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarThree.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarOne.image = UIImage(systemName: "star.lefthalf.fill")
                    ratingStarTwo.image = UIImage(systemName: "star")
                    ratingStarThree.image = UIImage(systemName: "star")
                    ratingStarFour.image = UIImage(systemName: "star")
                    ratingStarFive.image = UIImage(systemName: "star")
                
                case 1..<1.5:
                    let halfRating = String(format: "%.2f", ratingConvert)
                    ratingLabel.text = String(halfRating)
                    ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarTwo.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarThree.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarOne.image = UIImage(systemName: "star.fill")
                    ratingStarTwo.image = UIImage(systemName: "star")
                    ratingStarThree.image = UIImage(systemName: "star")
                    ratingStarFour.image = UIImage(systemName: "star")
                    ratingStarFive.image = UIImage(systemName: "star")
                case 1.5..<2:
                    let halfRating = String(format: "%.2f", ratingConvert)
                    ratingLabel.text = String(halfRating)
                    ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarThree.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarOne.image = UIImage(systemName: "star.fill")
                    ratingStarTwo.image = UIImage(systemName: "star.lefthalf.fill")
                    ratingStarThree.image = UIImage(systemName: "star")
                    ratingStarFour.image = UIImage(systemName: "star")
                    ratingStarFive.image = UIImage(systemName: "star")
                case 2..<2.5:
                    let halfRating = String(format: "%.2f", ratingConvert)
                    ratingLabel.text = String(halfRating)
                    ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarThree.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarOne.image = UIImage(systemName: "star.fill")
                    ratingStarTwo.image = UIImage(systemName: "star.fill")
                    ratingStarThree.image = UIImage(systemName: "star")
                    ratingStarFour.image = UIImage(systemName: "star")
                    ratingStarFive.image = UIImage(systemName: "star")
                case 2.5..<3:
                    let halfRating = String(format: "%.2f", ratingConvert)
                    ratingLabel.text = String(halfRating)
                    ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarThree.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarOne.image = UIImage(systemName: "star.fill")
                    ratingStarTwo.image = UIImage(systemName: "star.fill")
                    ratingStarThree.image = UIImage(systemName: "star.lefthalf.fill")
                    ratingStarFour.image = UIImage(systemName: "star")
                    ratingStarFive.image = UIImage(systemName: "star")
                case 3..<3.5:
                    let halfRating = String(format: "%.2f", ratingConvert)
                    ratingLabel.text = String(halfRating)
                    ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarThree.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarOne.image = UIImage(systemName: "star.fill")
                    ratingStarTwo.image = UIImage(systemName: "star.fill")
                    ratingStarThree.image = UIImage(systemName: "star.fill")
                    ratingStarFour.image = UIImage(systemName: "star")
                    ratingStarFive.image = UIImage(systemName: "star")
                case 3.5..<4:
                    let halfRating = String(format: "%.2f", ratingConvert)
                    ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarThree.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarFour.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingLabel.text = String(halfRating)
                    ratingStarOne.image = UIImage(systemName: "star.fill")
                    ratingStarTwo.image = UIImage(systemName: "star.fill")
                    ratingStarThree.image = UIImage(systemName: "star.fill")
                    ratingStarFour.image = UIImage(systemName: "star.lefthalf.fill")
                    ratingStarFive.image = UIImage(systemName: "star")
                case 4..<4.5:
                    let halfRating = String(format: "%.2f", ratingConvert)
                    ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarThree.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarFour.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingLabel.text = String(halfRating)
                    ratingStarOne.image = UIImage(systemName: "star.fill")
                    ratingStarTwo.image = UIImage(systemName: "star.fill")
                    ratingStarThree.image = UIImage(systemName: "star.fill")
                    ratingStarFour.image = UIImage(systemName: "star.fill")
                    ratingStarFive.image = UIImage(systemName: "star")
                case 4.5..<5:
                    let halfRating = String(format: "%.2f", ratingConvert)
                    ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarThree.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarFour.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarFive.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingLabel.text = String(halfRating)
                    ratingStarOne.image = UIImage(systemName: "star.fill")
                    ratingStarTwo.image = UIImage(systemName: "star.fill")
                    ratingStarThree.image = UIImage(systemName: "star.fill")
                    ratingStarFour.image = UIImage(systemName: "star.fill")
                    ratingStarFive.image = UIImage(systemName: "star.lefthalf.fill")
                case 5:
                    let halfRating = String(format: "%.2f", ratingConvert)
                    ratingStarOne.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarTwo.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarThree.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarFour.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingStarFive.tintColor = #colorLiteral(red: 1, green: 0.8784313725, blue: 0.07843137255, alpha: 1)
                    ratingLabel.text = String(halfRating)
                    ratingStarOne.image = UIImage(systemName: "star.fill")
                    ratingStarTwo.image = UIImage(systemName: "star.fill")
                    ratingStarThree.image = UIImage(systemName: "star.fill")
                    ratingStarFour.image = UIImage(systemName: "star.fill")
                    ratingStarFive.image = UIImage(systemName: "star.fill")
                default:
                    ratingLabel.text = "N/A"
                    ratingStarOne.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarTwo.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarThree.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
                    ratingStarOne.image = UIImage(systemName: "star")
                    ratingStarTwo.image = UIImage(systemName: "star")
                    ratingStarThree.image = UIImage(systemName: "star")
                    ratingStarFour.image = UIImage(systemName: "star")
                    ratingStarFive.image = UIImage(systemName: "star")
        }
      
        } else {
            ratingLabel.text = "N/A"
            ratingStarOne.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
            ratingStarTwo.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
            ratingStarThree.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
            ratingStarFour.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
            ratingStarFive.tintColor = #colorLiteral(red: 0.6352941176, green: 0.6352941176, blue: 0.6549019608, alpha: 1)
            ratingStarOne.image = UIImage(systemName: "star")
            ratingStarTwo.image = UIImage(systemName: "star")
            ratingStarThree.image = UIImage(systemName: "star")
            ratingStarFour.image = UIImage(systemName: "star")
            ratingStarFive.image = UIImage(systemName: "star")
            
        }
    }
    

    func setCoverImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.boxArtImage.image = image
                self.backgroundImage.image = image
            }
        }
    }
    
    func setLogoImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        // just not to cause a deadlock in UI!
             DispatchQueue.global().async {
                 guard let imageData = try? Data(contentsOf: imageURL) else { return }

                 let image = UIImage(data: imageData)
                 DispatchQueue.main.async {
                    self.logoImage.image = image
                 }
             }
        
    }
    
    
    
    


}

