//
//  MatchInfoModel.swift
//  CricInfo
//
//  Created by bjit on 16/2/23.
//

import Foundation


class MatchInfoModel{
    let id: Int
    let leagueID: Int
    let seasonID: Int
    let stageID: Int
    let round: String
    let localteamID: Int
    let visitorteamID: Int
    let startingAt: String
    let type: String
    let live: Bool
    let status: String
    let note: String
    let venueID: Int
    let tossWonTeamID: Int
    let winnerTeamID: Int
    let firstUmpireID: Int
    let secondUmpireID: Int
    let tvUmpireID: Int
    let refereeID: Int
    let manOfMatchID: Int
    let totalOversPlayed: Double
    let time: String
    let elected: String
    let superOver: Bool
    let followOn: Bool
    let leagueCountryId: Int
    let leagueName: String
    let leagueCode: String
    let leagueImagePath: String
    let seasonName: String
    let localTeamId: Int
    let localTeamName: String
    let localTeamCode: String
    let localTeamCountryId: Int
    let localTeamImagePath: String
    let localNationalTeam: Bool
    let visitorTeamId: Int
    let visitorTeamName: String
    let visitorTeamCode: String
    let visitorTeamImagePath: String
    let visitorNationalTeam: Bool
    let venueId: Int
    let venueCountryId: Int
    let venueName: String
    let venueCity: String
    let venueImagePath: String
    let venueCapacity: String
    let venueFloodLight: String
    
//    init(matchData: DataClassMatchById){
//
//        if let id = matchData.id {
//            self.id = id
//        }
//
//
//    }
    
    init(matchData data: DataClassMatchById) {
        
        if let id = data.id {
            self.id = id
        } else {
            self.id = Constants.shared.universalNullInt
        }
        
        if let leagueID = data.leagueID{
            
            self.leagueID = leagueID
        } else {
            self.leagueID = Constants.shared.universalNullInt
        }
        
        
        if let seasonID = data.seasonID{
            
            self.seasonID = seasonID
        } else {
            self.seasonID = Constants.shared.universalNullInt
        }
        
        if let stageID = data.stageID{
            
            self.stageID = stageID
        } else {
            self.stageID = Constants.shared.universalNullInt
        }
        
        if let round = data.round{
            
            self.round = round
        } else {
            self.round = Constants.shared.universalNullStr
        }
        
        if let localteamID = data.localteamID{
            
            self.localteamID = localteamID
        } else {
            self.localteamID = Constants.shared.universalNullInt
        }
        
        if let visitorteamID = data.visitorteamID{
            
            self.visitorteamID = visitorteamID
        } else {
            self.visitorteamID = Constants.shared.universalNullInt
        }
        
        if let startingAt = data.startingAt{
            
            self.startingAt = Utilities.shared.getFormattedDate(at: startingAt)
            self.time = Utilities.shared.getFormattedTime(with: startingAt)
        } else {
            self.startingAt = Constants.shared.universalNullStr
            self.time = Constants.shared.universalNullStr
        }
        
    
        
        if let type = data.type{
            
            self.type = type
        } else {
            self.type = Constants.shared.universalNullStr
        }
        
        if let live = data.live{
            
            self.live = live
        } else{
            self.live = false
        }
        
        
        if let status = data.status{
            
            self.status = status
        } else {
            self.status = Constants.shared.universalNullStr
        }
        
        if let note = data.note{
            
            self.note = note
        } else {
            self.note = Constants.shared.universalNullStr
        }
        
        if let venueID = data.venueID{
            
            self.venueID = venueID
        } else {
            self.venueID = Constants.shared.universalNullInt
        }
        
        if let tossWonTeamID = data.tossWonTeamID{
            
            self.tossWonTeamID = tossWonTeamID
        } else {
            self.tossWonTeamID = Constants.shared.universalNullInt
        }
        
        if let winnerTeamID = data.winnerTeamID{
            
            self.winnerTeamID = winnerTeamID
        } else {
            self.winnerTeamID = Constants.shared.universalNullInt
        }
        
        if let firstUmpireID = data.firstUmpireID{
            
            self.firstUmpireID = firstUmpireID
        } else {
            self.firstUmpireID = Constants.shared.universalNullInt
        }
        
        if let secondUmpireID = data.secondUmpireID{
            
            self.secondUmpireID = secondUmpireID
        } else {
            self.secondUmpireID = Constants.shared.universalNullInt
        }
        
        if let tvUmpireID = data.tvUmpireID{
            
            self.tvUmpireID = tvUmpireID
        } else {
            self.tvUmpireID = Constants.shared.universalNullInt
        }
        
        if let refereeID = data.refereeID{
            
            self.refereeID = refereeID
        } else {
            self.refereeID = Constants.shared.universalNullInt
        }
        
        if let manOfMatchID = data.manOfMatchID{
            
            self.manOfMatchID = manOfMatchID
        } else {
            self.manOfMatchID = Constants.shared.universalNullInt
        }
        
        if let totalOversPlayed = data.totalOversPlayed{
            
            self.totalOversPlayed = Double(totalOversPlayed)
        } else{
            self.totalOversPlayed = 0
        }
        if let elected = data.elected{
            
            self.elected = elected
        } else {
            self.elected = Constants.shared.universalNullStr
        }
        
        if let superOver = data.superOver{
            
            self.superOver = superOver
        } else{
            self.superOver = false
        }
        
        if let followOn = data.followOn{
            
            self.followOn = followOn
        } else{
            self.followOn = false
        }
        
        if let leagueCountryId = data.league?.id{
            
            self.leagueCountryId = leagueCountryId
        } else {
            self.leagueCountryId = Constants.shared.universalNullInt
        }
        
        if let leagueName = data.league?.name{
            
            self.leagueName = leagueName
        } else {
            self.leagueName = Constants.shared.universalNullStr
        }
        
        if let leagueCode = data.league?.code{
            
            self.leagueCode = leagueCode
        } else {
            self.leagueCode = Constants.shared.universalNullStr
        }
        
        if let leagueImagePath = data.league?.imagePath{
            
            self.leagueImagePath = leagueImagePath
        } else {
            self.leagueImagePath = Constants.shared.universalNullStr
        }
        
        if let seasonName = data.season?.name{
            
            self.seasonName = seasonName
        } else {
            self.seasonName = Constants.shared.universalNullStr
        }
        
        if let localTeamId = data.localteam?.id{
            
            self.localTeamId = localTeamId
        } else {
            self.localTeamId = Constants.shared.universalNullInt
        }
        
        if let localTeamName = data.localteam?.name{
            
            self.localTeamName = localTeamName
        } else {
            self.localTeamName = Constants.shared.universalNullStr
        }
        
        if let localTeamCode = data.localteam?.code{
            
            self.localTeamCode = localTeamCode
        } else {
            self.localTeamCode = Constants.shared.universalNullStr
        }
        
        if let localTeamCountryId = data.localteam?.countryId{
            
            self.localTeamCountryId = localTeamCountryId
        } else {
            self.localTeamCountryId = Constants.shared.universalNullInt
        }
        
        if let localTeamImagePath = data.localteam?.imagePath{
            
            self.localTeamImagePath = localTeamImagePath
        } else {
            self.localTeamImagePath = Constants.shared.universalNullStr
        }
        
        if let localNationalTeam = data.localteam?.nationalTeam{
            
            self.localNationalTeam = localNationalTeam
        } else{
            self.localNationalTeam = false
        }
        
        if let visitorTeamId = data.visitorteam?.id{
            
            self.visitorTeamId = visitorTeamId
        } else {
            self.visitorTeamId = Constants.shared.universalNullInt
        }
        
        if let visitorTeamName = data.visitorteam?.name{
            
            self.visitorTeamName = visitorTeamName
        } else {
            self.visitorTeamName = Constants.shared.universalNullStr
        }
        
        if let visitorTeamCode = data.visitorteam?.code{
            
            self.visitorTeamCode = visitorTeamCode
        } else {
            self.visitorTeamCode = Constants.shared.universalNullStr
        }
        
        if let visitorTeamImagePath = data.visitorteam?.imagePath{
            
            self.visitorTeamImagePath = visitorTeamImagePath
        } else {
            self.visitorTeamImagePath = Constants.shared.universalNullStr
        }
        
        if let visitorNationalTeam = data.visitorteam?.nationalTeam{
            
            self.visitorNationalTeam = visitorNationalTeam
        } else{
            self.visitorNationalTeam = false
        }
        
        if let venueId = data.venue?.id{
            
            self.venueId = venueId
        } else {
            self.venueId = Constants.shared.universalNullInt
        }
        
        if let venueCountryId = data.venue?.countryID{
            
            self.venueCountryId = venueCountryId
        } else {
            self.venueCountryId = Constants.shared.universalNullInt
        }
        
        if let venueName = data.venue?.name{
            
            self.venueName = venueName
        } else {
            self.venueName = Constants.shared.universalNullStr
        }
        
        if let venueCity = data.venue?.city{
            
            self.venueCity = venueCity
        } else {
            self.venueCity = Constants.shared.universalNullStr
        }
        
        if let venueImagePath = data.venue?.imagePath{
            
            self.venueImagePath = venueImagePath
        } else {
            self.venueImagePath = Constants.shared.universalNullStr
        }
        
        if let venueCapacity = data.venue?.capacity{
            
            self.venueCapacity = String(venueCapacity)
        } else {
            self.venueCapacity = Constants.shared.universalNullStr
        }
        
        if let venueFloodLight = data.venue?.floodlight{
            if venueFloodLight == true{
                self.venueFloodLight = "Yes"
            }
            else
            {
                self.venueFloodLight = "No"

            }
        }
        else {
            self.venueFloodLight = "No"

        }
            
        
        
       
    }
}
