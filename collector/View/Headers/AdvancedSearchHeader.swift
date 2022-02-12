//
//  AdvancedSearchHeader.swift
//  collector
//
//  Created by Brian on 10/21/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

class AdvancedSearchHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier: String = String(describing: self)
    var searchDelegate : AdvancedSearchDelegate?
    var isExpanded = false
    
    var titleLbl = UILabel()
    var headerBtn = UIButton()
    var sectionIndex : Int? {
                didSet {
                    configureHeader()
                }
        
    }
    
//    var section : AdvancedSearchSection? {
//

//    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func configureHeader() {
//        let screenWidth = UIScreen.main.bounds.size.width
        if traitCollection.userInterfaceStyle == .dark {
            titleLbl.textColor = .white } else if traitCollection.userInterfaceStyle == .light {
                titleLbl .textColor = .black
                
            }
       
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        headerBtn.translatesAutoresizingMaskIntoConstraints = false
//        headerBtn.clipsToBounds = false
        headerBtn.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        headerBtn.setTitleColor(UIColor.systemGray, for: .normal)
        headerBtn.tintColor = UIColor.systemGray
        headerBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        headerBtn.addTarget(self, action: #selector(didPressHeaderBtn), for: .touchUpInside)
        
        contentView.addSubview(titleLbl)
        contentView.addSubview(headerBtn)
        
        NSLayoutConstraint.activate([
        
            titleLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLbl.heightAnchor.constraint(equalToConstant: 20),
            titleLbl.widthAnchor.constraint(equalToConstant: 100),
        
            
            headerBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            headerBtn.heightAnchor.constraint(equalToConstant: 30),
            headerBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            headerBtn.widthAnchor.constraint(equalToConstant: 30)
        ])
        

        
        
        switch sectionIndex {
        
        case 0:
            textLabel?.text = "TITLE"
            headerBtn.tag = sectionIndex!
 
        case 1:
            textLabel?.text = "PLATFORMS"
            headerBtn.tag = sectionIndex!

        case 2:
            textLabel?.text = "GENRES"
            headerBtn.tag = sectionIndex!


        case 3:
            textLabel?.text = "BY YEARS"
            headerBtn.tag = sectionIndex!


        default:
            print("invalid section")
    
        
        
        }
        
        
        
        
    }
    
    
    @objc func didPressHeaderBtn() {
        
        switch sectionIndex {
        case 0:
            print("section is 0")
        case 1:
            searchDelegate?.headerButtonPressed(section: sectionIndex!)

        case 2:
            searchDelegate?.headerButtonPressed(section: sectionIndex!)

        case 3:
            searchDelegate?.headerButtonPressed(section: sectionIndex!)

            
        default:
            print("invalid section")
        }
        
        
        
        
        
        
        
    }
    
    
}
