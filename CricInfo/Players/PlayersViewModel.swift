//
//  PlayersViewModel.swift
//  CricInfo
//
//  Created by bjit on 9/2/23.
//

import Foundation


class PlayersViewModel {
    
    @Published var playerList: [PlayerDataEntity]?
    
    
    func setPlayerList(playerData data: [PlayerDataEntity]){
        
        self.playerList = data
    }
    
}
