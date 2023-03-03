//
//  RankViewController.swift
//  CricInfo
//
//  Created by bjit on 9/2/23.
//

import UIKit
import Combine

class RankViewController: UIViewController {
    
    @IBOutlet weak var noNetworkExistImageView: UIImageView!
    
    @IBOutlet weak var noNetworkExistLabel: UILabel!
    
    @IBOutlet weak var dataNotExistUIView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedCategory = 0
    var selectedGender = 0
    
    var selectedLeagueIndex = 0
    var deselectedLeagueIndex = 1
    
    var viewModel = RankViewModel()
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.shared.chechDarkModeStatus()

        tableView.dataSource = self
        tableView.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.navigationItem.titleView?.isHidden = true
        
        Utilities.shared.chechDarkModeStatus()

        setup()
        setupBinders()
        
        if Utilities.shared.checkInternetConnectivity() == true {
            viewModel.getResponseRank()
            
        } else {
            showNoNewtorkExist()
        }
        
    }
    
    func setup(){
        
        let nibRankCell = UINib(nibName: Constants.shared.RankTableViewCell, bundle: nil)
        
        tableView.register(nibRankCell, forCellReuseIdentifier: Constants.shared.RankTableViewCell)
        
        
        let nibRankHeader = UINib(nibName: Constants.shared.RankTableViewHeaderFooterView, bundle: nil)
        
        tableView.register(nibRankHeader, forHeaderFooterViewReuseIdentifier: Constants.shared.RankTableViewHeaderFooterView)
        
        let nibRankCategory = UINib(nibName: Constants.shared.LeagueCollectionViewCell , bundle: nil)
        
        collectionView.register(nibRankCategory, forCellWithReuseIdentifier: Constants.shared.LeagueCollectionViewCell)
        
        let collectionViewCellLayout = UICollectionViewFlowLayout()
        collectionViewCellLayout.itemSize = CGSize(width: 100, height: 100)
        collectionViewCellLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = collectionViewCellLayout
        
    }
    
    func setupBinders(){
        
        viewModel.$rankList.sink{ rankData in
            
            guard let data = rankData else {
                print("Rank data unable to fetch")
                return
            }
            
            print("Rank data fetched")
            
            DispatchQueue.main.async {
                
                if data.count > 0 {
                    self.dataNotExistUIView.isHidden = true
                } else {
                    
                    self.showNoDataExist()
                }
                self.tableView.reloadData()
            }
            
            //            print(data)
        }.store(in: &cancellables)
    }
    
    
    func showNoNewtorkExist(){
        self.dataNotExistUIView.isHidden = false
        self.noNetworkExistImageView.image = UIImage(systemName: "icloud.slash")
        self.noNetworkExistImageView.tintColor = .black
        self.noNetworkExistLabel.text = "No Internet"
        CustomAlertViewController.shared.appear(sender: self)
    }
    
    func showNoDataExist(){
        self.dataNotExistUIView.isHidden = false
        self.noNetworkExistLabel.text = "No Match Data"
        self.noNetworkExistImageView.image = UIImage(named: "noData")
    }
    
    
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        
        if Utilities.shared.checkInternetConnectivity() == true {
            
            
            
            switch sender.selectedSegmentIndex{
                
            case 0:
                selectedCategory = 0
                switch selectedGender {
                case 0:
                    viewModel.getResponseRank()
                    break
                case 1:
                    viewModel.getResponseRank(gender: "women")
                    
                    break
                default:
                    viewModel.getResponseRank()
                    
                    break
                }
                
                break
            case 1:
                selectedCategory = 1
                switch selectedGender {
                case 0:
                    viewModel.getResponseRank(type: "T20I")
                    break
                case 1:
                    viewModel.getResponseRank(gender: "women", type: "T20I")
                    
                    break
                default:
                    viewModel.getResponseRank(type: "T20I")
                    
                    break
                }
                break
            case 2:
                selectedCategory = 2
                switch selectedGender {
                case 0:
                    viewModel.getResponseRank(type: "ODI")
                    break
                case 1:
                    viewModel.getResponseRank(gender: "women", type: "ODI")
                    
                    break
                default:
                    viewModel.getResponseRank(type: "ODI")
                    
                    break
                }
                break
                
            default:
                switch selectedGender {
                case 0:
                    viewModel.getResponseRank()
                    break
                case 1:
                    viewModel.getResponseRank(gender: "women")
                    
                    break
                default:
                    viewModel.getResponseRank()
                    break
                }
                selectedCategory = 0
                break
            }
            tableView.reloadData()
        } else {
            showNoNewtorkExist()
        }
    }
}


extension RankViewController: UITableViewDelegate{
    
    
}

extension RankViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
        cell.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.1 * Double(indexPath.row), options: [.curveEaseInOut], animations: {
            cell.alpha = 1
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
            
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.rankList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.shared.RankTableViewCell, for: indexPath) as! RankTableViewCell
        
        cell.rankSerialNumLabel.text = String(indexPath.row + 1)
        cell.rankTeamNameLabel.text = viewModel.rankList?[indexPath.row].name
        
        
        cell.rankImageViewLabel.sd_setImage(with: URL(string: viewModel.rankList?[indexPath.row].imagePath ?? ""), placeholderImage: UIImage(named: "flagPlaceholder"))
        
        cell.rankPointsLabel.text = String(viewModel.rankList?[indexPath.row].ranking.points ?? 0)
        
        cell.rankRatingLabel.text = String(viewModel.rankList?[indexPath.row].ranking.rating ?? 0)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.shared.RankTableViewHeaderFooterView) as! RankTableViewHeaderFooterView
        
        return header
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
}

extension RankViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? LeagueCollectionViewCell {
            
            UIView.animate(withDuration: 0.5, delay: 0, animations: {
                selectedCell.cellBackground.backgroundColor = UIColor(named: "tabbuttonColor")
                selectedCell.name.textColor = UIColor(named: "secondaryTextColor")
            })
            deselectedLeagueIndex = selectedLeagueIndex
            selectedLeagueIndex = indexPath.row
            
        }
        
        //Change the color of deselected league
        let deselectedIndexPath = IndexPath(item: deselectedLeagueIndex, section: 0)
        if let deselectedCell = collectionView.cellForItem(at: deselectedIndexPath) as? LeagueCollectionViewCell {
            deselectedCell.cellBackground.backgroundColor = UIColor(named: "primaryWhite")
            deselectedCell.name.textColor = UIColor(named: "secondaryTextColor")
            
        }
        
        
        if indexPath.row == 0{
            
            selectedGender = 0
            
            switch selectedCategory {
                
            case 0:
                viewModel.getResponseRank(gender: "men", type: "Test")
                
                break
            case 1:
                viewModel.getResponseRank(gender: "men", type: "T20I")
                
                break
            case 2:
                viewModel.getResponseRank(gender: "men", type: "ODI")
                break
            default:
                break
                
            }
            
        } else {
            selectedGender = 1
            
            
            switch selectedCategory {
                
            case 0:
                viewModel.getResponseRank(gender: "women", type: "Test")
                
                break
            case 1:
                viewModel.getResponseRank(gender: "women", type: "T20I")
                
                break
            case 2:
                viewModel.getResponseRank(gender: "women", type: "ODI")
                break
            default:
                break
            }
        }
    }
    
}

extension RankViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.shared.LeagueCollectionViewCell, for: indexPath) as! LeagueCollectionViewCell
        
        if indexPath.row == 0 {
            cell.imageView.image = UIImage(named: "cricketMen")
            cell.name.text = "Men"
            
        }
        else
        {
            cell.imageView.image = UIImage(named: "cricketWomen")
            cell.name.text = "Women"
            
        }
        
        if selectedLeagueIndex == indexPath.row {
            cell.cellBackground.backgroundColor = UIColor(named: "tabbuttonColor")
            cell.name.textColor = UIColor(named: "secondaryTextColor")
        }
        
        cell.cellBackground.layer.cornerRadius = 15
        
        cell.layer.cornerRadius = 15 // Set the corner radius of the cell
        cell.layer.shadowColor = UIColor.black.cgColor // Set the shadow color
        cell.layer.shadowOffset = CGSize(width: 0, height: 2) // Set the shadow offset
        cell.layer.shadowOpacity = 0.5 // Set the shadow opacity
        cell.layer.shadowRadius = 2 // Set the shadow radius
        cell.layer.masksToBounds = false
        return cell
    }
}
