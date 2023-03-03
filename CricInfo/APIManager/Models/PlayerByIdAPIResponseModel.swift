//
//  PlayerByIdAPIResponseModel.swift
//  CricInfo
//
//  Created by bjit on 18.2.2023.
//

import Foundation

// MARK: - PlayerByIdAPIResponseModel
struct PlayerByIdAPIResponseModel: Codable {
    let data: DataClassPlayerById?
}

// MARK: - DataClassPlayerById
struct DataClassPlayerById: Codable {
    let id, countryID: Int?
    let firstname, lastname, fullname: String?
    let imagePath: String?
    let dateofbirth, gender, battingstyle, bowlingstyle: String?
    let position: PositionPlayerById?
    let country: Country?
    let career: [Career?]
    let teams, currentteams: [TeamPlayerById?]
    
    enum CodingKeys: String, CodingKey {
        case id
        case countryID = "country_id"
        case firstname, lastname, fullname
        case imagePath = "image_path"
        case dateofbirth, gender, battingstyle, bowlingstyle, position, country
        case career, teams, currentteams
    }
}

// MARK: - Career
struct Career: Codable {
    let type: String?
    let seasonID, playerID: Int?
    let bowling: [String: Double]?
    let batting: [String: Double]?
    let season: SeasonPlayerById?
    
    enum CodingKeys: String, CodingKey {
        case type
        case seasonID = "season_id"
        case playerID = "player_id"
        case bowling, batting
        case season
    }
}

// MARK: - SeasonPlayerById
struct SeasonPlayerById: Codable  {
    let id, leagueID: Int?
    let name, code: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case leagueID = "league_id"
        case name, code
    }
}

// MARK: - Country
struct Country: Codable {
    let id, continentID: Int?
    let name: String?
    let imagePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case continentID = "continent_id"
        case name
        case imagePath = "image_path"
    }
}

// MARK: - TeamPlayerById
struct TeamPlayerById: Codable  {
    let id: Int?
    let name, code: String?
    let imagePath: String?
    let countryID: Int?
    let nationalTeam : Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, name, code
        case imagePath = "image_path"
        case countryID = "country_id"
        case nationalTeam = "national_team"
      
    }
}


// MARK: - PositionPlayerById
struct PositionPlayerById: Codable  {
    let id: Int?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}
