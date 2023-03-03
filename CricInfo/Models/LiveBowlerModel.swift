//
//  LiveBowlerModel.swift
//  CricInfo
//
//  Created by bjit on 22/2/23.
//

import Foundation


class LiveBowlerModel{
    
    var nameLabel: String
    
    var oversLabel: String
    
    var medianLabel: String
    
    var runLabel: String
    
    var wicketLabel: String
    
    var rateLabel: String
    
    init(bowlerData data: BowlingLive) {
        
        self.nameLabel = data.bowler.fullname
        self.oversLabel = String(data.overs)
        self.medianLabel = String(data.medians)
        self.runLabel = String(data.runs)
        self.wicketLabel = String(data.wickets)
        self.rateLabel = String(data.rate)
        
        
    }
    
}
