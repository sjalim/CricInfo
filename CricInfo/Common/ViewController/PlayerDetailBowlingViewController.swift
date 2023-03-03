//
//  PlayerDetailBowlingViewController.swift
//  CricInfo
//
//  Created by bjit on 17/2/23.
//

import UIKit
import Combine

class PlayerDetailBowlingViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var playerBowlingDataList: [PlayerDetailBowlingModel] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        

        setup()
        setupBinders()
    }
    
    func setupBinders(){
        
        PlayerDetailViewController.viewModel.$playerInfo.sink{ playerInfo in
            
            guard let data = playerInfo else {
                
                print("Player data unable to faced from PlayerDetailViewController")
                return
            }
            
//            print("Player carrer Data:", data.career)
            
            
            for career in data.career{
                if let bowling = career?.bowling {
                    
                    self.playerBowlingDataList.append(PlayerDetailBowlingModel(bowlingData: bowling, leagueType: career?.type, seasonName: career?.season?.name))
                }
            }
        }.store(in: &cancellables)
        
        
    }
    
    func setup(){
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nibPlayerBowling = UINib(nibName: Constants.shared.PlayerDetailBowlingTableViewCell, bundle: nil)
        
        tableView.register(nibPlayerBowling, forCellReuseIdentifier: Constants.shared.PlayerDetailBowlingTableViewCell)
        
        let nibHeader = UINib(nibName: Constants.shared.CommonTableViewHeaderFooterView, bundle: nil)
        
        tableView.register(nibHeader, forHeaderFooterViewReuseIdentifier: Constants.shared.CommonTableViewHeaderFooterView)

    }
}


extension PlayerDetailBowlingViewController: UITableViewDelegate{
    
    
}

extension PlayerDetailBowlingViewController: UITableViewDataSource{
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.playerBowlingDataList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.shared.PlayerDetailBowlingTableViewCell, for: indexPath) as! PlayerDetailBowlingTableViewCell
        
        cell.leagueLabel.text = "League: " + self.playerBowlingDataList[indexPath.row].leagueType 
        
        cell.matchesLabel.text = self.playerBowlingDataList[indexPath.row].matches
        cell.oversLabel.text = self.playerBowlingDataList[indexPath.row].overs
        cell.medainsLabel.text = self.playerBowlingDataList[indexPath.row].medians
        cell.runsLabel.text = self.playerBowlingDataList[indexPath.row].runs
        cell.ecoRateLabel.text = self.playerBowlingDataList[indexPath.row].econRate
        cell.wideLabel.text = self.playerBowlingDataList[indexPath.row].wide
        cell.averageLabel.text = self.playerBowlingDataList[indexPath.row].average
        cell.wideLabel.text = self.playerBowlingDataList[indexPath.row].wide
        cell.noBallLabel.text = self.playerBowlingDataList[indexPath.row].noball
        cell.strinkeRateLabel.text = self.playerBowlingDataList[indexPath.row].strikeRate
        cell.rateLabel.text = self.playerBowlingDataList[indexPath.row].rate
        
        return cell
        
    }
    
    
    
}
