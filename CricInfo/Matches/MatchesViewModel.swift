//
//  MatchesViewModel.swift
//  CricInfo
//
//  Created by bjit on 9/2/23.
//

import Foundation
import UIKit


class MatchesViewModel{
    
    @Published var fixtureMatchesList: [DatumUpcomingMatches]?
    
    func getResponseFixtures(byLeagueId id: Int = Constants.shared.universalNullInt){
    
        
        var params:[String: String] = [:]
        if id == Constants.shared.universalNullInt {
             params = [
                "fields[fixtures]":"type,starting_at,note,winner_team_id,league_id",
                "fields[teams]": "code,image_path,name",
                "filter[status]": "NS",
                "include": "runs,visitorteam,localteam,season,league",
                "sort": "-starting_at"
              
            ]
            
        } else {
            
             params = [
                "fields[fixtures]":"type,starting_at,note,winner_team_id,league_id",
                "filter[league_id]": String(id),
                "fields[teams]": "code,image_path,name",
                "filter[status]": "NS",
                "include": "runs,visitorteam,localteam,season,league",
                "sort": "-starting_at"
             
            ]
        }
        
        NetworkHelper.shared.fetchData(with: .fixtures, parameters:  params, pathId: -1){
            
            (result: Result<UpcomingMatchesAPIResponseModel, APIError>) in
                switch result {
                case .success(let response):
                    debugPrint("Fixture matches data fetched")
                    self.fixtureMatchesList = response.data
                case .failure(let error):
                    debugPrint("Error: in getResponseFixtures() \(error.localizedDescription)")
                }
        }
    }
    
    
    
    func gotToDetailPage(indexPath: IndexPath, VC: UIViewController,  status: CricketAPIFiterStatus) {
        let detailVC = UIStoryboard(
            name: "Home",
            bundle: nil
            // swiftlint:disable force_cast
        ).instantiateViewController(withIdentifier: Constants.shared.MatchDetailViewController) as! MatchDetailViewController
        detailVC.loadViewIfNeeded()
        
//        MatchDetailViewController.viewModel.setMatchId(id: fixtureMatchesList?[indexPath.row].id ?? -1, status: .NS )
   
        
        switch status{

        case .Finished:
            MatchDetailViewController.viewModel.setMatchId(id: fixtureMatchesList?[indexPath.row].id ?? -1, status: .Finished )
            break
        case .NS:
            MatchDetailViewController.viewModel.setMatchId(id: fixtureMatchesList?[indexPath.row].id ?? -1, status: .NS )
            break
        default:
            
            print()
            break
        }
        MatchDetailViewController.viewModel.getResponseSelectedMatchData()
        VC.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func getResponseFixturesByDate(byLeagueId id: Int = Constants.shared.universalNullInt, byDate date: Date){
        var params:[String: String] = [:]
        
        let startTimeOfDay = Utilities.shared.getDayStartTime(at: date)
        let endTimeOfDay = Utilities.shared.getDayEndTime(at: date)

        if id == Constants.shared.universalNullInt {
             params = [
                "fields[fixtures]":"type,starting_at,note,winner_team_id,league_id",
                "fields[teams]": "code,image_path,name",
                "filter[starts_between]" : "\(startTimeOfDay),\(endTimeOfDay)",
                "include": "runs,visitorteam,localteam,season,league",
                "sort": "-starting_at",
               
            ]
            
        } else {
            
             params = [
                "fields[fixtures]":"type,starting_at,note,winner_team_id,league_id",
                "filter[league_id]": String(id),
                "fields[teams]": "code,image_path,name",
                "filter[starts_between]" : "\(startTimeOfDay),\(endTimeOfDay)",
                "include": "runs,visitorteam,localteam,season,league",
                "sort": "-starting_at",
            ]
        }
        
        NetworkHelper.shared.fetchData(with: .fixtures, parameters:  params, pathId: -1){
            
            (result: Result<UpcomingMatchesAPIResponseModel, APIError>) in
                switch result {
                case .success(let response):
                    debugPrint("Fixture matches data fetched")
                    self.fixtureMatchesList = response.data
                case .failure(let error):
                    debugPrint("Error: in getResponseFixtures() \(error.localizedDescription)")
                }
        }
        
    }
    
    
    
}
