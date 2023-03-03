//
//  MatchDetailViewModel.swift
//  CricInfo
//
//  Created by bjit on 14/2/23.
//

import Foundation


class MatchDetailViewModel{
    
    
    @Published var matchId: Int?
    @Published var matchStatus: CricketAPIFiterStatus?
    @Published var matchData: DataClassMatchById?
    
    
    func setMatchId(id: Int, status: CricketAPIFiterStatus){
        
        matchId = id
        matchStatus = status
        
    }
    
    
    func getResponseSelectedMatchData(){
//        print("match Id:", matchId)
//        print("match Status:", matchStatus)
//

        
        switch matchStatus{
            
        case .Running:
            break
        case .Finished:
            let parameters = [
                "include": "visitorteam,localteam,season,league,runs,lineup,bowling,batting,runs,venue,batting.result,batting.batsman,bowling.bowler",
                "filter[status]":"Finished"
            ]
            
            NetworkHelper.shared.fetchData(with: .fixtures, parameters: parameters, pathId: matchId ?? -1){ (result: Result<MatchByIDAPIResponseModel, APIError>) in
                switch result {
                case .success(let response):
                    debugPrint("Recent matches data fetched")
                    self.matchData = response.data
//                    print("getResponseSelectedMatchData:")
//                    dump(response.data)
                case .failure(let error):
                    debugPrint("Error: in getResponseSelectedMatchData() \(error.localizedDescription)")
                }
             }
            break
        case .NS:
            let parameters = [
                "include": "visitorteam,localteam,season,league,runs,lineup,bowling,batting,runs,venue,batting.result,batting.batsman,bowling.bowler",
                "filter[status]":"NS"
            ]
            
            NetworkHelper.shared.fetchData(with: .fixtures, parameters: parameters, pathId: matchId ?? -1){ (result: Result<MatchByIDAPIResponseModel, APIError>) in
                switch result {
                case .success(let response):
                    debugPrint("Recent matches data fetched")
                    self.matchData = response.data
//                    print("getResponseSelectedMatchData:")
//                    dump(response.data)
                case .failure(let error):
                    debugPrint("Error: in getResponseSelectedMatchData() \(error.localizedDescription)")
                }
             }
            break
        default:
            break
            
        }
        
        
    }
    
    
}
