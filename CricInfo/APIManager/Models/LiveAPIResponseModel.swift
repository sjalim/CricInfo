//
//  LiveAPIResponseModel.swift
//  CricInfo
//
//  Created by bjit on 22/2/23.
//

import Foundation


import Foundation

// MARK: - LiveAPIResponseModelSwift
struct LiveAPIResponseModel: Codable {
    let data: [DatumLive]
}

// MARK: - DatumLive
struct DatumLive: Codable {
    let id, leagueID, seasonID, stageID: Int
    let round: String
    let localteamID, visitorteamID: Int
    let startingAt, type: String
    let live: Bool
    let status: String
    let note: String
    let tossWonTeamID: Int
    let elected: String
    let league: LeagueLive
    let season: SeasonLive
    let localteam, visitorteam: LeagueLive
    let batting: [BattingLive]
    let bowling: [BowlingLive]
    let runs: [RunLive]
    let lineup: [LineupElementLive]
    let tosswon: LeagueLive
    let venue: Venue
    let stage: LeagueLive
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case leagueID = "league_id"
        case seasonID = "season_id"
        case stageID = "stage_id"
        case round
        case localteamID = "localteam_id"
        case visitorteamID = "visitorteam_id"
        case startingAt = "starting_at"
        case type
        case live
        case status
        case note
        case tossWonTeamID = "toss_won_team_id"
        case elected
        case league, season
        case localteam, visitorteam, batting, bowling, runs, lineup, tosswon, venue, stage
    }
}

// MARK: - BattingLive
struct BattingLive: Codable {
    let id, sort, fixtureID, teamID: Int
    let active: Bool
    let scoreboard: String
    let playerID, ball, scoreID, score: Int
    let fourX, sixX: Int
    let rate: Double
    let batsman: LineupElementLive
    let result: ResultLive
    
    enum CodingKeys: String, CodingKey {
           case id, sort
           case fixtureID = "fixture_id"
           case teamID = "team_id"
           case active, scoreboard
           case playerID = "player_id"
           case ball
           case scoreID = "score_id"
           case score
           case fourX = "four_x"
           case sixX = "six_x"
           case batsman, result, rate
       }
}

// MARK: - LineupElementLive
struct LineupElementLive: Codable {
    let id, countryID: Int
    let firstname, lastname, fullname: String
    let imagePath: String
    let dateofbirth: String
    let gender: String
    let battingstyle: String?
    let bowlingstyle: String?
    let position: PositionLive
    let lineup: LineupLineupLive?
    
    enum CodingKeys: String, CodingKey {
        case id
        case countryID = "country_id"
        case firstname, lastname, fullname
        case imagePath = "image_path"
        case dateofbirth, gender, battingstyle, bowlingstyle, position
        case lineup
    }
}


// MARK: - LineupLineupLive
struct LineupLineupLive: Codable {
    let teamID: Int
    let captain, wicketkeeper: Bool
    
    
    enum CodingKeys: String, CodingKey {
           case teamID = "team_id"
           case captain, wicketkeeper
       }
}

// MARK: - PositionLive
struct PositionLive: Codable {
    let id: Int
    let name: String
}

// MARK: - ResultLive
struct ResultLive: Codable {
    let id: Int
    let name: String
    let runs: Int
    let four, six: Bool
    let bye, legBye, noball, noballRuns: Int
    let isWicket, ball, out: Bool
    
    enum CodingKeys: String, CodingKey {
         case id, name, runs, four, six, bye
         case legBye = "leg_bye"
         case noball
         case noballRuns = "noball_runs"
         case isWicket = "is_wicket"
         case ball, out
     }
}

// MARK: - BowlingLive
struct BowlingLive: Codable {
    let id, sort, fixtureID, teamID: Int
    let active: Bool
    let scoreboard: String
    let playerID: Int
    let overs: Double
    let medians, runs, wickets, wide: Int
    let noball: Int
    let rate: Double
    let bowler: LineupElementLive
    
    
    enum CodingKeys: String, CodingKey {
        case id, sort
        case fixtureID = "fixture_id"
        case teamID = "team_id"
        case active, scoreboard
        case playerID = "player_id"
        case overs, medians, runs, wickets, wide, noball, rate
        case bowler
    }
}

// MARK: - LeagueLive
struct LeagueLive: Codable {
    let id: Int
    let seasonID, countryID: Int?
    let name, code: String
    let imagePath: String?
    let type: String?
    let nationalTeam: Bool?
    let leagueID: Int?
    let standings: Bool?
    
    enum CodingKeys: String, CodingKey {
           case id
           case seasonID = "season_id"
           case countryID = "country_id"
           case name, code
           case imagePath = "image_path"
           case type
           case nationalTeam = "national_team"
           case leagueID = "league_id"
           case standings
       }
}

// MARK: - RunLive
struct RunLive: Codable {
    let id, fixtureID, teamID, inning: Int
    let score, wickets: Int
    let overs: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case fixtureID = "fixture_id"
        case teamID = "team_id"
        case inning, score, wickets, overs
    }
}

// MARK: - SeasonLive
struct SeasonLive: Codable {
    let id, leagueID: Int
    let name, code: String
    
    enum CodingKeys: String, CodingKey {
           case id
           case leagueID = "league_id"
           case name, code
       }
}

// MARK: - Venue
struct Venue: Codable {
    let id, countryID: Int?
    let name, city: String?
    let imagePath: String?
    let capacity: Int?
    let floodlight: Bool?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case countryID = "country_id"
        case name, city
        case imagePath = "image_path"
        case capacity, floodlight
    }
}

