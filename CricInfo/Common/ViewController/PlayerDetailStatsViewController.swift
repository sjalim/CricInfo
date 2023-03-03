//
//  PlayerDetailStatsViewController.swift
//  CricInfo
//
//  Created by bjit on 17/2/23.
//

import UIKit
import Combine

class PlayerDetailStatsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    private var cancellables: Set<AnyCancellable> = []
    
    var playerBattingDataListT20I: [String:Double] = [:]
    var playerBattingDataListODI: [String:Double] = [:]
    var playerBattingDataListDomistic: [String:Double] = [:]
    
    var playerBowlingDataListT20I: [String:Double] = [:]
    var playerBowlingDataListODI: [String:Double] = [:]
    var playerBowlingDataListDomistic: [String:Double] = [:]
    
    
    var selectedLeagueIndex = 0
    var deselectedLeagueIndex = 1
    
    var statsTypeList: [String] = []
    
    var playerBattingData: PlayerDetailBattingModel?
    var playerBowlingData: PlayerDetailBowlingModel?
    
    var viewModel = PlayerDetailStatsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupBinders()
    }
    
    func setup(){
        
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        statsTypeList = [
            "T20I",
            "ODI",
            "Domistic"
        ]
        
        let nibPlayerStats = UINib(nibName: Constants.shared.PlayerDetailStatsTableViewCell, bundle: nil)
        tableView.register(nibPlayerStats, forCellReuseIdentifier: Constants.shared.PlayerDetailStatsTableViewCell)
        
        let nibStatsCategory = UINib(nibName: Constants.shared.CommonCollectionViewCell , bundle: nil)
        
        collectionView.register(nibStatsCategory, forCellWithReuseIdentifier: Constants.shared.CommonCollectionViewCell)
        
        let collectionViewCellLayout = UICollectionViewFlowLayout()
        collectionViewCellLayout.itemSize = CGSize(width: 100
                                                   , height: 40)
        collectionViewCellLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = collectionViewCellLayout
        
        
    }
    
    func setupBinders(){
        
        
        viewModel.$statics.sink{ _ in
            
        }.store(in: &cancellables)
        
        PlayerDetailViewController.viewModel.$playerInfo.sink{ playerInfo in
            
            guard let data = playerInfo else {
                
                print("Player data unable to faced from PlayerDetailViewController")
                return
            }
            self.viewModel.getStaticsData(career: data.career , type: "T20I")
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
            
        }.store(in: &cancellables)
        
    }
    
}

extension PlayerDetailStatsViewController: UITableViewDelegate{
    
}

extension PlayerDetailStatsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel.matchesBowling > 0 {
            
           return 2
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.shared.PlayerDetailStatsTableViewCell, for: indexPath) as! PlayerDetailStatsTableViewCell
        
        if indexPath.row == 0{
            cell.setBatting(playerData: viewModel.statics)
        } else {

            cell.setBowling(playerData: viewModel.statics)
        }
        return cell
        
    }
}


extension PlayerDetailStatsViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? CommonCollectionViewCell {
            
            UIView.animate(withDuration: 0.5, delay: 0, animations: {
                selectedCell.containerView.backgroundColor = UIColor(named: "tabbuttonColor")
                selectedCell.name.textColor = .white
            })
            deselectedLeagueIndex = selectedLeagueIndex
            selectedLeagueIndex = indexPath.row
            
        }
        
        //Change the color of deselected league
        let deselectedIndexPath = IndexPath(item: deselectedLeagueIndex, section: 0)
        if let deselectedCell = collectionView.cellForItem(at: deselectedIndexPath) as? CommonCollectionViewCell {
            deselectedCell.containerView.backgroundColor = .white
            deselectedCell.name.textColor = .black
        }
        
        switch indexPath.row {
        case 0:
            viewModel.getStaticsData(career: PlayerDetailViewController.viewModel.playerInfo?.career ?? [], type: "T20I")
            break
        case 1:
            viewModel.getStaticsData(career: PlayerDetailViewController.viewModel.playerInfo?.career ?? [], type: "ODI")
            break
        case 2:
            viewModel.getStaticsData(career: PlayerDetailViewController.viewModel.playerInfo?.career ?? [], type: "T20")
            break
        default:
            viewModel.getStaticsData(career: PlayerDetailViewController.viewModel.playerInfo?.career ?? [], type: "T20I")
            break
        }
        tableView.reloadData()
    }
}

extension PlayerDetailStatsViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.shared.CommonCollectionViewCell, for: indexPath) as! CommonCollectionViewCell
        cell.name.text = statsTypeList[indexPath.row]

        
        if selectedLeagueIndex == indexPath.row {
            cell.containerView.backgroundColor = UIColor(named: "tabbuttonColor")
            cell.name.textColor = .white
        }
        
        
        
        return cell
        
    }
    
    
    
}
