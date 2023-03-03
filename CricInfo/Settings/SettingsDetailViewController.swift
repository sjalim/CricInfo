//
//  SettingsDetailViewController.swift
//  CricInfo
//
//  Created by bjit on 26/2/23.
//

import UIKit
import Combine

class SettingsDetailViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var headingLabel: UILabel!
    

    var viewModel = SettingsDetailViewModel()
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinders()
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
    
    func setupBinders() {
        viewModel.$labelData.sink{ labelData in
            
            guard let data = labelData else {
                
                print("Unable to get data for label")
                return
            }
            
            self.textLabel.text = data
        }.store(in: &cancellables)
        
        viewModel.$headingData.sink{ headingData in
            
            guard let data = headingData else {
                
                print("Unable to get data for label")
                return
            }
            
            self.headingLabel.text = data
        }.store(in: &cancellables)
        
    }
    
    
}
