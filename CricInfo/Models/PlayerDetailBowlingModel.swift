//
//  PlayerDetailBowlingModel.swift
//  CricInfo
//
//  Created by bjit on 20/2/23.
//

import Foundation


class PlayerDetailBowlingModel{
    
    
    let matches: String
    let overs: String
    let innings: String
    let average: String
    let econRate: String
    let medians: String
    let runs: String
    let wickets: String
    let wide: String
    let noball: String
    let strikeRate: String
    let rate: String
    let leagueType: String
    let seasonName: String
    
    init(bowlingData data: [String:Double], leagueType: String?, seasonName: String?) {
        
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
        
        
        
        if let matches = data["matches"] {
            self.matches = String(matches)
            
        } else {
            self.matches = Constants.shared.universalNullStr

        }
        
        if let overs = data["overs"] {
            
            self.overs = String(overs)
        } else {
            self.overs = Constants.shared.universalNullStr

        }
        
        
        if let innings = data["innings"] {
            self.innings = String(innings)
            
        } else {
            self.innings = Constants.shared.universalNullStr

        }
        
        if let average = data["average"] {
            self.average = String(average)
            
        } else {
            self.average = Constants.shared.universalNullStr

        }
        
        if let econRate = data["econ_rate"] {
            
            self.econRate = String(econRate)
        } else {
            self.econRate = Constants.shared.universalNullStr

        }
        
        if let medians = data["medians"] {
            self.medians = String(medians)
            
        } else {
            self.medians = Constants.shared.universalNullStr

        }
        
        
        if let runs = data["runs"] {
            self.runs = String(runs)
            
        } else {
            self.runs = Constants.shared.universalNullStr

        }
        
        
        if let wickets = data["wickets"] {
            self.wickets = String(wickets)
            
        } else {
            self.wickets = Constants.shared.universalNullStr

        }
        if let wide = data["wide"] {
            self.wide = String(wide)
            
        } else {
            self.wide = Constants.shared.universalNullStr

        }
        
        if let noball = data["noball"] {
            self.noball = String(noball)
            
        } else {
            self.noball = Constants.shared.universalNullStr

        }
        
        if let strikeRate = data["strike_rate"] {
            self.strikeRate = String(strikeRate)
            
        } else {
            self.strikeRate = Constants.shared.universalNullStr

        }
        
        if let rate = data["rate"] {
            self.rate = String(rate)
            
        } else {
            self.rate = Constants.shared.universalNullStr

        }
        
        
    }
    
}
