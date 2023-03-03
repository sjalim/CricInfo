//
//  InfoDetailViewController.swift
//  CricInfo
//
//  Created by bjit on 15/2/23.
//

import UIKit
import Combine

class InfoDetailViewController: UIViewController {
    
    @IBOutlet weak var matchContainerView: UIView!
    
    @IBOutlet weak var venueContainerView: UIView!
    
    @IBOutlet weak var roundLeagueSeasonLabel: UILabel!
    
    @IBOutlet weak var matchDateLabel: UILabel!
    
    @IBOutlet weak var tossLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var umpireLabel: UILabel!
    
    @IBOutlet weak var thirdUmpireLabel: UILabel!
    
    @IBOutlet weak var refereeLabel: UILabel!
    
    @IBOutlet weak var stadiumNameLabel: UILabel!
    
    @IBOutlet weak var venueCityLabel: UILabel!
    
    @IBOutlet weak var venueCapacityLabel: UILabel!
    
    @IBOutlet weak var venueFloodLightLabel: UILabel!
    
    
    @IBOutlet weak var stadiumImageView: UIImageView!
    
    
    private var cancellables: Set<AnyCancellable> = []
    
    private var cancellablesInfo: Set<AnyCancellable> = []
    
    var viewModel = InfoDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupBinder()
    }
    
    func setupBinder(){
        
        MatchDetailViewController.viewModel.$matchId.sink{ _ in
            
            //        print("Match Id from info:", id)
            
            
        }.store(in: &cancellables)
        
        MatchDetailViewController.viewModel.$matchStatus.sink{ _ in
            
            //            print("status from info:", status)
            
        }.store(in: &cancellables)
        
        MatchDetailViewController.viewModel.$matchData.sink{ matchData in
            
            guard let data = matchData else {
                print("Error: Match data unable to fetch")
                return
            }
            
//            print("Match data fetched from info:", data)
            
            let matchDataModel = MatchInfoModel(matchData: data)
            
            DispatchQueue.main.async {
                
                
                self.viewModel.getResponseFirstUmipreData(byId: matchDataModel.firstUmpireID)
                self.viewModel.getResponseSecondUmipreData(byId: matchDataModel.secondUmpireID)
                
                self.viewModel.getResponseTvUmipreData(byId: matchDataModel.tvUmpireID)
                
                self.viewModel.getResponseRefereefData(byId: matchDataModel.refereeID)
                
                
                self.roundLeagueSeasonLabel.text = matchDataModel.round + ", " + matchDataModel.leagueName + ", " + matchDataModel.seasonName
                
                self.matchDateLabel.text = matchDataModel.startingAt
                
                if matchDataModel.tossWonTeamID == matchDataModel.localteamID {
                    self.tossLabel.text = matchDataModel.localTeamName + " won the toss and opt to " + matchDataModel.elected
                } else {
                    self.tossLabel.text = matchDataModel.visitorTeamName + " won the toss and opt to " + matchDataModel.elected
                }
                
                self.timeLabel.text = matchDataModel.time
                self.stadiumNameLabel.text = matchDataModel.venueName
                self.venueCityLabel.text = matchDataModel.venueCity
                self.venueCapacityLabel.text = matchDataModel.venueCapacity
                self.venueFloodLightLabel.text = matchDataModel.venueFloodLight
                
                self.stadiumImageView.sd_setImage(with: URL(string: data.venue?.imagePath ?? ""), placeholderImage: UIImage(named: "stadiumPic"))
            }
            
            print("Officials data successfully called ")
        }.store(in: &cancellables)
        
        viewModel.$referee.sink{ officalsData in
            
            guard let data = officalsData else {
                print("firstUmipre data unable to fetch")
                return
            }
            DispatchQueue.main.async {
                if let name = data.fullname{
                    self.refereeLabel.text! = name

                }
            }
            
            
        }.store(in: &cancellablesInfo)
        
        viewModel.$firstUmipre.sink{ officalsData in
            
            guard let data = officalsData else {
                print("firstUmipre data unable to fetch")
                return
            }
            
            DispatchQueue.main.async {
                
                if let name = data.fullname {

                    self.umpireLabel.text! += name
                }
//
                
            }
            
        }.store(in: &cancellablesInfo)
        
        viewModel.$secondUmipre.sink{ officalsData in
            
            guard let data = officalsData else {
                print("secondUmipre data unable to fetch")
                return
            }
            DispatchQueue.main.async {
                
                if let name = data.fullname{

                    self.umpireLabel.text! = name  + ", "
                }
                
            }
            
//            print("secondUmipre:", data)
            
            
        }.store(in: &cancellablesInfo)
        
        viewModel.$tvUmipre.sink{ officalsData in
            
            guard let data = officalsData else {
                print("tvUmipre data unable to fetch")
                return
            }
//            print("tvUmipre:", data)
            
            DispatchQueue.main.async {
                
                self.thirdUmpireLabel.text = data.fullname
            }
            
        }.store(in: &cancellablesInfo)
        
    }
    
    func setup(){
        matchContainerView.layer.cornerRadius = 10
        venueContainerView.layer.cornerRadius = 10
        stadiumImageView.layer.cornerRadius = 10
        matchContainerView.dropShadow()
        venueContainerView.dropShadow()
    }
}
