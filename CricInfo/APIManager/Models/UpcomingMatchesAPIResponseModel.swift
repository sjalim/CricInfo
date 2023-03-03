//
//  UpcomingMatchesAPIResponseModel.swift
//  CricInfo
//
//  Created by bjit on 13/2/23.
//

import Foundation

// MARK: - UpcomingMatchesAPIResponseModel
struct UpcomingMatchesAPIResponseModel: Codable {
    let data: [DatumUpcomingMatches]
//    let links: LinksUpcomingMatches
//    let meta: MetaUpcomingMatches
}

// MARK: - DatumUpcomingMatches
struct DatumUpcomingMatches: Codable {
    let id: Int
    let type: String?
    let note: String
    let leagueId: Int
    let localteam, visitorteam: Team
    let league: League
    let season: Season
    let startingAt: String
    enum CodingKeys: String, CodingKey {
        case id, type, note, localteam,visitorteam
        case league, season
        case leagueId = "league_id"
        case startingAt = "starting_at"

    }
    
}






// MARK: - LinksUpcomingMatches
struct LinksUpcomingMatches: Codable {
    let first, last: String
    let prev: String?
    let next: String?
}

// MARK: - MetaUpcomingMatches
struct MetaUpcomingMatches: Codable {
    let currentPage, from, lastPage: Int
    let links: [LinkUpcomingMatches]
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


// MARK: - LinkUpcomingMatches
struct LinkUpcomingMatches: Codable {
    let url: String?
    let label: String
    let active: Bool
}
