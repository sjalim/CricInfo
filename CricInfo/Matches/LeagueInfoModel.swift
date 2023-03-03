//
//  LeagueInfoModel.swift
//  CricInfo
//
//  Created by bjit on 20/2/23.
//

import Foundation

struct LeagueModel{
    let id: Int
    let name: String
    let imagePath: String
    let code: String
    
    init(id: Int, name: String, imagePath: String, code: String) {
        self.id = id
        self.name = name
        self.imagePath = imagePath
        self.code = code
    }
}

class LeagueInfoModel{
    
   static func getLeagueData() -> [LeagueModel] {
        
        
        var leagues: [LeagueModel] = []
        
       leagues.append(LeagueModel(id: 3, name: "Twenty20 International", imagePath: "https://cdn.sportmonks.com/images/cricket/leagues/3/3.png", code:"T20I"))
       leagues.append(LeagueModel(id: 5, name: "Big Bash League", imagePath: "https://cdn.sportmonks.com/images/cricket/leagues/5/5.png", code:"BBL"))
       leagues.append(LeagueModel(id: 10, name: "CSA T20 Challenge", imagePath:  "https://cdn.sportmonks.com/images/cricket/leagues/10/10.png", code: "T20"))
       
        
        return leagues
        
    }
    
    
    
}
