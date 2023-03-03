//
//  RecentMatchesAPIResponseModel.swift
//  CricInfo
//
//  Created by bjit on 13/2/23.
//
import Foundation

// MARK: - RecentMatchesAPIResponseModel
struct RecentMatchesAPIResponseModel: Codable {
    let data: [DatumRecetMatches]
    let links: LinksRecetMatches
    let meta: MetaRecetMatches
}

// MARK: - DatumRecetMatches
struct DatumRecetMatches: Codable {
    let id: Int
    let type: String?
    let localteam, visitorteam: Team
    let note: String
    let startingAt: String
    let league: League
    let season: Season
    let winnerTeamId: Int?
    let runs: [RunRecetMatches]
    let batting: [BattingRecetMatches?]
    
    enum CodingKeys: String, CodingKey {
        case id, type, localteam, visitorteam, note
        case startingAt = "starting_at"
        case league, season, runs
        case winnerTeamId = "winner_team_id"
        case batting
        
    }
    
   
}

// MARK: - BattingRecetMatches
struct BattingRecetMatches: Codable {
  
    let result: ResultRecetMatches?
    enum CodingKeys: String, CodingKey {
          case result
      }
}

// MARK: - ResultRecetMatches
struct ResultRecetMatches: Codable {
 
    let name: String?

    enum CodingKeys: String, CodingKey {
        case name
    }
}



// MARK: - League
struct League: Codable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
  
    }
}


// MARK: - Season
struct Season: Codable {
    let id: Int
    let name: String
}


// MARK: - Team
struct Team: Codable {
    let id: Int
    let code: String
    let imagePath: String?
    let updatedAt: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id, code, name
        case imagePath = "image_path"
        case updatedAt = "updated_at"
    }
}

// MARK: - RunRecetMatches
struct RunRecetMatches: Codable {
    let id, fixtureID, teamID, inning: Int
    let score, wickets: Int
    let overs: Double
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case fixtureID = "fixture_id"
        case teamID = "team_id"
        case inning, score, wickets, overs
        case updatedAt = "updated_at"
    }
}



// MARK: - LinksRecetMatches
struct LinksRecetMatches: Codable {
    let first, last: String
    let prev: String?
    let next: String?
}

// MARK: - MetaRecetMatches
struct MetaRecetMatches: Codable {
    let currentPage, from, lastPage: Int
    let links: [LinkRecentMatches]
    let path: String
    let perPage, to, total: Int
    
    enum CodingKeys: String, CodingKey {
          case currentPage = "current_page"
          case from
          case lastPage = "last_page"
          case links, path
          case perPage = "per_page"
          case to, total
      }
}


// MARK: - LinkRecentMatches
struct LinkRecentMatches: Codable {
    let url: String?
    let label: String
    let active: Bool
}

