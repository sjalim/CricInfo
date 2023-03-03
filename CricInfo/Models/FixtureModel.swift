//
//  FixtureModel.swift
//  CricInfo
//
//  Created by bjit on 21/2/23.
//

import Foundation


class FixtureModel{
    
    let fixtureId: Int
    let leagueType: String
    let matchResultNote: String
    let localTeamId: Int
    let localTeamCode: String
    let localTeamImagePath: String
    let localTeamName: String
    let visitorTeamId: Int
    let visitorTeamCode: String
    let visitorTeamImagePath: String
    let vistitorTeamName: String
    let leagueId: Int
    let leagueName: String
    let seasonId: Int
    let seasonName: String
    let matchDate: String
    
    init(matchData data: DatumUpcomingMatches) {
        
        self.fixtureId = data.id
        
        if let leagueType = data.type {
            
            self.leagueType = leagueType
        } else {
            
            self.leagueType = Constants.shared.universalNullStr

        }
        
        self.matchResultNote = data.note
      
        
        self.localTeamId = data.localteam.id
        
        
        self.localTeamCode = data.localteam.code
        
        if let localTeamImagePath = data.localteam.imagePath {
            self.localTeamImagePath = localTeamImagePath
                    
        } else {
            
            self.localTeamImagePath = Constants.shared.universalNullStr

        }
      
        if let visitorTeamImagePath = data.visitorteam.imagePath {
            self.visitorTeamImagePath = visitorTeamImagePath
        } else {
            self.visitorTeamImagePath = Constants.shared.universalNullStr
        }
        
        
        self.matchDate = Utilities.shared.getFormattedDate(at: data.startingAt)
        
        
        self.localTeamName = data.localteam.name
        
        self.visitorTeamId = data.visitorteam.id
        
        self.visitorTeamCode = data.visitorteam.code
    
        self.vistitorTeamName = data.visitorteam.name
        
        self.leagueId = data.league.id
        
        self.leagueName = data.league.name
        
        self.seasonId = data.season.id
        
        self.seasonName = data.season.name
        
    }
    
    
}
