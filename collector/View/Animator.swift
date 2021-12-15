//
//  Animator.swift
//  collector
//
//  Created by Brian on 10/8/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import UIKit

final class Animator {
    private var hasAnimatedAllCells = false
    private let animation: AnimationType

    init(animation: @escaping AnimationType) {
        self.animation = animation
    }

    func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
        guard !hasAnimatedAllCells else {
            return
        }

        animation(cell, indexPath, tableView)
        if cell == tableView.visibleCells.last {
        hasAnimatedAllCells = true
        }
        
        
       
        hasAnimatedAllCells = tableView.isLastVisibleCell(at: indexPath)
    }
    

}

extension UITableView {
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
//            tableView.indexPathsForVisibleRows?.last
        guard let lastIndexPath = indexPathsForVisibleRows?.last else {
            return false
        }
        return lastIndexPath == indexPath
    }
}
    

