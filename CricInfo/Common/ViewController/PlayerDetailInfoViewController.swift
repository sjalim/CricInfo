//
//  PlayerDetailInfoViewController.swift
//  CricInfo
//
//  Created by bjit on 17/2/23.
//

import UIKit
import Combine


class PlayerDetailInfoViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var infoList: [String] = []{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var infoKeyList: [String] = [] {
        
        didSet {
            self.tableView.reloadData()
        }
    }
    var viewModel = PlayerDetailInfoViewModel()
    
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupBinders()
    }
    
    func setupBinders() {
        
        PlayerDetailViewController.viewModel.$playerInfo.sink{ playerData in
            
            guard let data = playerData else{
                print("Player data unable to fetch from PlayerDetailInfoViewController")
                return
            }
                
            DispatchQueue.main.async {
                let playerDataModel = PlayerDetailModel(playerData: data)
                print("Player Data Model:", playerDataModel)
                
                self.infoList.append(playerDataModel.firstName)
                self.infoList.append(playerDataModel.lastName)
                self.infoList.append(playerDataModel.fullName)
                self.infoList.append(playerDataModel.role)
                self.infoList.append(playerDataModel.dateOfBirth)
                self.infoList.append(playerDataModel.gender)
                self.infoList.append(playerDataModel.battingStyle)
                self.infoList.append(playerDataModel.bowlingStyle)
                self.infoList.append(playerDataModel.countryName)
                self.tableView.reloadData()
            }
        }.store(in: &cancellables)
    }
    
    
   func setup() {
       infoKeyList.append("First Name:")
       infoKeyList.append("Last Name:")
       infoKeyList.append("Full Name:")
       infoKeyList.append("Role:")
       infoKeyList.append("Date of Birth:")
       infoKeyList.append("Gender:")
       infoKeyList.append("Batting Style:")
       infoKeyList.append("Bowling Style:")
       infoKeyList.append("Country:")
       
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nibPlayerInfo = UINib(nibName: Constants.shared.PlayerDetailInfoTableViewCell, bundle: nil)
        
        tableView.register(nibPlayerInfo, forCellReuseIdentifier: Constants.shared.PlayerDetailInfoTableViewCell)
        
        let nibHeader = UINib(nibName: Constants.shared.CommonTableViewHeaderFooterView, bundle: nil)
        
        tableView.register(nibHeader, forHeaderFooterViewReuseIdentifier: Constants.shared.CommonTableViewHeaderFooterView)
    }

}


extension PlayerDetailInfoViewController: UITableViewDelegate {
    
}


extension PlayerDetailInfoViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        9
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.shared.PlayerDetailInfoTableViewCell, for: indexPath) as! PlayerDetailInfoTableViewCell
        
        
        cell.contentLabel.text = infoKeyList[indexPath.row]
        
        if infoList.count > 0 {
            
            cell.contentTextLabel.text = infoList[indexPath.row]
        }

        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.shared.CommonTableViewHeaderFooterView) as! CommonTableViewHeaderFooterView
        
        header.headerTextLabel.text = "Personal Information"
        

        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
    
    
    
  
    
    
}


