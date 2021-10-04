//
//  UPCScan.swift
//  collector
//
//  Created by Brian on 9/14/21.
//  Copyright © 2021 Brian. All rights reserved.
//

import Foundation

// MARK: - Barcode
struct Barcode: Codable {
    let barcodeClass, code, barcodeDescription: String
    let imageURL: String
    let size, status: String

    enum CodingKeys: String, CodingKey {
        case barcodeClass = "class"
        case code
        case barcodeDescription = "description"
        case imageURL = "image_url"
        case size, status
    }
}
