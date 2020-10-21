//
//  Platforms.swift
//  collector
//
//  Created by Brian on 10/15/20.
//  Copyright © 2020 Brian. All rights reserved.
//

import Foundation


// MARK: - Platforms
struct Platforms: Codable {
    let code: Int
    let status: String
    let data: DataClass
    let remainingMonthlyAllowance, extraAllowance, allowanceRefreshTimer: Int

    enum CodingKeys: String, CodingKey {
        case code, status, data
        case remainingMonthlyAllowance = "remaining_monthly_allowance"
        case extraAllowance = "extra_allowance"
        case allowanceRefreshTimer = "allowance_refresh_timer"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let count: Int
    let platforms: [String: PlatformInfo]
}

// MARK: - Platform
struct PlatformInfo: Codable {
    let id: Int
    let name, alias, icon: String
    let console, controller, developer, manufacturer: String?
    let media, cpu, memory, graphics: String?
    let sound, maxcontrollers, display: String?
    let overview: String
    let youtube: String?
}


struct PlatformObject: Codable {
    
    let id: Int
    let name, alias, icon: String
    let console, controller, developer, manufacturer: String?
    let media, cpu, memory, graphics: String?
    let sound, maxcontrollers, display: String?
    let overview: String
    let youtube: String?
    
}
