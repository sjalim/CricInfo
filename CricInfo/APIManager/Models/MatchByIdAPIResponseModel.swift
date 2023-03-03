import Foundation

// MARK: - MatchByIDAPIResponseModel
struct MatchByIDAPIResponseModel: Codable {
    let data: DataClassMatchById
}

// MARK: - DataClassMatchById
struct DataClassMatchById: Codable {
    let id, leagueID, seasonID, stageID: Int?
    let round: String?
    let localteamID, visitorteamID: Int?
    let startingAt, type: String?
    let live: Bool?
    let status: String?
    let note: String?
    let venueID, tossWonTeamID: Int?
    let winnerTeamID: Int?
    let firstUmpireID, secondUmpireID, tvUmpireID, refereeID: Int?
    let manOfMatchID: Int?
    let totalOversPlayed: Int?
    let elected: String?
    let superOver, followOn: Bool?
    let league: LeagueMatchById?
    let season: SeasonMatchById?
    let localteam, visitorteam: TeamMatchById?
    let batting: [BattingMatchById?]
    let bowling: [BowlingMatchById?]
    let runs: [RunMatchById?]
    let lineup: [LineupElementMatchById?]
    let venue: VenueMatchById?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case leagueID = "league_id"
        case seasonID = "season_id"
        case stageID = "stage_id"
        case round
        case localteamID = "localteam_id"
        case visitorteamID = "visitorteam_id"
        case startingAt = "starting_at"
        case type, live, status
        case note
        case venueID = "venue_id"
        case tossWonTeamID = "toss_won_team_id"
        case winnerTeamID = "winner_team_id"
        case firstUmpireID = "first_umpire_id"
        case secondUmpireID = "second_umpire_id"
        case tvUmpireID = "tv_umpire_id"
        case refereeID = "referee_id"
        case manOfMatchID = "man_of_match_id"
        case totalOversPlayed = "total_overs_played"
        case elected
        case superOver = "super_over"
        case followOn = "follow_on"
        case league
        case season, localteam, visitorteam
        case batting
        case bowling
        case  runs
        case lineup
        case venue
    }
}


// MARK: - Team
struct TeamMatchById: Codable {
    let id: Int?
    let code: String?
    let countryId:Int?
    let nationalTeam: Bool?
    let imagePath: String?
    let updatedAt: String
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, code, name
        case imagePath = "image_path"
        case updatedAt = "updated_at"
        case countryId = "country_id"
        case nationalTeam = "national_team"
    }
}

// MARK: - BattingMatchById
struct BattingMatchById: Codable {
    let id, sort, fixtureID, teamID: Int?
    let active: Bool?
    let playerID, ball, scoreID, score: Int?
    let fourX, sixX: Int?
    let catchStumpPlayerID: Int?
    let bowlingPlayerID: Int?
    let batsman: LineupElementMatchById
    let rate: Double?
    let result: ResultMatchById?

    
    enum CodingKeys: String, CodingKey {
          case id, sort
          case fixtureID = "fixture_id"
          case teamID = "team_id"
          case active
          case playerID = "player_id"
          case ball
          case scoreID = "score_id"
          case score
          case fourX = "four_x"
          case sixX = "six_x"
          case catchStumpPlayerID = "catch_stump_player_id"
          case bowlingPlayerID = "bowling_player_id"
          case rate,batsman, result
        
      }
}

// MARK: - ResultMatchById
struct ResultMatchById: Codable {
    let id: Int?
    let name: String?
    let runs: Int?
    let four, six: Bool?
    let bye, legBye, noball, noballRuns: Int?
    let isWicket, ball, out: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, runs, four, six, bye
        case legBye = "leg_bye"
        case noball
        case noballRuns = "noball_runs"
        case isWicket = "is_wicket"
        case ball, out
    }
}



// MARK: - BowlingMatchById
struct BowlingMatchById: Codable {
    let id, sort, fixtureID, teamID: Int?
    let active: Bool?
    let playerID, medians, runs: Int?
    let wickets, wide, noball: Int?
    let rate, overs: Double?
    let bowler: LineupElementMatchById?
    
    enum CodingKeys: String, CodingKey {
        case id, sort
        case fixtureID = "fixture_id"
        case teamID = "team_id"
        case active
        case playerID = "player_id"
        case overs, medians, runs, wickets, wide, noball, rate
        case bowler
    }
}

// MARK: - LeagueMatchById
struct LeagueMatchById: Codable {
    let id: Int
    let seasonID: Int?
    let countryID: Int?
    let name, code: String?
    let imagePath: String?
    let type: String?
    let nationalTeam: Bool?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case seasonID = "season_id"
        case countryID = "country_id"
        case name, code
        case imagePath = "image_path"
        case type
        case nationalTeam = "national_team"
    }
}

// MARK: - LineupElementMatchById
struct LineupElementMatchById: Codable {
    let id, countryID: Int?
    let firstname, lastname, fullname: String?
    let imagePath: String?
    let dateofbirth: String?
    let gender: String?
    let battingstyle: String?
    let bowlingstyle: String?
    let position: Position?
    let lineup: LineupLineup?
    
    enum CodingKeys: String, CodingKey {
            case id
            case countryID = "country_id"
            case firstname, lastname, fullname
            case imagePath = "image_path"
            case dateofbirth, gender, battingstyle, bowlingstyle, position
            case lineup
        }
}

// MARK: - LineupLineup
struct LineupLineup: Codable {
    let teamID: Int?
    let captain, wicketkeeper, substitution: Bool?
    
    enum CodingKeys: String, CodingKey {
        case teamID = "team_id"
        case captain, wicketkeeper, substitution
    }
}

// MARK: - Position
struct Position: Codable {
    let id: Int?
    let name: String?
}

// MARK: - RunMatchById
struct RunMatchById: Codable {
    let id, fixtureID, teamID: Int?
    let inning, wickets, score: Int?
    let overs: Double?
    
    enum CodingKeys: String, CodingKey {
          case id
          case fixtureID = "fixture_id"
          case teamID = "team_id"
          case inning
          case score
            case wickets
            case overs
      }
}

// MARK: - SeasonMatchById
struct SeasonMatchById: Codable {
    let id, leagueID: Int?
    let name, code: String?
    
    enum CodingKeys: String, CodingKey {
          case id
          case leagueID = "league_id"
          case name, code
      }
}

// MARK: - VenueMatchById
struct VenueMatchById: Codable {
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
