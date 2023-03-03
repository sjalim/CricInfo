//
//  SettingsViewModel.swift
//  CricInfo
//
//  Created by bjit on 9/2/23.
//

import Foundation
import UIKit

class SettingsViewModel {
    
    
    func gotoNextPage(indexPath: IndexPath, VC: UIViewController) {
        let detailVC = UIStoryboard(
            name: "Settings",
            bundle: nil
            // swiftlint:disable force_cast
        ).instantiateViewController(withIdentifier: Constants.shared.SettingsDetailViewController) as! SettingsDetailViewController
        detailVC.loadViewIfNeeded()
        
        
        if indexPath.row == 0 {
            detailVC.viewModel.setData(data: "News",headingData: "News")
            
        } else if indexPath.row == 1 {

            detailVC.viewModel.setData(data: Constants.shared.FAQ, headingData: "FAQ")
        } else if indexPath.row == 2 {
            detailVC.viewModel.setData(data: Constants.shared.termsCondition, headingData: "Terms & Conditions")
        }

        VC.navigationController?.pushViewController(detailVC, animated: true)
    }
   
}
