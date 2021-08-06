//
//  MenuTableViewController.swift
//  collector
//
//  Created by Brian on 3/17/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit
import SafariServices

class MenuTableViewController: UITableViewController, SFSafariViewControllerDelegate {
    @IBOutlet weak var vesionLabel: UILabel!
    @IBOutlet weak var appearanceSegmentedControls: UISegmentedControl!



    
    
       /// CUSTOMIZE TO YOUR OWN APP/LINKS
    let appStoreURLStringForRating = "itms-apps://apple.com/app/id1534974973"
    let appStoreURLStringForShareSheet = "https://apps.apple.com/us/app/id1534974973"
    let twitterURLString = "https://twitter.com/davejacobseniOS"
    let gameDBURLString = "https://thegamesdb.net"
    let neorameURLString = "https://www.deviantart.com/neorame"
    let supportEmail = "marketcapp.app@gmail.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
//        if let appVersion = UIApplication.appVersion {
//            vesionLabel.text = "gameology ver. \(appVersion)"
//        }
        vesionLabel.text = "gameology"
        
        let logo = UIImage(named: "glogo44")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        /// delete this if your wildcard settings make all the content take up more than the smallest iPhone screen size
        tableView.isScrollEnabled = true
        tableView.separatorColor = .systemGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        /// This will makes sure when the user hits this screen, that the appearance is synced to their device settings
        setAppearance()
    }
    
    func setAppearance() {
        
        let defaults = UserDefaults.standard
        let appearanceSelection = defaults.integer(forKey: "appearanceSelection")
        appearanceSegmentedControls.selectedSegmentIndex = appearanceSelection
        
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
            tableView.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)

        } else if traitCollection.userInterfaceStyle == .dark {
           tableView.backgroundColor = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)

        }
    }
    //appearanceValueChanged
    @IBAction func appearanceValueDidChange(_ sender: Any) {
    
             
        let defaults = UserDefaults.standard
        
        if appearanceSegmentedControls.selectedSegmentIndex == 0 {
            overrideUserInterfaceStyle = .unspecified
            defaults.setValue(0, forKey: "appearanceSelection")
            setAppearance()

            }
         else if appearanceSegmentedControls.selectedSegmentIndex == 1 {
            overrideUserInterfaceStyle = .light
            defaults.setValue(1, forKey: "appearanceSelection")
            setAppearance()
        } else if appearanceSegmentedControls.selectedSegmentIndex == 2 {
            overrideUserInterfaceStyle = .dark
            defaults.setValue(2, forKey: "appearanceSelection")
            setAppearance()
        } else {
            print("selection error")
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: return 1
        case 1: return 3
        case 2: return 3
        case 3: return 1
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        /// Set to your own styling preferences
        
        switch section {
        case 0: return 35
        case 1: return 35
        case 2: return 15
        case 3: return 6
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath {
        case [1, 1]: launchHelpfulLink()
        case [1, 2]: launchNeorameLink()
        case [2, 0]: promptRating()
            tableView.deselectRow(at: indexPath, animated: true)
        case [2, 1]: launchShareSheet()
            tableView.deselectRow(at: indexPath, animated: true)
        case [2, 2]: composeShareEmail()
            tableView.deselectRow(at: indexPath, animated: true)
        default: print("no class function triggered for index path: \(indexPath)")
        }
    }
    //yourAppsSwitchValueChanged
    @IBAction func switchChanged(_ sender: Any) {
   
    
    print("Your Apps switch value changed")
    }
    
    func launchHelpfulLink() {
        let urlString = gameDBURLString
        
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            
            present(vc, animated: true)
        }
    }
    
    func launchNeorameLink() {
       
            let urlString = neorameURLString
            
            if let url = URL(string: urlString) {
                let vc = SFSafariViewController(url: url)
                vc.delegate = self
                
                present(vc, animated: true)
            }
        
    }
    
    func promptRating() {
        if let url = URL(string: appStoreURLStringForRating) {
            UIApplication.shared.open(url)
        } else {
            print("error with app store URL")
        }
    }
    
    func launchShareSheet() {
        if let appURL = NSURL(string: appStoreURLStringForShareSheet) {
            
            let objectsToShare: [Any] = [appURL]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList]
            activityVC.popoverPresentationController?.sourceView = tableView
            
            self.present(activityVC, animated: true, completion: nil)
        }
        
    }
    
    
    
    
    
    
    //twitterHandleTapped
    @IBAction func handlePressed(_ sender: Any) {
  
    let urlString = twitterURLString
        
        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url)
            vc.delegate = self
            
            present(vc, animated: true)
        }
    }
}

extension MenuTableViewController: MFMailComposeViewControllerDelegate {
    
    func composeShareEmail() {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let messageBody: String
        let deviceModelName = UIDevice.modelName
        let iOSVersion = UIDevice.current.systemVersion
        let topDivider = "------- Developer Info -------"
        let divider = "------------------------------"
        
        if let appVersion = UIApplication.appVersion {
            
            messageBody =  "\n\n\n\n\(topDivider)\nApp version: \(appVersion)\nDevice model: \(deviceModelName)\niOS version: \(iOSVersion)\n\(divider)"
        } else {
            messageBody = "\n\n\n\n\(topDivider)\nDevice model: \(deviceModelName)\niOS version: \(iOSVersion)\n\(divider)"
        }
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([supportEmail])
        mailComposerVC.setSubject("Your App Feedback")
        mailComposerVC.setMessageBody(messageBody, isHTML: false)
        return mailComposerVC
    }
    
    /// This alert gets shown if the device is a simulator, doesn't have Apple mail set up, or if mail in not available due to connectivity issues.
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send email. Please check email configuration and internet connection and try again.", preferredStyle: .alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
