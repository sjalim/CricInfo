//
//  RankViewModel.swift
//  CricInfo
//
//  Created by bjit on 9/2/23.
//

import Foundation


class RankViewModel{
    
    @Published var rankList: [TeamRank]?
//    @Published var rankCurrentList: [TeamRank]?
    
    func getResponseRank(gender: String = "men", type: String = "Test"){
        
        let parameters = [
            "filter[gender]": "\(gender)",
            "filter[type]": "\(type)"
        ]
        
        NetworkHelper.shared.fetchData(with: .teamRankings, parameters: parameters, pathId: -1){
            
            (result: Result<RankAPIResponseModel, APIError>) in
                switch result {
                case .success(let response):
                    debugPrint("Rank data fetched")
                    self.rankList = response.data[0].team
                case .failure(let error):
                    debugPrint("Error: in getResponseRank() \(error.localizedDescription)")
                }
        }
    }
    
    
}
