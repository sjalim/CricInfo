//
//  LiveBattingModel.swift
//  CricInfo
//
//  Created by bjit on 22/2/23.
//

import Foundation


class LiveBattingModel{
    var nameLabel: String
    
    var runLabel: String
    
    var fourLabel: String
    
    var bowlLabel: String
    
   var sixLabel: String
    
    var rateLabel: String
    var activeStatus: Bool
    var outStatus: String
    
    
    init(batsmanData data: BattingLive) {
        
        
        self.nameLabel = data.batsman.fullname
        self.runLabel = String(data.score)
        self.fourLabel = String(data.fourX)
        self.bowlLabel = String(data.ball)
        self.sixLabel = String(data.sixX)
        self.rateLabel = String(data.rate)
        self.activeStatus = data.active
        self.outStatus = data.result.name
        
    }
    
}
