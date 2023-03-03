//
//  InfoDetailViewController.swift
//  CricInfo
//
//  Created by bjit on 15/2/23.
//

import UIKit

class InfoDetailViewModel {
    
    
    @Published var firstUmipre: DataClassOfficialsById?
    
    @Published var secondUmipre: DataClassOfficialsById?
    
    @Published var tvUmipre: DataClassOfficialsById?
    
    @Published var referee: DataClassOfficialsById?
    
    var ofData: [DataClassOfficialsById] = []
    
    func getResponseFirstUmipreData(byId id: Int){
        
        print("Official ID:", id)
        
        if id != Constants.shared.universalNullInt{
            
            NetworkHelper.shared.fetchData(with:.officials, pathId: id){ (result: Result<OfficialsByIDAPIResponseModelSwift, APIError>) in
                switch result {
                case .success(let response):
                    debugPrint("official data fetched")
                    self.firstUmipre = response.data
                case .failure(let error):
                    debugPrint("Error: in getResponseSelectedMatchData() \(error.localizedDescription)")
                }
            }
        } 
        
    }
    
    
    
    func getResponseTvUmipreData(byId id: Int){
        
        
        if id != Constants.shared.universalNullInt{
            
        NetworkHelper.shared.fetchData(with:.officials, pathId: id){ (result: Result<OfficialsByIDAPIResponseModelSwift, APIError>) in
            switch result {
            case .success(let response):
                debugPrint("official data fetched")
                self.tvUmipre = response.data
            case .failure(let error):
                debugPrint("Error: in getResponseSelectedMatchData() \(error.localizedDescription)")
            }
        }
        }
        
    }
    
    
    func getResponseSecondUmipreData(byId id: Int){
        
        if id != Constants.shared.universalNullInt {
            
        
        NetworkHelper.shared.fetchData(with:.officials, pathId: id){ (result: Result<OfficialsByIDAPIResponseModelSwift, APIError>) in
            switch result {
            case .success(let response):
                debugPrint("official data fetched")
                self.secondUmipre = response.data
            case .failure(let error):
                debugPrint("Error: in getResponseSelectedMatchData() \(error.localizedDescription)")
            }
        }
        }
        
    }
    func getResponseRefereefData(byId id: Int){
        
        if id != Constants.shared.universalNullInt{
            
        
        NetworkHelper.shared.fetchData(with:.officials, pathId: id){ (result: Result<OfficialsByIDAPIResponseModelSwift, APIError>) in
            switch result {
            case .success(let response):
                debugPrint("official data fetched")
                self.referee = response.data
            case .failure(let error):
                debugPrint("Error: in getResponseSelectedMatchData() \(error.localizedDescription)")
            }
        }
        
        }
    }
    
    func showData(){
        //        print("Show Data officials:", self.ofData)
        
        print("show data officials Size:",self.ofData.count)
    }
    
    
}
