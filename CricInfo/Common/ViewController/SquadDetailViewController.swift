//
//  SquadDetailViewController.swift
//  CricInfo
//
//  Created by bjit on 15/2/23.
//

import UIKit
import Combine

class SquadDetailViewController: UIViewController {
    
    @IBOutlet weak var matchNotStartUIView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    private var cancellables: Set<AnyCancellable> = []
    
    var lineupList1: [SquadModel] = []{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var lineupList2: [SquadModel] = []{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var localTeamName: String = ""{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var visitorTeamName: String = ""{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupBinder()
    }
    func setupBinder(){
        
        MatchDetailViewController.viewModel.$matchId.sink{ id in
            
//            print("Match Id:", id)
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

            guard let data = matchData else{
                print("Match data fetch unable from squadDetail")
                return
            }
        
            self.localTeamName = data.localteam?.name ?? ""
            self.visitorTeamName = data.visitorteam?.name ?? ""
            
            for lineup in data.lineup{
                
                if let lineupModel = lineup{
                    
                    
                    if lineupModel.lineup?.teamID == data.localteamID
                    {
                        
                        self.lineupList1.append(SquadModel(matchData: lineupModel))
                    }
                    else
                    {
                        self.lineupList2.append(SquadModel(matchData: lineupModel))

                    }
                }
            }
            
        }.store(in: &cancellables)
        
    }
    
    func setup(){
        tableView.delegate = self
        tableView.dataSource = self
        
        
        matchNotStartUIView.isHidden = true
        let nibSquadCell = UINib(nibName: Constants.shared.SquadTableViewCell, bundle: nil)
        tableView.register(nibSquadCell, forCellReuseIdentifier: Constants.shared.SquadTableViewCell)
        
        let nibSquadHeader = UINib(nibName: Constants.shared.SquadTableHeaderView, bundle: nil)
        tableView.register(nibSquadHeader, forHeaderFooterViewReuseIdentifier: Constants.shared.SquadTableHeaderView)
    }
    
    func gotToPlayerDetailPage(VC: UIViewController,  playerId id: Int) {
        let detailInfoVC = UIStoryboard(
            name: "Home",
            bundle: nil
            // swiftlint:disable force_cast
        ).instantiateViewController(withIdentifier: Constants.shared.PlayerDetailViewController) as! PlayerDetailViewController
        detailInfoVC.loadViewIfNeeded()
        
        PlayerDetailViewController.viewModel.setPlayerId(byId: id)
        PlayerDetailViewController.viewModel.getResponsePlayerData()
        
        VC.navigationController?.pushViewController(detailInfoVC, animated: true)
    }
    

}


extension SquadDetailViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.section == 0{
            
            self.gotToPlayerDetailPage(VC: self, playerId: lineupList1[indexPath.row].playerId)
        } else {
            
            self.gotToPlayerDetailPage(VC: self, playerId: lineupList2[indexPath.row].playerId)
        }
        
        
    }
    
}

extension SquadDetailViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return lineupList1.count
        case 1:
            return lineupList2.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.shared.SquadTableViewCell, for: indexPath) as! SquadTableViewCell
        switch indexPath.section{
            
        case 0:
            
            
            cell.playerImageView.sd_setImage(with: URL(string: lineupList1[indexPath.row].imagePath), placeholderImage: UIImage(systemName: "person"))
            cell.playerNameLabel.text = lineupList1[indexPath.row].fullName
            cell.playerPositionLabel.text = lineupList1[indexPath.row].positionName
            break
        case 1:
            cell.playerImageView.sd_setImage(with: URL(string: lineupList2[indexPath.row].imagePath), placeholderImage: UIImage(systemName: "person"))
            cell.playerNameLabel.text = lineupList2[indexPath.row].fullName
            cell.playerPositionLabel.text = lineupList2[indexPath.row].positionName
            break
        default:
            break
        
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.shared.SquadTableHeaderView) as! SquadTableHeaderView
        
        switch section{
            
        case 0:
            header.teamName.text = localTeamName
            break
            
        case 1:
            header.teamName.text = visitorTeamName
            break
            
        default:
           break
            
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
}
