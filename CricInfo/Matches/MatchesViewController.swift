//
//  MatchesViewController.swift
//  CricInfo
//
//  Created by bjit on 9/2/23.
//

import UIKit
import Combine

class MatchesViewController: UIViewController, DataPickerDelegate {
    
    
    @IBOutlet weak var noNetworkExistImageView: UIImageView!
    
    @IBOutlet weak var noNetworkExistLabel: UILabel!
    
    
    @IBOutlet weak var dataNotExistUIView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var selectedDateLabel: UILabel!
    
    var deselectedLeagueIndex = 1
    
    var selectedLeagueIndex = 0
    
    var leagueList: [LeagueModel] = []
    
    var fixtureMatchList: [FixtureModel] = []{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var viewModel = MatchesViewModel()
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        setupBinders()
        
        self.navigationItem.titleView?.isHidden = true
        Utilities.shared.chechDarkModeStatus()

        if Utilities.shared.checkInternetConnectivity() == true {
            
            viewModel.getResponseFixtures()
            
            
        } else {
            showNoNewtorkExist()
        }
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
    
    func setupBinders(){
        
        viewModel.$fixtureMatchesList.sink{ fixtureData in
            
            guard let data = fixtureData else
            {
                print("Fixture data is unable to fetch from MatchesViewController")
                return
            }
            
            //            print("Fixture data:",data)
            DispatchQueue.main.async {
                
                if data.count > 0 {
                    self.dataNotExistUIView.isHidden = true
                } else {
                    self.showNoDataExist()
                }
            }
            
            self.fixtureMatchList.removeAll()
            for match in data{
                self.fixtureMatchList.append(FixtureModel(matchData: match))
            }
        }.store(in: &cancellables)
        
    }
    
    
    func setup(){
        
        leagueList = LeagueInfoModel.getLeagueData()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let nibLeagues = UINib(nibName: Constants.shared.LeagueCollectionViewCell , bundle: nil)
        
        collectionView.register(nibLeagues, forCellWithReuseIdentifier: Constants.shared.LeagueCollectionViewCell)
        
        let collectionViewCellLayout = UICollectionViewFlowLayout()
        collectionViewCellLayout.itemSize = CGSize(width: 100, height: 100)
        collectionViewCellLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = collectionViewCellLayout
        
        let nibFixture = UINib(nibName: Constants.shared.FixtureTableViewCell, bundle: nil)
        
        tableView.register(nibFixture, forCellReuseIdentifier: Constants.shared.FixtureTableViewCell)
    }
    
    func passDateBack(date: Date) {
        
        if Utilities.shared.checkInternetConnectivity() == true {
            
            viewModel.getResponseFixturesByDate(byDate: date)
        } else
        {
            showNoNewtorkExist()
        }
        
        selectedDateLabel.text = Utilities.shared.getFormattedDate(at: date)
        print("selected date from MatchesViewController \(date.description)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDatePicker" {
            
            print("identifier")
            if let destVC = segue.destination as? DatePickerViewController{
                
                destVC.delegate = self
            }
            
        }
    }
    
    @IBAction func notificationBtnAction(_ sender: Any) {
        print("Check notification from MatchesViewController")
        
    }
}


extension MatchesViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selectedLeagueIndex != indexPath.row{
            
            
            if let selectedCell = collectionView.cellForItem(at: indexPath) as? LeagueCollectionViewCell{
                
                UIView.animate(withDuration: 0.5, delay: 0, animations: {
                    selectedCell.cellBackground.backgroundColor = UIColor(named: "tabbuttonColor")
                    selectedCell.name.textColor = .white
                })
                deselectedLeagueIndex = selectedLeagueIndex
                selectedLeagueIndex = indexPath.row
                
                //                         fixtureViewModel.fetcMatch(leagueId: LeagueInfo.LeagueInfoList[indexPath.row].id ?? 0)
            }
            
            //Change the color of deselected league
            let deselectedIndexPath = IndexPath(item: deselectedLeagueIndex, section: 0)
            
            
            if let deselectedCell = collectionView.cellForItem(at: deselectedIndexPath) as? LeagueCollectionViewCell {
                deselectedCell.cellBackground.backgroundColor = UIColor(named: "primaryWhite")
                deselectedCell.name.textColor = UIColor(named: "secondaryTextColor")
                
            }
        }
        
        if Utilities.shared.checkInternetConnectivity() == true {
            
        
            switch indexPath.row{
                
            case 0:
                
                viewModel.getResponseFixtures()
                
                break
            case 1:
                viewModel.getResponseFixtures(byLeagueId: Constants.shared.leagueIdT20I)
                
                break
            case 2:
                viewModel.getResponseFixtures(byLeagueId: Constants.shared.leagueIdBBL)
                break
            case 3:
                viewModel.getResponseFixtures(byLeagueId: Constants.shared.leagueIdT20C)
                break
            default:
                viewModel.getResponseFixtures()
                
                break
            }
        } else {
            
            showNoNewtorkExist()
        }
        selectedDateLabel.text = "Not selected yet"
    }
}

extension MatchesViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        self.leagueList.count + 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:Constants.shared.LeagueCollectionViewCell , for: indexPath) as! LeagueCollectionViewCell
        
        if indexPath.row == 0 {
            cell.name.text = "All"
            cell.imageView.image = UIImage(named: "matches")
            
        } else {
            cell.name.text = leagueList[indexPath.row-1].code
            
            cell.imageView.sd_setImage(with: URL(string: leagueList[indexPath.row-1].imagePath), placeholderImage: UIImage(named: "flagPlaceholder"))
        }
        
        if selectedLeagueIndex == indexPath.row {
            cell.cellBackground.backgroundColor = UIColor(named: "tabbuttonColor")
            cell.name.textColor = UIColor(named: "primaryWhite")
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

extension MatchesViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewModel.gotToDetailPage(indexPath: indexPath, VC: self, status: .NS)
    }
    
}

extension MatchesViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: collectionView.bounds.width, y: 0)
        cell.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.1 * Double(indexPath.row), options: [.transitionCrossDissolve], animations: {
            cell.alpha = 1
            cell.transform = CGAffineTransform(translationX: 0, y: 0)

        })
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.fixtureMatchList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.shared.FixtureTableViewCell, for: indexPath) as! FixtureTableViewCell
        
        cell.teamFlag1.sd_setImage(with: URL(string: self.fixtureMatchList[indexPath.row].localTeamImagePath), placeholderImage: UIImage(named: "flagPlaceholder"))
        
        cell.teamFlag2.sd_setImage(with: URL(string: self.fixtureMatchList[indexPath.row].visitorTeamImagePath), placeholderImage: UIImage(named: "flagPlaceholder"))
        
        cell.leagueLabel.text = self.fixtureMatchList[indexPath.row].leagueName
        cell.dateLabel.text = self.fixtureMatchList[indexPath.row].matchDate
        cell.resultLabel.text = self.fixtureMatchList[indexPath.row].matchResultNote
        
        cell.teamName1.text = self.fixtureMatchList[indexPath.row].localTeamName
        cell.teamName2.text = self.fixtureMatchList[indexPath.row].vistitorTeamName
        
        cell.containerUIView.layer.cornerRadius = 15
        
        cell.layer.cornerRadius = 15 // Set the corner radius of the cell
        cell.layer.shadowColor = UIColor.black.cgColor // Set the shadow color
        cell.layer.shadowOffset = CGSize(width: 0, height: 2) // Set the shadow offset
        cell.layer.shadowOpacity = 0.5 // Set the shadow opacity
        cell.layer.shadowRadius = 2 // Set the shadow radius
        cell.layer.masksToBounds = false // Allow the shadow to be visible outside the cell
        return cell
    }
    
    
}
