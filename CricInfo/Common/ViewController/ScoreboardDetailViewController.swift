//
//  ScoreboardDetailViewController.swift
//  CricInfo
//
//  Created by bjit on 15/2/23.
//

import UIKit
import Combine

class ScoreboardDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var cancellables: Set<AnyCancellable> = []
    
    var selectedTeam = 0
    
    var scoreCard: ScoreCardModel?
    
    
    @IBOutlet weak var matchNotStartUIView: UIView!
    
    var battingDataListTeam1: [BattingModel] = []{
        didSet{
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
        }
    }
    
    var battingDataListTeam2: [BattingModel] = []{
        didSet{
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
        }
    }
    
    
    var bowlingDataListTeam1: [BowlingModel] = []{
        didSet{
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
        }
    }
    
    var bowlingDataListTeam2: [BowlingModel] = []{
        didSet{
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupBinders()
        
    }
    
    func setupBinders(){
        
        MatchDetailViewController.viewModel.$matchId.sink{ id in
            
            //          print("Match Id from scorecard:", id)
            //            DispatchQueue.main.async {
            //
            //                self.collectionView.reloadData()
            //            }
            
        }.store(in: &cancellables)
        
        MatchDetailViewController.viewModel.$matchStatus.sink{ status in
            
            guard let currentStatus = status else {
                return
            }
            
            switch currentStatus {
            case .Finished:
                self.matchNotStartUIView.isHidden = true
                break
                
            case .NS:
                self.matchNotStartUIView.isHidden = false

                break
            case .Running:
                break
            default:
                break
                
            
            }
            
        }.store(in: &cancellables)
        
        
        
        
        MatchDetailViewController.viewModel.$matchData.sink{ matchData in
            
            //            print("Match data fetched from scoreboard:", matchData)
            guard let data = matchData else {
                print("Error: Match data unable to fetch from ScoreboardDetailViewController")
                return
            }
            
            let scoreCard = ScoreCardModel(matchData: data)
            
            self.scoreCard = scoreCard
            
            
            for batting in data.batting{
                
                if let batting = batting
                {
                    let battingModel = BattingModel(matchData: batting)
                    
                    if battingModel.teamID == data.localteamID{
                        self.battingDataListTeam1.append(battingModel)
                    }
                    else
                    {
                        self.battingDataListTeam2.append(battingModel)
                    }
                }
            }
            
            
            for bowling in data.bowling{
                if let bowling = bowling
                {
                    let bowlingModel = BowlingModel(matchData: bowling)
                    
                    if bowlingModel.teamID == data.localteamID{
                        self.bowlingDataListTeam1.append(bowlingModel)
                    }
                    else
                    {
                        self.bowlingDataListTeam2.append(bowlingModel)
                    }
                }
            }
            //            print("batting data count:", self.battingDataListTeam1.count, self.battingDataListTeam2.count)
            
            //            DispatchQueue.main.async {
            //
            //            }
        }.store(in: &cancellables)
        
    }
    
    func setup(){
        
        matchNotStartUIView.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nibScoreCard = UINib(nibName: Constants.shared.ScoreCardTableViewCell, bundle: nil)
        tableView.register(nibScoreCard, forCellReuseIdentifier: Constants.shared.ScoreCardTableViewCell)
        
        let nibBattingSummery = UINib(nibName: Constants.shared.BattingSummeryTableViewCell, bundle: nil)
        tableView.register(nibBattingSummery, forCellReuseIdentifier: Constants.shared.BattingSummeryTableViewCell)
        
        let nibBowlingSummery = UINib(nibName: Constants.shared.BowlingSummeryTableViewCell, bundle: nil)
        tableView.register(nibBowlingSummery, forCellReuseIdentifier: Constants.shared.BowlingSummeryTableViewCell)
        
        let nibScoreCardHeader = UINib(nibName: Constants.shared.ScoreCardTableHeaderView, bundle: nil)
        tableView.register(nibScoreCardHeader, forHeaderFooterViewReuseIdentifier: Constants.shared.ScoreCardTableHeaderView)
        
        let nibBattingSummeryHeader = UINib(nibName: Constants.shared.BattingSummeryTableHeaderView, bundle: nil)
        tableView.register(nibBattingSummeryHeader, forHeaderFooterViewReuseIdentifier: Constants.shared.BattingSummeryTableHeaderView)
        
        
        let nibBowlingSummeryHeader = UINib(nibName: Constants.shared.BowlingSummeryTableHeaderView, bundle: nil)
        tableView.register(nibBowlingSummeryHeader, forHeaderFooterViewReuseIdentifier: Constants.shared.BowlingSummeryTableHeaderView)
    }
}

extension ScoreboardDetailViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section{
            
        case 0:
            
            switch indexPath.row{
            case 0:
                selectedTeam = 0
                break
            case 1:
                selectedTeam = 1
                break
            default:
                break
            }
            
            break
        case 1:
            selectedTeam = 0
            break
        default:
            selectedTeam = 0
            break
        }
        tableView.reloadData()
    }
    
}

extension ScoreboardDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section{
            
        case 0:
            return 2
        case 1:
            
            switch selectedTeam{
            case 0:
                return battingDataListTeam1.count
            case 1:
                return battingDataListTeam2.count
            default:
                return 0
                
            }
            
            
        case 2:
            
            switch selectedTeam{
            case 0:
                return bowlingDataListTeam1.count
                
            case 1:
                return bowlingDataListTeam2.count
            default:
                return 0
            }
            
        default:
            return 0
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        switch MatchDetailViewController.viewModel.matchStatus{
        
        case .Finished:

            return 3
            
        case .NS:
            return 1
            
        case .Running:
            return 0
        default:
            return 0
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.section{
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.shared.ScoreCardTableViewCell, for: indexPath) as! ScoreCardTableViewCell
            
            switch indexPath.row{

            case 0:
                cell.teamNameLabel.text = scoreCard?.localTeamName
                cell.scoreCardLabel.text = String(scoreCard?.localTeamScore ?? 0) + "-" + String(scoreCard?.localTeamWickets ?? 0)
                cell.oversLabel.text = "(\( scoreCard?.localTeamOvers ?? 0) )"
                break
            case 1:
                cell.teamNameLabel.text = scoreCard?.visitorTeamName
                cell.scoreCardLabel.text = String(scoreCard?.visitorTeamScore ?? 0) + "-" + String(scoreCard?.visitorTeamWickets ?? 0)
                cell.oversLabel.text = "(\(scoreCard?.visitorTeamOvers ?? 0))"
                break
            default:
                break
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.shared.BattingSummeryTableViewCell, for: indexPath) as! BattingSummeryTableViewCell
            
            switch selectedTeam{
            case 0:
                
                if battingDataListTeam1.count > 0 {
                    
                
                cell.nameLabel.text = battingDataListTeam1[indexPath.row].batsmanFullname
                cell.runLabel.text = String( battingDataListTeam1[indexPath.row].score)
                cell.fourLabel.text = String(  battingDataListTeam1[indexPath.row].fourX)
                cell.sixLabel.text = String( battingDataListTeam1[indexPath.row].sixX)
                cell.rateLabel.text = String( battingDataListTeam1[indexPath.row].rate)
                print(battingDataListTeam1[indexPath.row].rate)
                cell.bowlLabel.text = String(battingDataListTeam1[indexPath.row].ball)
                cell.OutStatusLabel.text = battingDataListTeam1[indexPath.row].resultName
            
                }
                break
            case 1:
                
                if battingDataListTeam2.count > 0 {
                    
                
                cell.nameLabel.text = battingDataListTeam2[indexPath.row].batsmanFullname
                cell.runLabel.text = String( battingDataListTeam2[indexPath.row].score)
                cell.fourLabel.text = String(  battingDataListTeam2[indexPath.row].fourX)
                cell.sixLabel.text = String( battingDataListTeam2[indexPath.row].sixX)
                cell.rateLabel.text = String( battingDataListTeam2[indexPath.row].rate)
                print(battingDataListTeam2[indexPath.row].rate)
                cell.bowlLabel.text = String(battingDataListTeam2[indexPath.row].ball)
                cell.OutStatusLabel.text = battingDataListTeam2[indexPath.row].resultName
                }
                
                break
            default:
                break
                
            }
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.shared.BowlingSummeryTableViewCell, for: indexPath) as! BowlingSummeryTableViewCell
            
                
            
            switch selectedTeam{
                
            case 0:
                
                if bowlingDataListTeam1.count > 0 {
                    
                cell.nameLabel.text = bowlingDataListTeam1[indexPath.row].bowlerFullName
                cell.oversLabel.text = String(bowlingDataListTeam1[indexPath.row].overs)
                cell.medianLabel.text = String(bowlingDataListTeam1[indexPath.row].medians)
                cell.runLabel.text = String(bowlingDataListTeam1[indexPath.row].runs)
                cell.wicketLabel.text = String(bowlingDataListTeam1[indexPath.row].wickets)
                cell.rateLabel.text = String(bowlingDataListTeam1[indexPath.row].rate)
                break
                
            }
            case 1:
                
                if bowlingDataListTeam2.count > 0 {
                    
                
                cell.nameLabel.text = bowlingDataListTeam2[indexPath.row].bowlerFullName
                cell.oversLabel.text = String(bowlingDataListTeam2[indexPath.row].overs)
                cell.medianLabel.text = String(bowlingDataListTeam2[indexPath.row].medians)
                cell.runLabel.text = String(bowlingDataListTeam1[indexPath.row].runs)
                cell.wicketLabel.text = String(bowlingDataListTeam2[indexPath.row].wickets)
                cell.rateLabel.text = String(bowlingDataListTeam2[indexPath.row].rate)
                break
                }
            default:
                
                break
            }
            
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
            
        case 0:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.shared.ScoreCardTableHeaderView) as! ScoreCardTableHeaderView
            header.name.text = "Score"
            
            return header
            
        case 1:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.shared.BattingSummeryTableHeaderView) as! BattingSummeryTableHeaderView
            return header
        case 2:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.shared.BowlingSummeryTableHeaderView) as! BowlingSummeryTableHeaderView
            
            return header
        default:
            return UIView()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
