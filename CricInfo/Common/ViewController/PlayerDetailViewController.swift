//
//  PlayerDetailViewController.swift
//  CricInfo
//
//  Created by bjit on 17/2/23.
//

import UIKit
import Combine

class PlayerDetailViewController: UIViewController {
    
    
    @IBOutlet weak var noNetworkExistView: UIView!
    
    @IBOutlet weak var noNetworkExistImageView: UIImageView!
    
    @IBOutlet weak var noNetworkExistLabel: UILabel!
    
    @IBOutlet weak var playerFirstNameLabel: UILabel!
    
    @IBOutlet weak var playerLastNameLabel: UILabel!
    
    @IBOutlet weak var playerAgeLabel: UILabel!
    
    @IBOutlet weak var playerImageView: UIImageView!
    
    @IBOutlet weak var playerCountryFlagBanner: UIImageView!
    
    @IBOutlet weak var playerDetailInfoContainerView: UIView!
    
    @IBOutlet weak var playerDetailBattingContainerView: UIView!
    
    @IBOutlet weak var playerDetailBowlingContainerView: UIView!
    
    @IBOutlet weak var playerDetailStatsContainerView: UIView!
    
    private var cancellables: Set<AnyCancellable> = []
    static var viewModel = PlayerDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupBinders()
    }
    
    func setup(){
        playerDetailInfoContainerView.alpha = 1
        playerDetailBattingContainerView.alpha = 0
        playerDetailBowlingContainerView.alpha = 0
        playerDetailStatsContainerView.alpha = 0
    }
    
    // Inside your view controller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if Utilities.shared.checkInternetConnectivity() == true {
            
            self.noNetworkExistView.isHidden = true
            
        } else {
            showNoNetworkExist()
            CustomAlertViewController.shared.appear(sender: self)
        }
        // Get the tab bar controller instance
        if let tabBarController = self.tabBarController {
            
            // Hide the tab bar
            tabBarController.tabBar.isHidden = true
        }
    }
    
    func showNoNetworkExist() {
        self.noNetworkExistView.isHidden = false
        self.noNetworkExistImageView.image = UIImage(systemName: "icloud.slash")
        self.noNetworkExistImageView.tintColor = .black
        self.noNetworkExistLabel.text = "No Internet"
    }
    
    func showNoDataExist() {
        DispatchQueue.main.async {
            self.noNetworkExistView.isHidden = false
            self.noNetworkExistImageView.image = UIImage(named: "noData")
            self.noNetworkExistLabel.text = "No Data Exist"
        }
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        PlayerDetailViewController.viewModel = PlayerDetailViewModel()
        
        // Get the tab bar controller instance
        if let tabBarController = self.tabBarController {
            
            // Unhide the tab bar
            tabBarController.tabBar.isHidden = false
        }
    }
    
    
    func setupBinders() {
        
        PlayerDetailViewController.viewModel.$playerId.sink{ playerId in
            
            guard let id = playerId else {
                
                print("Player Id doesn't found")
                return
            }
            
            print("Player Id:", id)
            
        }.store(in: &cancellables)
        
        
        PlayerDetailViewController.viewModel.$playerInfo.sink{ playerData in

            guard let data = playerData else {
                self.showNoDataExist()
                return
            }

            let playerDataModel = PlayerDetailModel(playerData: data)
            
            DispatchQueue.main.async {
                
                self.noNetworkExistView.isHidden = true
                self.playerFirstNameLabel.text = playerDataModel.firstName
                self.playerLastNameLabel.text = playerDataModel.lastName
                self.playerAgeLabel.text = playerDataModel.age
                
                self.playerImageView.sd_setImage(with: URL(string: playerDataModel.imagePath), placeholderImage: UIImage(named: "BD"))
                
                self.playerCountryFlagBanner.sd_setImage(with: URL(string: playerDataModel.countryImagePath), placeholderImage: UIImage(named: "BD"))
            }
            
            
        }.store(in: &cancellables)
        
        
        
    }
    
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex{
            
        case 0:
            
            playerDetailInfoContainerView.alpha = 1
            playerDetailBattingContainerView.alpha = 0
            playerDetailBowlingContainerView.alpha = 0
            playerDetailStatsContainerView.alpha = 0
            break
        
        case 1:
            playerDetailInfoContainerView.alpha = 0
            playerDetailBattingContainerView.alpha = 1
            playerDetailBowlingContainerView.alpha = 0
            playerDetailStatsContainerView.alpha = 0
            break
        
        case 2:
            playerDetailInfoContainerView.alpha = 0
            playerDetailBattingContainerView.alpha = 0
            playerDetailBowlingContainerView.alpha = 1
            playerDetailStatsContainerView.alpha = 0
            break
        case 3:
            playerDetailInfoContainerView.alpha = 0
            playerDetailBattingContainerView.alpha = 0
            playerDetailBowlingContainerView.alpha = 0
            playerDetailStatsContainerView.alpha = 1
            break
        default:
            playerDetailInfoContainerView.alpha = 1
            playerDetailBattingContainerView.alpha = 0
            playerDetailBowlingContainerView.alpha = 0
            playerDetailStatsContainerView.alpha = 0
            break
            
            
        }
        
    }
    
}
