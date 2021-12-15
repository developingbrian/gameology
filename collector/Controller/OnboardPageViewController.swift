//
//  OnboardPageViewController.swift
//  collector
//
//  Created by Brian on 8/9/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit
import Lottie

//class OnboardPageViewController: UIPageViewController {
//
//    var pages = [UIViewController]()
//    let pageControl = UIPageControl()
//    let skipButton = UIButton()
//    let nextButton = UIButton()
//    let initialPage = 0
//    var width : CGFloat = 0.0
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        dataSource = self
//        delegate = self
//
//         width = view.frame.width
//
//
//        nextButton.translatesAutoresizingMaskIntoConstraints = false
//        nextButton.setTitle("Next", for: .normal)
//        nextButton.backgroundColor = .red
//        nextButton.layer.cornerRadius = 10
//        nextButton.layer.shadowOffset = CGSize(width: 3, height: 3)
//        nextButton.layer.shadowOpacity = 0.75
//        nextButton.layer.shadowRadius = 3
//        nextButton.addTarget(self, action: #selector(nextTapped(_:)), for: .touchDown)
//        skipButton.setTitle("Skip", for: .normal)
//        skipButton.backgroundColor = .red
//        skipButton.layer.cornerRadius = 10
//        skipButton.layer.shadowOffset = CGSize(width: 3, height: 3)
//        skipButton.layer.shadowOpacity = 0.75
//        skipButton.layer.shadowRadius = 3
//        skipButton.alpha = 0
//        skipButton.translatesAutoresizingMaskIntoConstraints = false
//
//        pageControl.translatesAutoresizingMaskIntoConstraints = false
////        pageControl.backgroundColor = .red
//        pageControl.currentPageIndicatorTintColor = .white
//        pageControl.pageIndicatorTintColor = .white
//        if #available(iOS 14.0, *) {
//        pageControl.backgroundStyle = .minimal
//        }
//
//        pageControl.numberOfPages = pages.count
//        pageControl.currentPage = 0
//        view.addSubview(skipButton)
//        view.addSubview(nextButton)
////        view.addSubview(pageControl)
//        skipButton.isHidden = false
//
//        NSLayoutConstraint.activate([
////            pageControl.heightAnchor.constraint(equalToConstant: 50),
////            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
////            pageControl.leadingAnchor.constraint(equalTo:skipButton.trailingAnchor),
////            pageControl.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor),
////            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
//            skipButton.heightAnchor.constraint(equalToConstant: 50),
//
//
//            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
//            skipButton.widthAnchor.constraint(equalTo: skipButton.heightAnchor, multiplier: (2.0/1.0)),
//            nextButton.heightAnchor.constraint(equalToConstant: 50),
//
//            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
//            nextButton.widthAnchor.constraint(equalTo: nextButton.heightAnchor, multiplier: (2.0/1.0))
//
//        ])
//
//        if width > 320 {
//
//            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
//            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
//        } else {
//
//            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -3.5).isActive = true
//            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -3.5).isActive = true
//
//        }
////        pageControl.addTarget(self, action: #selector(page), for: <#T##UIControl.Event#>)
//
//        let gamelibraryOBVC = (self.storyboard?.instantiateViewController(identifier: "onboarding"))! as OnboardVC
//        let addtoOBVC = (self.storyboard?.instantiateViewController(identifier: "onboarding"))! as OnboardVC
//        let wishlistOBVC = (self.storyboard?.instantiateViewController(identifier: "onboarding"))! as OnboardVC
//        let detailOBVC = (self.storyboard?.instantiateViewController(identifier: "onboardingdetail"))! as OnboardDetailVC
//
//
//
//        gamelibraryOBVC.image = "mockup-gamedatabase"
//        gamelibraryOBVC.cardTitle = "Your Games, All In One Place"
//        gamelibraryOBVC.summary = "The Game Database is your main location to view and search for games."
//        gamelibraryOBVC.tag = 0
//
//        addtoOBVC.image = "mockup-addtolibrary"
//        addtoOBVC.cardTitle = "Add The Games You Own"
//        addtoOBVC.summary = "Adding and removing games from your personal library is as easy as the press of a button.  Press once to add.  Press again to remove."
//        addtoOBVC.tag = 1
//
//        wishlistOBVC.image = "mockup-wishlist"
//        wishlistOBVC.cardTitle = "Slide Into Your Wishlist"
//        wishlistOBVC.summary = "Slide left to add games to your wishlist."
//        wishlistOBVC.tag = 2
//
//        detailOBVC.image = "mockup-details"
//        detailOBVC.cardTitle = "It's All In The Details"
//        detailOBVC.summary = "Any game can be added to your wishlist or library from its details page."
//        detailOBVC.tag = 3
//
//        pages.append(gamelibraryOBVC)
//        pages.append(addtoOBVC)
//        pages.append(wishlistOBVC)
//        pages.append(detailOBVC)
//
//        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
//
//    }
//
//
//
//
//}


//
//extension OnboardPageViewController: UIPageViewControllerDataSource {
////    func presentationCount(for pageViewController: UIPageViewController) -> Int {
////        return pages.count
////    }
////
////    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
////        return 0
////    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//
//        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
//
//        if currentIndex == 0 {
//            return pages.last
//        } else {
//
//            return pages[currentIndex - 1]
//        }
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//
//        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
//
//
//        if currentIndex < pages.count - 1 {
//            return pages[currentIndex + 1]
//
//        } else {
//
//            return pages.first
//        }
//    }
//
//
//
//
//
//}
//
//
//extension OnboardPageViewController: UIPageViewControllerDelegate {
//
//    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
//
//        let viewController = pendingViewControllers[0] as? OnboardVC
//        UIView.animate(withDuration: 0.5) {
//            viewController?.phoneImageView.alpha = 0
//            viewController?.cardView.alpha = 0
//            viewController?.onboardSummary.alpha = 0
//            viewController?.onboardTitle.alpha = 0
//
//
//        }
//        let vc = pendingViewControllers[0] as? OnboardDetailVC
//
//        UIView.animate(withDuration: 0.5) {
//            vc?.phoneImageView.alpha = 0
//            vc?.cardView.alpha = 0
//            vc?.onboardSummary.alpha = 0
//            vc?.onboardTitle.alpha = 0
//        }
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//
//        guard let viewControllers = pageViewController.viewControllers else { return }
//        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
//        let currentVC = viewControllers[0] as? OnboardVC
//        let currentVCDetail = viewControllers[0] as? OnboardDetailVC
//
//        print("currentIndex", currentIndex)
//        print("currentPAge", pageControl.currentPage)
//        let lastPage = currentIndex == pages.count - 1
//        let firstPage = currentIndex == 0
//        if lastPage {
//            print("last page")
////            UIView.animate(withDuration: 0.5) {
////                self.skipButton.alpha = 0
////                self.skipButton.isHidden = true
////
////            }
//            UIView.animate(withDuration: 0.5) {
//                self.skipButton.alpha = 0
//
//            } completion: { complete in
//                if complete {
//                    self.skipButton.isHidden = true
//
//                }
//            }
//        } else if firstPage{
//            print("first page")
////            UIView.animate(withDuration: 0.5) {
////
////            }
//            UIView.animate(withDuration: 0.5) {
//                self.skipButton.alpha = 0
//
//            } completion: { complete in
//                if complete {
//                    self.skipButton.isHidden = true
//
//                }
//            }
//
//        } else {
//            self.skipButton.isHidden = false
//
//            UIView.animate(withDuration: 0.5) {
//                currentVC?.onboardSummary.alpha = 1
//                currentVC?.onboardTitle.alpha = 1
//                currentVC?.phoneImageView.alpha = 1
//                currentVC?.cardView.alpha = 1
//
//
//                self.skipButton.alpha = 1
//
//            }
//        }
//    }
//}
//
//extension OnboardPageViewController {
//    @objc func nextTapped(_ sender: UIButton) {
//
//        goToNextPage()
//
//    }
//
//
//   func goToNextPage(animated: Bool = true, completion: ((Bool)->Void)? = nil) {
//
//        guard let currentPage = viewControllers?[0] else { return }
//        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
//
//        guard let currentIndex = pages.firstIndex(of: currentPage) else { return }
//
//
//
//        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
//
//    }
//
//    func goToPreviousPage(animated: Bool = true, completion: ((Bool)-> Void)? = nil) {
//
//        guard let currentPage = viewControllers?[0] else { return }
//        guard let previousPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
//
//        setViewControllers([previousPage], direction: .forward, animated: animated, completion: completion)
//
//
//    }
//
//}




class OnboardVC: UIViewController {

    @IBOutlet weak var phoneImageView: UIImageView!
    @IBOutlet weak var onboardTitle: UILabel!
    @IBOutlet weak var onboardSummary: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var cardView: UIView!
    let currentIndex = 1
    var lightShadow = CALayer()
    
    var image: String?
    var cardTitle: String?
    var summary: String?
    var width: CGFloat = 0.0
    var tag = 0
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAppearance()
        width = view.frame.width

//        if width > 320 {
//
//            onboardSummary.heightAnchor.constraint(equalToConstant: 150).isActive = true
//
//        } else {
//            print("onboard summary height is 76.5")
//
//            onboardSummary.heightAnchor.constraint(equalToConstant: 76.5).isActive = true
//
//    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneImageView.alpha = 0
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowOpacity = 0.60
        cardView.layer.shadowRadius = 4
        
        lightShadow.frame = nextButton.bounds
        lightShadow.cornerRadius = 10
        lightShadow.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        lightShadow.shadowRadius = 5
        lightShadow.shadowOffset = CGSize(width: -1.5, height: -1.5)
        lightShadow.shadowOpacity = 1
        lightShadow.backgroundColor = UIColor.tertiarySystemBackground.cgColor
        
        let lightBlue = UIColorFromRGB(0x2B95CE)
        let blue = UIColorFromRGB(0x2ECAD5)
        nextButton.applyGradientRounded(layoutIfNeeded: true, colors: [blue.cgColor, lightBlue.cgColor])
        nextButton.layer.cornerRadius = 10
        nextButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        nextButton.layer.shadowOpacity = 0.75
        nextButton.translatesAutoresizingMaskIntoConstraints = false
//        nextButton.layer.insertSublayer(lightShadow, at: 0)
//        nextButton.clipsToBounds = false
//        nextButton.layer.masksToBounds = false

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1.5, delay: 0, animations: {
            self.phoneImageView.alpha = 1
        }, completion: { finished in
//            print("phoneImageView finished")
        
        })
        
        
    }
    
    @IBAction func nextPressed(_ sender: Any) {
//        print("pressed")
        nextButton.layer.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        lightShadow.shadowColor = UIColor.black.withAlphaComponent(0.75)
            .cgColor
    }
    
    @IBAction func nextReleased(_ sender: Any) {
//        print("released")

        lightShadow.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        nextButton.layer.shadowColor = UIColor.black.cgColor
    }
    
    
    func setAppearance() {
        
        let defaults = UserDefaults.standard
        let appearanceSelection = defaults.integer(forKey: "appearanceSelection")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ViewControllerTableViewCell

        
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

        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
            view.backgroundColor = darkGray
        }
        
        

        
    }

    
}





class OnboardInitialVC: UIViewController {
    
    
        
    @IBOutlet weak var lottieView: UIView!
    @IBOutlet weak var onboardTitle: UILabel!
    @IBOutlet weak var onboardSummary: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var cardView: UIView!
    private var animationView: AnimationView?
    @IBOutlet weak var logoView: UIView!
    private var animationLogoView: AnimationView?
    let currentIndex = 1
    let lightShadow = CALayer()

    var image: String?
    var cardTitle: String?
    var summary: String?
    var width: CGFloat = 0.0
    var tag = 0
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        setAppearance()
        
        width = view.frame.width
//
//        if width > 320 {
//            onboardSummary.heightAnchor.constraint(equalToConstant: 150).isActive = true
//
//        } else {
//            onboardSummary.heightAnchor.constraint(equalToConstant: 76.5).isActive = true
//
//    }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardView.layer.cornerRadius = 20
        cardView.layer.shadowOpacity = 0.60
        cardView.layer.shadowRadius = 4
        cardView.clipsToBounds = false
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        lightShadow.frame = nextButton.bounds
        lightShadow.cornerRadius = 10
        lightShadow.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        lightShadow.shadowRadius = 5
        lightShadow.shadowOffset = CGSize(width: -1.5, height: -1.5)
        lightShadow.shadowOpacity = 1
        lightShadow.backgroundColor = UIColor.tertiarySystemBackground.cgColor
        
        
        
        
        let lightBlue = UIColorFromRGB(0x2B95CE)
        let blue = UIColorFromRGB(0x2ECAD5)
        nextButton.applyGradientRounded(layoutIfNeeded: true, colors: [blue.cgColor, lightBlue.cgColor])
//        nextButton.layer.masksToBounds = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.layer.cornerRadius = 10
        nextButton.layer.shadowOpacity = 0.75
//        nextButton.layer.shadowRadius = 5
        nextButton.layer.shadowOffset = CGSize(width: 3, height: 3)
//        nextButton.layer.insertSublayer(lightShadow, at: 0)
//        nextButton.clipsToBounds = false
        
        
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.clipsToBounds = false
        
        animationLogoView = .init(name: "logo")
        animationLogoView!.frame = logoView.bounds
        animationLogoView!.contentMode = .scaleAspectFill
        animationLogoView!.loopMode = .playOnce
        animationLogoView!.animationSpeed = 1
        logoView.addSubview(animationLogoView!)
        animationLogoView?.play()
        
  
        
        
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        lottieView.clipsToBounds = false
        
        animationView = .init(name: "gamepadgradient")
        animationView!.frame = lottieView.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.75
        lottieView.addSubview(animationView!)
        
        let delay = DispatchTime.now() + 9.5
        
        DispatchQueue.main.asyncAfter(deadline: delay) {
            
            UIView.animate(withDuration: 2) {
                self.animationLogoView?.alpha = 0
                self.logoView.alpha = 0
            } completion: { complete in
//                print("animationview should be hidden")
                self.logoView?.isHidden = true
                self.animationView!.play()

            }

            
        }
        
        
        
//        guard let imageName = image else { return}
//        guard let titleName = cardTitle else { return }
//        guard let summaryName = summary else { return }
//
//
//        onboardTitle.text = titleName
//        onboardSummary.text = summaryName
//
//
//
//            UIView.animate(withDuration: 0.5) {
//
//                self.view.alpha = 1
//            }
//        setAppearance()
    }
    
    
    func setAppearance() {
        
        let defaults = UserDefaults.standard
        let appearanceSelection = defaults.integer(forKey: "appearanceSelection")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ViewControllerTableViewCell

        
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
            logoView.backgroundColor = lightGray
            animationLogoView?.backgroundColor = lightGray

        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
            view.backgroundColor = darkGray
            logoView.backgroundColor = darkGray
            animationLogoView?.backgroundColor = darkGray

        }
        
        

        
    }
    
    @IBAction func nextButtonTouchDown(_ sender: Any) {
//        print("pressed")
        nextButton.layer.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        lightShadow.shadowColor = UIColor.black.withAlphaComponent(0.75)
            .cgColor
    }
    

    
    @IBAction func touched(_ sender: Any) {
        
//        print("released")
        lightShadow.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        nextButton.layer.shadowColor = UIColor.black.cgColor
        
    }
    
}


class OnboardDetailVC: UIViewController {
    @IBOutlet weak var phoneImageView: UIImageView!
    @IBOutlet weak var onboardTitle: UILabel!
    @IBOutlet weak var onboardSummary: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    let currentIndex = 1
    let lightShadow = CALayer()
    
    var image: String?
    var cardTitle: String?
    var summary: String?
    var tag = 3
    var width : CGFloat = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAppearance()
        width = view.frame.width

        if width > 767 {
//            print("phone image view should be moved")
            phoneImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300).isActive = true
            
        }
        
//        if width > 320 {
//            onboardSummary.heightAnchor.constraint(equalToConstant: 150).isActive = true
//
//        } else {
//            //
//            onboardSummary.heightAnchor.constraint(equalToConstant: 76.5).isActive = true
//
//    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowOpacity = 0.60
        cardView.layer.shadowRadius = 4
        cardView.clipsToBounds = false
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        lightShadow.frame = nextButton.bounds
        lightShadow.cornerRadius = 10
        lightShadow.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        lightShadow.shadowRadius = 5
        lightShadow.shadowOffset = CGSize(width: -1.5, height: -1.5)
        lightShadow.shadowOpacity = 1
        lightShadow.backgroundColor = UIColor.tertiarySystemBackground.cgColor
        
        
        let lightBlue = UIColorFromRGB(0x2B95CE)
        let blue = UIColorFromRGB(0x2ECAD5)
        nextButton.applyGradientRounded(layoutIfNeeded: true, colors: [blue.cgColor, lightBlue.cgColor])
        nextButton.layer.cornerRadius = 10
        nextButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        nextButton.layer.shadowOpacity = 0.75
        nextButton.translatesAutoresizingMaskIntoConstraints = false
//        nextButton.layer.insertSublayer(lightShadow, at: 0)
//        nextButton.layer.masksToBounds = false
//        nextButton.clipsToBounds = false
       
        
        
        guard let imageName = image else { return}
        guard let titleName = cardTitle else { return }
        guard let summaryName = summary else { return }
        
        
        phoneImageView.image = UIImage(named: imageName)
        onboardTitle.text = titleName
        onboardSummary.text = summaryName

        
        setAppearance()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1.5, delay: 0, animations: {
            self.phoneImageView.alpha = 1
        }, completion: { finished in
//            print("phoneImageView finished")
        
        })
        
        
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        nextButton.layer.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        lightShadow.shadowColor = UIColor.black.withAlphaComponent(0.75)
            .cgColor
        
        
    }
    

    @IBAction func nextReleased(_ sender: Any) {
        
        lightShadow.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        nextButton.layer.shadowColor = UIColor.black.cgColor
    }
    
    
    func setAppearance() {
        
        let defaults = UserDefaults.standard
        let appearanceSelection = defaults.integer(forKey: "appearanceSelection")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ViewControllerTableViewCell

        
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

        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
            view.backgroundColor = darkGray
        }
        
        

        
    }
}


class OnboardCompletionVC: UIViewController {
    
    
    @IBOutlet weak var lottieView: UIView!
    @IBOutlet weak var onboardTitle: UILabel!
    @IBOutlet weak var onboardSummary: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var cardView: UIView!
    private var animationView: AnimationView?
    let currentIndex = 1
    let lightShadow = CALayer()
    
    var image: String?
    var cardTitle: String?
    var summary: String?
    var width: CGFloat = 0.0
    var tag = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setAppearance()

        width = view.frame.width

//        if width > 320 {
//            onboardSummary.heightAnchor.constraint(equalToConstant: 150).isActive = true
//
//        } else {
//            onboardSummary.heightAnchor.constraint(equalToConstant: 76.5).isActive = true
//
//    }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowOpacity = 0.60
        cardView.layer.shadowRadius = 4
        
        lightShadow.frame = nextButton.bounds
        lightShadow.cornerRadius = 10
        lightShadow.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        lightShadow.shadowRadius = 5
        lightShadow.shadowOffset = CGSize(width: -1.5, height: -1.5)
        lightShadow.shadowOpacity = 1
        lightShadow.backgroundColor = UIColor.tertiarySystemBackground.cgColor
        
        let lightBlue = UIColorFromRGB(0x2B95CE)
        let blue = UIColorFromRGB(0x2ECAD5)
        nextButton.applyGradientRounded(layoutIfNeeded: true, colors: [blue.cgColor, lightBlue.cgColor])
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.layer.cornerRadius = 10
        nextButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        nextButton.layer.shadowOpacity = 0.75
        
        width = view.frame.width
        
        animationView = .init(name: "game")
        animationView!.frame = lottieView.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.75
        view.addSubview(animationView!)
        
        animationView!.play()
        
//        guard let imageName = image else { return}
        guard let titleName = cardTitle else { return }
        guard let summaryName = summary else { return }

     
        onboardTitle.text = titleName
        onboardSummary.text = summaryName

 

        
            UIView.animate(withDuration: 0.5) {
                
                self.view.alpha = 1
            }
        
        
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        nextButton.layer.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        lightShadow.shadowColor = UIColor.black.withAlphaComponent(0.75)
            .cgColor
        
        
    }
    
    @IBAction func nextReleased(_ sender: Any) {
        
        lightShadow.shadowColor = UIColor.white.withAlphaComponent(0.75).cgColor
        nextButton.layer.shadowColor = UIColor.black.cgColor
        
        
    }
    func setAppearance() {
        
        let defaults = UserDefaults.standard
        let appearanceSelection = defaults.integer(forKey: "appearanceSelection")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ViewControllerTableViewCell

        
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

        } else if traitCollection.userInterfaceStyle == .dark {
            let darkGray = UIColor(red: (18/255), green: (18/255), blue: (18/255), alpha: 1)
            view.backgroundColor = darkGray
        }
        
        

        
    }
}


