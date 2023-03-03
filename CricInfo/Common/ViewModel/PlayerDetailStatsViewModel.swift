//
//  PlayerDetailStatsViewModel.swift
//  CricInfo
//
//  Created by bjit on 17/2/23.
//

import Foundation

class PlayerDetailStatsViewModel{
    
    @Published var statics: PlayerDetailsStatsModel?
    
    var matchesBatting = 0
    var inningsBatting = 0
    var runsScored = 0
    var notout = 0
    var highestInningsScore = 0
    var stikeRate = 0.0
    var fours = 0
    var sixs = 0
    var hundreds = 0
    var fiftes = 0
    
    
    var matchesBowling = 0
    var inningsBowling = 0
    var overs = 0.0
    var medain = 0
    var runsGive = 0
    var ecoRate = 0.0
    var wide = 0
    var noball = 0
    var wickets = 0
    var rate = 0.0
    
    var battingCnt = 0
    var bowlingCnt = 0
    func getStaticsData(career data: [Career?], type: String) {
         matchesBatting = 0
         inningsBatting = 0
         runsScored = 0
         notout = 0
         highestInningsScore = 0
         stikeRate = 0.0
         fours = 0
         sixs = 0
         hundreds = 0
         fiftes = 0
        
        
         matchesBowling = 0
         inningsBowling = 0
         overs = 0.0
         medain = 0
         runsGive = 0
         ecoRate = 0.0
         wide = 0
         noball = 0
         wickets = 0
         rate = 0.0
        
         battingCnt = 0
         bowlingCnt = 0

        for career in data{
            
            if let batting = career?.batting{
                if career?.type == type{
                    matchesBatting += Int(batting["matches"] ?? 0)
                    inningsBatting += Int(batting["innings"] ?? 0)
                    runsScored += Int(batting["runs_scored"] ?? 0)
                    notout += Int(batting["not_outs"] ?? 0)
                    highestInningsScore = Int(max(Double(highestInningsScore), batting["highest_inning_score"] ?? 0))
                    stikeRate += batting["strike_rate"] ?? 0.0
                    hundreds += Int(batting["hundreds"] ?? 0)
                    fiftes += Int(batting["fifties"] ?? 0)
                    fours += Int(batting["four_x"] ?? 0)
                    sixs += Int(batting["six_x"] ?? 0)
                    
                    battingCnt += 1
                }
            }
            
            
            if let bowling = career?.bowling
            {
                if career?.type == type{
                    
                    matchesBowling += Int(bowling["matches"] ?? 0)
                    inningsBowling += Int(bowling["innings"] ?? 0)
                    overs += bowling["overs"] ?? 0.0
                    medain += Int(bowling["medians"] ?? 0)
                    ecoRate += bowling["econ_rate"] ?? 0.0
                    runsGive += Int(bowling["runs"] ?? 0)
                    wickets += Int(bowling["wickets"] ?? 0)
                    wide += Int(bowling["wide"] ?? 0)
                    noball += Int(bowling["noball"] ?? 0)
                    rate += bowling["rate"] ?? 0.0

                    bowlingCnt += 1
                }
            }
        }
        
        self.stikeRate /= Double(battingCnt)
        self.ecoRate /= Double(bowlingCnt)
        self.rate /= Double(bowlingCnt)
        
        statics = PlayerDetailsStatsModel(
            matchesBatting: self.matchesBatting,
            runsScored: self.runsScored,
            hundreds: self.hundreds,
            fiftes: self.fiftes,
            highestInningsScore: self.highestInningsScore,
            notOut: self.notout,
            strikeRate: self.stikeRate,
            totalFour: self.fours,
            totalSixes: self.sixs,
            innings: self.inningsBatting,
            matchesBowling: self.matchesBowling ,
            overs: self.overs,
            median: self.medain,
            runsGive: self.runsGive,
            ecoRate: self.ecoRate,
            wide: self.wide,
            noBall: self.noball,
            wickets: self.wickets,
            rate: self.rate)
        
        
    }
    
}
