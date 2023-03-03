//
//  HomeViewModel.swift
//  CricInfo
//
//  Created by bjit on 9/2/23.
//

import Foundation
import UIKit


class HomeViewModel{
    
    @Published var recentMatchesDataList: [DatumRecetMatches]?
    @Published var upcomingMatchesDataList: [DatumUpcomingMatches]?
    @Published var liveMatchesData: [DatumLive]?
    @Published var playerDataList: [DatumPlayer]?
//    @Published var isLoading: Bool = false

    func getResponseLiveMatches(){
        let parameters = [
            "include": "visitorteam,localteam,runs,league,stage,season,venue,tosswon,batting.result,batting.batsman,bowling.bowler,lineup"
        ]
        
//        isLoading = true
        
        NetworkHelper.shared.fetchData(with: .livescores, parameters: parameters, pathId: -1){ (result: Result<LiveAPIResponseModel, APIError>) in
            switch result {
            case .success(let response):
                debugPrint("Live matches data fetched")
                var tempLiveMatchesData: [DatumLive] = []
                print("Live match data count:", response.data.count)
                for tempData in response.data{
                    if tempData.type == "T10" || tempData.type == "T20" || tempData.type == "ODI"  || tempData.type == "T20I" {
                        tempLiveMatchesData.append(tempData)

                    }
                }
                self.liveMatchesData = tempLiveMatchesData
                
//                self.liveMatchesData = response.data
//                self.isLoading = false

//                dump(response.data)
            case .failure(let error):
                debugPrint("Error: in getResponseLiveMatches() \(error.localizedDescription)")
            }
        }
    }
    
    func getPlayerDataToCoreData(){
        
        let parameters = [
            "fields[players]" : "fullname,image_path,id"
        ]
        
        if CoreDataManager.shared.isCoreDataEmpty() == true {
            NetworkHelper.shared.fetchData(with: .players, parameters: parameters, pathId: -1){ (result: Result<PlayerAPIResponseModel, APIError>) in
                switch result {
                case .success(let response):
                    debugPrint("Players data fetched")
                    self.playerDataList = response.data
                case .failure(let error):
                    debugPrint("Error: in getResponseRecentMatches() \(error.localizedDescription)")
                }
            }
        } else {
            print("Core Data is not empty")
        }
    }
    
    func getResponseRecentMatches(){
        
        let parameters = [
            "fields[fixtures]":"type,starting_at,note,winner_team_id",
            "filter[status]": "Finished",
            "fields[teams]": "code,image_path,name",
            "include": "runs,visitorteam,localteam,season,league,batting.result",
            "sort": "-starting_at",
            
        ]
        
        NetworkHelper.shared.fetchData(with: .fixtures, parameters: parameters, pathId: -1){ (result: Result<RecentMatchesAPIResponseModel, APIError>) in
            switch result {
            case .success(let response):
                debugPrint("Recent matches data fetched")
                self.recentMatchesDataList = response.data
            case .failure(let error):
                debugPrint("Error: in getResponseRecentMatches() \(error.localizedDescription)")
            }
        }
    }
    
    func getResponseUpcomingMatches(){
        let parameters = [
            "fields[fixtures]":"type,starting_at,note,winner_team_id,league_id",
            "filter[status]": "NS",
            "fields[teams]": "code,image_path,name",
            "include": "visitorteam,localteam,season,league",
            "sort": "starting_at"
        ]
        
        NetworkHelper.shared.fetchData(with: .fixtures, parameters: parameters,pathId: -1){ (result: Result<UpcomingMatchesAPIResponseModel, APIError>) in
            switch result {
            case .success(let response):
                debugPrint("Upcoming matches data fetched")
                
                let dateFormatter = DateFormatter()
                
                var tempUpcomingMatches: [DatumUpcomingMatches] = []
                for teamUpcoming in response.data{
                    
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
                    dateFormatter.timeZone = TimeZone(identifier: "UTC")
                    guard let upcomingMatchDate = dateFormatter.date(from: teamUpcoming.startingAt) else {
                        return
                    }
                    
                    var timerInterval =  upcomingMatchDate - Utilities.shared.getCurrentTime()
                    
                    if timerInterval > 0 {
                        tempUpcomingMatches.append(teamUpcoming)
                    }
                }
                self.upcomingMatchesDataList = tempUpcomingMatches
                
            case .failure(let error):
                debugPrint("Error: in getResponseUpcomingMatches() \(error.localizedDescription)")
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
        
        switch status{
            
        case .Finished:
            MatchDetailViewController.viewModel.setMatchId(id: recentMatchesDataList?[indexPath.row].id ?? -1, status: .Finished )
            break
        case .NS:
            MatchDetailViewController.viewModel.setMatchId(id: upcomingMatchesDataList?[indexPath.row].id ?? -1, status: .NS )
            break
        case .Running:
            MatchDetailViewController.viewModel.setMatchId(id: upcomingMatchesDataList?[indexPath.row].id ?? -1, status: .Running )
            break
        }
      
        MatchDetailViewController.viewModel.getResponseSelectedMatchData()
        
        VC.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func getUpcomingMatchDataForNotification(upcomingMatchList: [DatumUpcomingMatches]?) -> [DatumUpcomingMatches]{
      
        guard let data = upcomingMatchList else{
            print("Unable to get data for notification")
            return []
        }
        
        var tempData: [DatumUpcomingMatches] = []
        
        let currentDate = Date()
        let futureDate = Calendar.current.date(byAdding: .day, value: 7, to: currentDate)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"

        let tempAfter7Days = dateFormatter.string(from: futureDate)
        
        guard let dateAfter7Days = dateFormatter.date(from: tempAfter7Days) else {
            return []
        }
        
        
        for matchData in data {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            guard let upcomingMatchDate = dateFormatter.date(from: matchData.startingAt) else {
                return []
            }
            
            if dateAfter7Days > upcomingMatchDate {
                tempData.append(matchData)
            }
        }
        
        return tempData
    }
    
    func createNotifications(upcomingMatchData: [DatumUpcomingMatches]?){
        
        let notifiableMatches = getUpcomingMatchDataForNotification(upcomingMatchList: upcomingMatchData)
        
//        print("notification:", notifiableMatches.count)
        
        for data in notifiableMatches {
            
            let content = UNMutableNotificationContent()
            content.title = "\(data.localteam.code) vs \(data.visitorteam.code)"
            let upcomingMatchDate = "\(Utilities.shared.getFormattedDate(with: data.startingAt))" + "\(Utilities.shared.getFormattedTime(with: data.startingAt))"
            content.body = "\(upcomingMatchDate)"
            content.sound = .default
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
            dateFormatter.timeZone = TimeZone(identifier: "UTC")
            guard let upcomingMatchDate = dateFormatter.date(from: data.startingAt) else {
                
                return
            }
            
            let timerInterval =  upcomingMatchDate - Utilities.shared.getCurrentTime()
            
            // Configure the trigger for a 10-second delay
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timerInterval - 1000, repeats: false)
            
            // Create the request with a unique identifier
            let request = UNNotificationRequest(identifier: "\(data.id)", content: content, trigger: trigger)
            
            // Add the request to the notification center
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                } else {
                    print("Notification scheduled.")
                }
            }
        }
        
    }
}
