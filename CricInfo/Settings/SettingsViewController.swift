//
//  SettingsViewController.swift
//  CricInfo
//
//  Created by bjit on 9/2/23.
//

import UIKit
import Combine

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    @IBOutlet weak var notificationSound: UISwitch!
    
    @IBOutlet weak var tableView: UITableView!
   
    var viewModel = SettingsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        Utilities.shared.chechDarkModeStatus()
        configureSwitch()
        
        let nibSetting = UINib(nibName: Constants.shared.SettingTableViewCell, bundle: nil)
        
        tableView.register(nibSetting, forCellReuseIdentifier: Constants.shared.SettingTableViewCell)

    }
    

    func configureSwitch(){
        
        if Utilities.shared.defaults.bool(forKey: Constants.shared.DarkMode) == false {
            darkModeSwitch.isOn = false
            
        } else {
            darkModeSwitch.isOn = true
        }
        
    }
   

    @IBAction func darkModeAction(_ sender: Any) {
        
        print("check darkmode action")
        if Utilities.shared.defaults.bool(forKey: Constants.shared.DarkMode) == false {
            Utilities.shared.defaults.set(true, forKey: Constants.shared.DarkMode)
        } else {
            Utilities.shared.defaults.set(false, forKey: Constants.shared.DarkMode)
        }
        Utilities.shared.chechDarkModeStatus()
    }
}


extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.gotoNextPage(indexPath: indexPath, VC: self)
    }
    
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.shared.SettingTableViewCell, for: indexPath) as! SettingTableViewCell
        
        if indexPath.row == 0 {
            cell.nameLabel.text = "News"
        } else if indexPath.row == 1{
            cell.nameLabel.text = "FAQ"
        } else if indexPath.row == 2{
            cell.nameLabel.text = "Terms & Conditions"
        }
        
        return cell
    }
    
    
}
