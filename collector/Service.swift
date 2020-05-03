//
//  Service.swift
//  collector
//
//  Created by Brian on 3/21/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation


//class Service {
//    private var state: State = .ready
//    private var page: Int = 0
//    private var request: URLSessionDataTask?
// 
//    func reloadAllData() {
//        if state == .ready || state == .loadNext || state == .endOfContent {
//            page = 0
//            state = .reloading
//            cancelCurrentRequest()
//            fetch(page: self.page, callback: { [weak self] in
//                // fetched data
//            })
//        }
//    }
// 
//    func fetchNextPage() {
//        if state == .ready {
//            state = .loadNext
//            fetch(page: self.page, callback: { [weak self] in
//                // fetched data
//            })
//        }
//    }
// 
//    private func fetch(page: Int, callback: () -> Void) {
//
//        // API it's network layer
//        request = API.fetch({ [weak self] items in
//            if items.isEmpty {
//                self?.state = .endOfContent
//            } else {
//                self?.state = .none
//                self?.page += 1
//            }
//            callback()
//        })
//    }
// 
//    func cancelCurrentRequest() {
//        request?.cancel()
//    }
//}
