//
//  MatchDetailViewController.swift
//  CricInfo
//
//  Created by bjit on 14/2/23.
//

import UIKit
import Combine

class MatchDetailViewController: UIViewController {
    
    @IBOutlet weak var stadiumBannerImageView: UIImageView!
    
    @IBOutlet weak var teamFlag1: UIImageView!
    
    @IBOutlet weak var teamFlag2: UIImageView!
    
    @IBOutlet weak var teamName1: UILabel!
    
    @IBOutlet weak var teamName2: UILabel!
    
    @IBOutlet weak var infoContainerVeiw: UIView!
    
    @IBOutlet weak var scoreboardContainerView: UIView!
    
    @IBOutlet weak var squadContainerView: UIView!
    private var cancellables: Set<AnyCancellable> = []
    
    static var viewModel = MatchDetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.navigationController?.isNavigationBarHidden = false
        
        setup()
        setupBinder()
        //        viewModel.getCurrentMatchData()
        
    }
    
    // Inside your view controller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get the tab bar controller instance
        if let tabBarController = self.tabBarController {
            
            // Hide the tab bar
            tabBarController.tabBar.isHidden = true
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Get the tab bar controller instance
        if let tabBarController = self.tabBarController {
            
            // Unhide the tab bar
            tabBarController.tabBar.isHidden = false
        }
    }
    func setup(){
        infoContainerVeiw.alpha = 1
        scoreboardContainerView.alpha = 0
        squadContainerView.alpha = 0
        
        teamFlag1.layer.cornerRadius = 10
        teamFlag2.layer.cornerRadius = 10
        
        
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
            
            //            print("status:", status)
            
        }.store(in: &cancellables)
        
        MatchDetailViewController.viewModel.$matchData.sink{ matchData in
            
            
            guard let data = matchData else {
                print("Match data from MatchDetailViewController")
                return
            }
            
            DispatchQueue.main.async {
                
                self.teamFlag1.sd_setImage(with: URL(string:  data.localteam?.imagePath ?? ""), placeholderImage: UIImage(named: "flagPlaceholder.jpg"))
                
                self.teamFlag2.sd_setImage(with: URL(string: data.visitorteam?.imagePath ?? ""), placeholderImage: UIImage(named: "flagPlaceholder.jpg" ))
                
                self.stadiumBannerImageView.sd_setImage(with: URL(string: data.venue?.imagePath ?? ""),placeholderImage: UIImage(named: "stadiumPic"))
                self.teamName1.text = data.localteam?.name
                self.teamName2.text = data.visitorteam?.name
                
            }
        }.store(in: &cancellables)
        
    }
    
    
    
    @IBAction func categorySegmentControl(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex{
            
        case 0:
            infoContainerVeiw.alpha = 1
            scoreboardContainerView.alpha = 0
            squadContainerView.alpha = 0
            break
        case 1:
            infoContainerVeiw.alpha = 0
            scoreboardContainerView.alpha = 1
            squadContainerView.alpha = 0
            break
        case 2:
            infoContainerVeiw.alpha = 0
            scoreboardContainerView.alpha = 0
            squadContainerView.alpha = 1
            break
        default:
            infoContainerVeiw.alpha = 1
            scoreboardContainerView.alpha = 0
            squadContainerView.alpha = 0
            break
        }
        
    }
    
}
