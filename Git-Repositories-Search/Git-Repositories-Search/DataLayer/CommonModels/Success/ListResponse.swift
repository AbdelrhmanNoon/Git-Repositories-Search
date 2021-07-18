//
//  ListResponse.swift
//  BeutiCustomer
//
//  Created by AbdulrhmanNoon on 7/17/21.
//

import Foundation

struct ListResponse<T: Codable>: Codable {
    let total_count: Int
    let items: [T]?
    enum CodingKeys: String, CodingKey {
        case items
        case total_count
    }
}
