//
//  PlayerDetailBattingViewController.swift
//  CricInfo
//
//  Created by bjit on 17/2/23.
//

import UIKit
import Combine

class PlayerDetailBattingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var playerBattingDataList: [PlayerDetailBattingModel] = []{
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
                
                if let batting = career?.batting{
                    
                    self.playerBattingDataList.append(PlayerDetailBattingModel(battingData: batting, leagueType: career?.type, seasonName: career?.season?.name))
                }
            }
        }.store(in: &cancellables)
    }
    
    func setup() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let nibPlayerBatting = UINib(nibName: Constants.shared.PlayerDetailBattingTableViewCell, bundle: nil)
        
        tableView.register(nibPlayerBatting, forCellReuseIdentifier: Constants.shared.PlayerDetailBattingTableViewCell)
        
        let nibHeader = UINib(nibName: Constants.shared.CommonTableViewHeaderFooterView, bundle: nil)
        
        tableView.register(nibHeader, forHeaderFooterViewReuseIdentifier: Constants.shared.CommonTableViewHeaderFooterView)
        
    }
}


extension PlayerDetailBattingViewController: UITableViewDelegate{
    
    
}

extension PlayerDetailBattingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.playerBattingDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.shared.PlayerDetailBattingTableViewCell, for: indexPath) as! PlayerDetailBattingTableViewCell
        
        cell.leagueLabel.text = "League: " + playerBattingDataList[indexPath.row].leagueType
        cell.matchesCountLabel.text =  playerBattingDataList[indexPath.row].matches
        cell.inningsLabel.text = playerBattingDataList[indexPath.row].innings
        cell.runsLabel.text = playerBattingDataList[indexPath.row].runsScored
        cell.notOutLabel.text = playerBattingDataList[indexPath.row].notOuts
        cell.maxInnScrLabel.text  = playerBattingDataList[indexPath.row].highestInningScore
        cell.strikeRateLabel.text = playerBattingDataList[indexPath.row].strikeRate
        cell.ballsFacedLabel.text = playerBattingDataList[indexPath.row].ballsFaced
        cell.averagesLabel.text = playerBattingDataList[indexPath.row].average
        cell.totalFoursLabel.text = playerBattingDataList[indexPath.row].fourX
        cell.totalSixesLabel.text = playerBattingDataList[indexPath.row].sixX
        cell.hundredsLabel.text = playerBattingDataList[indexPath.row].hundreds
        cell.fiftiesLabel.text = playerBattingDataList[indexPath.row].fifties
        
        return cell
    }
}
