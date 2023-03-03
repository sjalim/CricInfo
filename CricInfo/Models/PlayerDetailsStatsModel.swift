//
//  PlayerDetailsStatsModel.swift
//  CricInfo
//
//  Created by bjit on 23/2/23.
//

import Foundation


class PlayerDetailsStatsModel{
    
    let matchesBatting: Int
    let runsScored: Int
    let hundreds: Int
    let fiftes: Int
    let highestInningsScore: Int
    let notOut: Int
    let strikeRate: Double
    let totalFour: Int
    let totalSixes: Int
    let innings: Int
    
    let matchesBowling: Int
    let overs: Double
    let median: Int
    let runsGive: Int
    let ecoRate: Double
    let wide: Int
    let noBall: Int
    let wickets: Int
    let rate: Double
    
    init(matchesBatting: Int, runsScored: Int, hundreds: Int, fiftes: Int, highestInningsScore: Int, notOut: Int, strikeRate: Double, totalFour: Int, totalSixes: Int, innings: Int, matchesBowling: Int, overs: Double, median: Int, runsGive: Int, ecoRate: Double, wide: Int, noBall: Int, wickets: Int, rate: Double) {
        self.matchesBatting = matchesBatting
        self.runsScored = runsScored
        self.hundreds = hundreds
        self.fiftes = fiftes
        self.highestInningsScore = highestInningsScore
        self.notOut = notOut
        self.strikeRate = strikeRate
        self.totalFour = totalFour
        self.totalSixes = totalSixes
        self.innings = innings
        self.matchesBowling = matchesBowling
        self.overs = overs
        self.median = median
        self.runsGive = runsGive
        self.ecoRate = ecoRate
        self.wide = wide
        self.noBall = noBall
        self.wickets = wickets
        self.rate = rate
    }
    
    
}
