//
//  PlayerModel.swift
//  CricInfo
//
//  Created by bjit on 21/2/23.
//

import Foundation


import Foundation
import CoreData

// MARK: - OfficialsByIDAPIResponseModelSwift
struct PlayerAPIResponseModel: Codable {
    let data: [DatumPlayer]
}

// MARK: - DatumPlayer
struct DatumPlayer: Codable {
    let id: Int
    let fullname: String
    let imagePath: String
    
    enum CodingKeys: String, CodingKey {
          case id, fullname
          case imagePath = "image_path"
      }
    
}


