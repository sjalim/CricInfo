//
//  PlayerDetailViewModel.swift
//  CricInfo
//
//  Created by bjit on 17/2/23.
//

import Foundation

class PlayerDetailViewModel {
    @Published var playerInfo: DataClassPlayerById?
    
    @Published var playerId: Int?
    
    func getResponsePlayerData(){
        
        let parameters = [
            "include": "career,country,teams,currentteams,career.season"
        ]
        
        if self.playerId != -1 {
            
            NetworkHelper.shared.fetchData(with: .players, parameters: parameters, pathId: self.playerId ?? -1){ (result: Result<PlayerByIdAPIResponseModel, APIError>) in
                switch result {
                case .success(let response):
                    debugPrint("Player matches data fetched")
                    self.playerInfo = response.data
                case .failure(let error):
                    debugPrint("Error: in getResponseRecentMatches() \(error.localizedDescription)")
                }
            }
        }
        
    }
    
    func setPlayerId(byId id: Int) {
        
        self.playerId = id
        
    }
}
