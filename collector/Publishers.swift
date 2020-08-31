// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let publisherData = try? newJSONDecoder().decode(PublisherData.self, from: jsonData)

import Foundation

// MARK: - PublisherData
struct PublisherData: Codable {
    let code: Int
    let status: String
    let data: PublisherDataClass
    let remainingMonthlyAllowance, extraAllowance, allowanceRefreshTimer: Int

    enum CodingKeys: String, CodingKey {
        case code, status, data
        case remainingMonthlyAllowance = "remaining_monthly_allowance"
        case extraAllowance = "extra_allowance"
        case allowanceRefreshTimer = "allowance_refresh_timer"
    }
}

// MARK: - DataClass
struct PublisherDataClass: Codable {
    let count: Int
    let publishers: [String: Publisher]
}

// MARK: - Publisher
struct Publisher: Codable {
    let id: Int
    let name: String
}
