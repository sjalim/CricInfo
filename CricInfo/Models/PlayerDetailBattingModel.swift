//
//  PlayerDetailBattingModel.swift
//  CricInfo
//
//  Created by bjit on 20/2/23.
//

import Foundation

class PlayerDetailBattingModel{

    let matches: String
    let innings: String
    let runsScored: String
    let notOuts: String
    let highestInningScore: String
    let strikeRate: String
    let ballsFaced: String
    let average: String
    let fourX: String
    let sixX: String
    let hundreds: String
    let fifties: String
    let leagueType: String
    let seasonName: String

    init(battingData data: [String: Double], leagueType: String?, seasonName: String?) {
        
        if let sName = seasonName {
            self.seasonName = sName
        } else {
            self.seasonName = Constants.shared.universalNullStr
        }
        
        if let type = leagueType {
            self.leagueType = type
        }
        else
        {
            self.leagueType = Constants.shared.universalNullStr
        }

        if let matches = data["matches"]{

            self.matches = String(matches)
        } else {
            self.matches = Constants.shared.universalNullStr

        }

        if let innings = data["innings"]{
            self.innings = String(innings)

        } else {
            self.innings = Constants.shared.universalNullStr

        }
        
        if let runsScored = data["runs_scored"]{

            self.runsScored = String(runsScored)
        } else {
            self.runsScored = Constants.shared.universalNullStr

        }
        
        
        if let notOuts = data["not_outs"]{

            self.notOuts = String(notOuts)
        } else {
            self.notOuts = Constants.shared.universalNullStr

        }
        
        
        if let highestInningScore = data["highest_inning_score"]{

            self.highestInningScore = String(highestInningScore)
        } else {
            self.highestInningScore = Constants.shared.universalNullStr


        }
        
        
        if let strikeRate = data["strike_rate"]{
            self.strikeRate = String(strikeRate)

        } else {
            self.strikeRate = Constants.shared.universalNullStr

        }
        
        if let ballsFaced = data["balls_faced"]{

            self.ballsFaced = String(ballsFaced)
        } else {
            self.ballsFaced = Constants.shared.universalNullStr

        }
        
        if let average = data["average"]{

            self.average = String(average)
        } else {
            self.average = Constants.shared.universalNullStr

        }
        
        
        if let fourX = data["four_x"]{
            self.fourX = String(fourX)

        } else {
            self.fourX = Constants.shared.universalNullStr

        }
        
        
        if let sixX = data["six_x"]{

            self.sixX = String(sixX)
        } else {
            self.sixX = Constants.shared.universalNullStr

        }
        
        
        if let hundreds = data["hundreds"]{

            self.hundreds = String(hundreds)
        } else {
            self.hundreds = Constants.shared.universalNullStr

        }
        
        
        if let fifties = data["fifties"]{
            self.fifties = String(fifties)

        } else {
            self.fifties = Constants.shared.universalNullStr

        }
    }

}
