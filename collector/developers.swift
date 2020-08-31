// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let developerData = try? newJSONDecoder().decode(DeveloperData.self, from: jsonData)

import Foundation

// MARK: - DeveloperData
struct DeveloperData: Codable {
    let code: Int
    let status: String
    let data: DeveloperDataClass
    let remainingMonthlyAllowance, extraAllowance, allowanceRefreshTimer: Int

    enum CodingKeys: String, CodingKey {
        case code, status, data
        case remainingMonthlyAllowance = "remaining_monthly_allowance"
        case extraAllowance = "extra_allowance"
        case allowanceRefreshTimer = "allowance_refresh_timer"
    }
}

// MARK: - DataClass
struct DeveloperDataClass: Codable {
    let count: Int
    let developers: [String: Developer]
}

// MARK: - Developer
struct Developer: Codable {
    let id: Int
    let name: String
}

