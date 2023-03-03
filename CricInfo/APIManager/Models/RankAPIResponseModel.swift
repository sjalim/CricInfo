//
//  RankAPIResponseModel.swift
//  CricInfo
//
//  Created by bjit on 22/2/23.
//

import Foundation

// MARK: - RankAPIResponseModelSwift
struct RankAPIResponseModel: Codable {
    let data: [DatumRank]
}

// MARK: - DatumRank
struct DatumRank: Codable {
    let type: String?
    let gender: String?
    let team: [TeamRank]
    
    enum CodingKeys: String, CodingKey {
          case type, gender
          case team
      }
}

// MARK: - TeamRank
struct TeamRank: Codable {
    let id: Int?
    let name, code: String?
    let imagePath: String?
    let countryID: Int?
    let ranking: Ranking
    
    enum CodingKeys: String, CodingKey {
          case id, name, code
          case imagePath = "image_path"
          case countryID = "country_id"
          case ranking
      }
}

// MARK: - Ranking
struct Ranking: Codable {
    let position, matches, points, rating: Int?
}
