//
//  OfficialsByIdAPIResponseModel.swift
//  CricInfo
//
//  Created by bjit on 16/2/23.
//

import Foundation

// MARK: - OfficialsByIDAPIResponseModelSwift
struct OfficialsByIDAPIResponseModelSwift: Codable {
    let data: DataClassOfficialsById
}

// MARK: - DataClassOfficialsById
struct DataClassOfficialsById: Codable {
    let id, countryID: Int?
    var firstname, lastname, fullname, dateofbirth: String?
    let gender: String?

    enum CodingKeys: String, CodingKey {
        case id
        case countryID = "country_id"
        case firstname, lastname, fullname, dateofbirth, gender
    }
}
