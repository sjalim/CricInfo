//
//  HomeViewController.swift
//  CricInfo
//
//  Created by bjit on 9/2/23.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    // MARK: - Outlets

    
    @IBOutlet weak var matchNotStartUIView: UIView!
    
    
    @IBOutlet weak var tableViewLiveScore: UITableView!
    
    
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var categorySegmentControl: UISegmentedControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var scoreboardUIView: UIView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var noLiveMatchImageView: UIImageView!
    
    
    @IBOutlet weak var noLiveMatchLabel: UILabel!
    
    var currentSelectedLiveMatch = 0
    
    
    var currentlyBetters: [LiveBattingModel] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableViewLiveScore.reloadData()
                
            }
        }
    }
    
    var currentBowler: [LiveBowlerModel] = [] {
        didSet{
            DispatchQueue.main.async {
                self.tableViewLiveScore.reloadData()
            }
        }
    }
    
    var currentSelectedCategory = 0
    
    var viewModel = HomeViewModel()
    
    private var cancellables: Set<AnyCancellable> = []
    
    let liveGif = UIImage(named: "live")
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.shared.chechDarkModeStatus()

        collectionView.delegate = self
        collectionView.dataSource = self
        tableViewLiveScore.dataSource = self
        tableViewLiveScore.delegate = self
        
        setupFlowLayoutForLive()
        setupBinder()
        
        self.navigationItem.titleView?.isHidden = true
        
        tableViewLiveScore.sectionHeaderTopPadding = 0
        
        if Utilities.shared.checkInternetConnectivity() == true{
            
            viewModel.getResponseLiveMatches()
            viewModel.getResponseRecentMatches()
            viewModel.getResponseUpcomingMatches()
            viewModel.getPlayerDataToCoreData()
            
            
        } else {
            print("no internet!!!")
            showNoNewtorkExist()
            CustomAlertViewController.shared.appear(sender: self)
        }
    }
   
    
    func configureCustomActivityIndicator(){
        
    }
    
    func showNoNewtorkExist(){
        self.noLiveMatchImageView.image = UIImage(systemName: "icloud.slash")
        self.noLiveMatchLabel.text = "No Internet"
    }
    
    func showNoDataExist(){
        self.noLiveMatchLabel.text = "No Match Data"
        self.noLiveMatchImageView.image = UIImage(systemName: "noData")
        
    }
    
   
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    @IBAction func notificationBtnAction(_ sender: Any) {
        
        print("Check notification from HomeViewController")
    }
    
    func setupBinder(){
        
        viewModel.$recentMatchesDataList.sink{ _ in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }.store(in: &cancellables)
        
        
        viewModel.$upcomingMatchesDataList.sink{
            matchData in
            
            guard let data = matchData else {
                print("Unable to fetch upcoming matches")
                return
            }
//            self.viewModel.createNotifications(upcomingMatchData: data)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }.store(in: &cancellables)
        
        viewModel.$playerDataList.sink { playerData in
            
            guard let data = playerData else {
                
                print("Player data unable to fetch!")
                
                return
            }
            
            print("Player data fetched", data[0])
            
            DispatchQueue.global().async {
                CoreDataManager.shared.addItems(data: data)
            }
            
            
        }.store(in: &cancellables)
        
        viewModel.$liveMatchesData.sink{ liveData in
            
            guard let data = liveData else {
                print("live data unable to fetch")
                return
            }
            
            if data.count > 0 {
                DispatchQueue.main.async {
                    self.matchNotStartUIView.isHidden = true
                }
                for batsman in data[self.currentSelectedLiveMatch].batting {

                    if batsman.result.name == "Not Out"{
                        self.currentlyBetters.append(LiveBattingModel(batsmanData: batsman))
                    }
                }

                for bowler in data[self.currentSelectedLiveMatch].bowling{

                    if bowler.overs.truncatingRemainder(dividingBy: 1) > 0 {

                        self.currentBowler.append(LiveBowlerModel(bowlerData: bowler))

                    }
                }
                
                DispatchQueue.main.async {
                    self.tableViewLiveScore.reloadData()
                    self.collectionView.reloadData()
                }

            } else {
                DispatchQueue.main.async {

                    self.matchNotStartUIView.isHidden = false
                }

            }
            print("Live data fetched", data)
            
        }.store(in: &cancellables)
        
    }
    
    func setupFlowLayoutForLive(){
        let scoreNib = UINib(nibName:Constants.shared.ScoreCollectionViewCell, bundle: nil)
        collectionView.register(scoreNib, forCellWithReuseIdentifier: Constants.shared.ScoreCollectionViewCell)
        
        let collectionViewCellLayout = UICollectionViewFlowLayout()
        
        collectionViewCellLayout.minimumInteritemSpacing = 10
        collectionViewCellLayout.minimumLineSpacing = 10
        collectionViewCellLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        collectionViewCellLayout.itemSize = CGSize(width: view.frame.width - 10, height: 150)
        collectionViewCellLayout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = collectionViewCellLayout
        collectionViewHeightConstraint.constant = 200
        bottomView.isHidden = false
        collectionView.collectionViewLayout.invalidateLayout()

        let scoreCardNib = UINib(nibName: Constants.shared.ScoreCardTableViewCell, bundle: nil)
        
        tableViewLiveScore.register(scoreCardNib, forCellReuseIdentifier: Constants.shared.ScoreCardTableViewCell)
        
        let winPerNib = UINib(nibName: Constants.shared.WinPercentageTableViewCell, bundle: nil)
        
        tableViewLiveScore.register(winPerNib, forCellReuseIdentifier: Constants.shared.WinPercentageTableViewCell)
        
        let battingSummeryHeaderNib = UINib(nibName: Constants.shared.BattingSummeryTableHeaderView, bundle: nil)
        
        tableViewLiveScore.register(battingSummeryHeaderNib, forHeaderFooterViewReuseIdentifier: Constants.shared.BattingSummeryTableHeaderView)
        
        
        let bowlingSummeryHeaderNib = UINib(nibName: Constants.shared.BowlingSummeryTableHeaderView, bundle: nil)
        
        tableViewLiveScore.register(bowlingSummeryHeaderNib, forHeaderFooterViewReuseIdentifier: Constants.shared.BowlingSummeryTableHeaderView)
        
        let battingSummeryNib = UINib(nibName: Constants.shared.BattingSummeryTableViewCell, bundle: nil)
        
        tableViewLiveScore.register(battingSummeryNib, forCellReuseIdentifier: Constants.shared.BattingSummeryTableViewCell)
        
        let bowlingSummeryNib = UINib(nibName: Constants.shared.BowlingSummeryTableViewCell, bundle: nil)
        
        tableViewLiveScore.register(bowlingSummeryNib, forCellReuseIdentifier: Constants.shared.BowlingSummeryTableViewCell)
        
        
    }
    
    func setupFlowLayoutForRecent(){
        let scoreNib = UINib(nibName: Constants.shared.ScoreCollectionViewCell, bundle: nil)
        collectionView.register(scoreNib, forCellWithReuseIdentifier: Constants.shared.ScoreCollectionViewCell)
        
        let collectionViewCellLayout = UICollectionViewFlowLayout()
        
        collectionViewCellLayout.minimumInteritemSpacing = 0 // Sets the minimum horizontal space between cells
        collectionViewCellLayout.minimumLineSpacing = 0 // Sets the minimum vertical space between cells
        collectionViewCellLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // Sets the inset for the entire section (top, left, bottom, right)

        collectionViewCellLayout.itemSize = CGSize(width: view.frame.width - 10, height: 250)
        collectionViewCellLayout.scrollDirection = .vertical
        collectionView.collectionViewLayout = collectionViewCellLayout
        collectionViewHeightConstraint.constant = 650
        bottomView.isHidden = true
        collectionView.collectionViewLayout.invalidateLayout()

    }
    
    func setupFlowLayoutForUpcoming(){
        let scoreNib = UINib(nibName:Constants.shared.MatchInfoUpcomingCollectionViewCell, bundle: nil)
        collectionView.register(scoreNib, forCellWithReuseIdentifier:Constants.shared.MatchInfoUpcomingCollectionViewCell)
        
        let collectionViewCellLayout = UICollectionViewFlowLayout()
        collectionViewCellLayout.minimumInteritemSpacing = 0 // Sets the minimum horizontal space between cells
        collectionViewCellLayout.minimumLineSpacing = 0 // Sets the minimum vertical space between cells
        collectionViewCellLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // Sets the inset for the entire section (top, left, bottom, right)
        collectionViewCellLayout.itemSize = CGSize(width: view.frame.width - 10, height: 150)
        collectionViewCellLayout.scrollDirection = .vertical
        collectionView.collectionViewLayout = collectionViewCellLayout
        collectionViewHeightConstraint.constant = 650
        bottomView.isHidden = true
        collectionView.collectionViewLayout.invalidateLayout()

        
    }
    
    // MARK: - Actions
    
    @IBAction func changeCategorySegment(_ sender: UISegmentedControl) {
        
//        print(sender.selectedSegmentIndex)
        
        switch sender.selectedSegmentIndex{
            
        case 0:
            
            if Utilities.shared.checkInternetConnectivity() == true{
                    
                setupFlowLayoutForLive()
                currentSelectedCategory = 0
                if viewModel.liveMatchesData?.count == 0 {
                    
                    showNoDataExist()
                    self.matchNotStartUIView.isHidden = false
                    
                } else {
                    
                    self.matchNotStartUIView.isHidden = true
                }
            } else {
                showNoNewtorkExist()
            }
            
            break
            
        case 1:
            if Utilities.shared.checkInternetConnectivity() == true{
                setupFlowLayoutForRecent()
                currentSelectedCategory = 1
                
                if viewModel.recentMatchesDataList?.count == 0 {
                    showNoDataExist()
                    self.matchNotStartUIView.isHidden = false
                } else {
                    
                    self.matchNotStartUIView.isHidden = true
                }
                
                
            } else {
                showNoNewtorkExist()

            }
            break
            
        case 2:
            if Utilities.shared.checkInternetConnectivity() == true {
                
                setupFlowLayoutForUpcoming()
                currentSelectedCategory = 2
                
                if viewModel.upcomingMatchesDataList?.count == 0 {
                    showNoDataExist()
                    self.matchNotStartUIView.isHidden = false
                } else {
                    self.matchNotStartUIView.isHidden = true
                }
            } else {
                showNoNewtorkExist()
            }
            
            break
            
        default:
            if Utilities.shared.checkInternetConnectivity() == true {
                setupFlowLayoutForLive()
                currentSelectedCategory = 0
                
                if viewModel.liveMatchesData?.count == 0 {
                    showNoDataExist()
                    self.matchNotStartUIView.isHidden = false
                } else {
                    self.matchNotStartUIView.isHidden = true
                }
            } else {
                showNoNewtorkExist()
            }
            break
            
        }
        collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("check")
        switch currentSelectedCategory{
            
        case 0:
            currentSelectedLiveMatch = indexPath.row
            
//            viewModel.gotToDetailPage(indexPath: indexPath, VC: self, status: .Running)
            
            break
        case 1:
            viewModel.gotToDetailPage(indexPath: indexPath, VC: self, status: .Finished)
            
            break
        case 2:
            viewModel.gotToDetailPage(indexPath: indexPath, VC: self, status: .NS)
            break
        default:
            break
        }
        
    
        self.collectionView.reloadData()
    }
    
}


extension HomeViewController: UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.transform = CGAffineTransform(translationX: collectionView.bounds.width, y: 0)
        cell.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0.1 * Double(indexPath.row), options: [.transitionCrossDissolve], animations: {
            cell.transform = CGAffineTransform(translationX: 0, y: 0)
            
            cell.alpha = 1
        })
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        switch currentSelectedCategory{
            
        case 0:
            count = viewModel.liveMatchesData?.count ?? 0
            break
        case 1:
            count = viewModel.recentMatchesDataList?.count ?? 0
            break
        case 2:
            count = viewModel.upcomingMatchesDataList?.count ?? 0
            break
        default:
            count = 0
            break
        }
        
        return count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch currentSelectedCategory{
            
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.shared.ScoreCollectionViewCell, for: indexPath) as! ScoreCollectionViewCell
            cell.liveIndicatorImageView.isHidden = false
            cell.liveIndicatorImageView.image = self.liveGif
            
            
            if let listData = viewModel.liveMatchesData {
                cell.setData(data: listData[indexPath.row])
            }
//            cell.containerView.dropShadow()
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.shared.ScoreCollectionViewCell, for: indexPath) as! ScoreCollectionViewCell
            
            if let listData = viewModel.recentMatchesDataList{
                cell.setData(data: listData[indexPath.row])
            }
            
            cell.liveIndicatorImageView.isHidden = true
//            cell.containerView.dropShadow()
            
            return cell
            
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.shared.MatchInfoUpcomingCollectionViewCell, for: indexPath) as! MatchInfoUpcomingCollectionViewCell
            
            
            if let listData = viewModel.upcomingMatchesDataList{
                
                cell.setData(data: listData[indexPath.row])
            }
//            cell.containerView.dropShadow()
            
            return cell
            
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.shared.ScoreCollectionViewCell, for: indexPath) as! ScoreCollectionViewCell
            
//            cell.containerView.dropShadow()
            return cell
        }
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width - 10, height: 150)
    }
}

extension HomeViewController: UITableViewDelegate{
    
}

extension HomeViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 2
            
        case 1:
            return 1
            
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.shared.BattingSummeryTableViewCell, for: indexPath) as! BattingSummeryTableViewCell
            
            if currentlyBetters.count > 0 {
                
                
                if currentlyBetters[indexPath.row].activeStatus == true{
                    cell.nameLabel.text = currentlyBetters[indexPath.row].nameLabel + "*"
                }
                else
                {
                    cell.nameLabel.text = currentlyBetters[indexPath.row].nameLabel
                    
                }
                cell.OutStatusLabel.text = currentlyBetters[indexPath.row].outStatus
                cell.bowlLabel.text = currentlyBetters[indexPath.row].bowlLabel
                
                cell.runLabel.text = currentlyBetters[indexPath.row].runLabel
                cell.fourLabel.text = currentlyBetters[indexPath.row].fourLabel
                cell.sixLabel.text = currentlyBetters[indexPath.row].sixLabel
                cell.rateLabel.text = currentlyBetters[indexPath.row].rateLabel
                
            }
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.shared.BowlingSummeryTableViewCell, for: indexPath) as! BowlingSummeryTableViewCell
            if currentBowler.count > 0 {
                
                cell.oversLabel.text = currentBowler[indexPath.row].oversLabel
                cell.nameLabel.text = "*" + currentBowler[indexPath.row].nameLabel
                cell.medianLabel.text = currentBowler[indexPath.row].medianLabel
                cell.runLabel.text = currentBowler[indexPath.row].runLabel
                cell.wicketLabel.text = currentBowler[indexPath.row].wicketLabel
                cell.rateLabel.text = currentBowler[indexPath.row].rateLabel
            }
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.shared.WinPercentageTableViewCell, for: indexPath) as! WinPercentageTableViewCell
            
            return cell
            
        default:
            return UITableViewCell()
            
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section{
            
        case 0:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.shared.BattingSummeryTableHeaderView) as! BattingSummeryTableHeaderView
            
            return header
        case 1:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.shared.BowlingSummeryTableHeaderView) as! BowlingSummeryTableHeaderView
            
            return header
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section{
        case 0:
            return 30
        case 1:
            return 20
        case 2:
            return 0
        default:
            return 30
        }
    }
    
    
    
}
