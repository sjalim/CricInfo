//
//  PlayersViewController.swift
//  CricInfo
//
//  Created by bjit on 9/2/23.
//

import UIKit
import Combine


class PlayersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    
    var viewModel = PlayersViewModel()
    
    private var cancellables: Set<AnyCancellable> = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.shared.chechDarkModeStatus()

        self.navigationItem.titleView?.isHidden = true
        
        
        searchTextField.addTarget(self, action: #selector(searchPlayerAction), for: .editingChanged)
        tableView.delegate = self
        tableView.dataSource = self
        
        Utilities.shared.chechDarkModeStatus()

        setup()
        setupBinders()
    }
    
    func setup(){
        
        let nibPlayer = UINib(nibName: Constants.shared.PlayersTableViewCell, bundle: nil)
        
        tableView.register(nibPlayer, forCellReuseIdentifier: Constants.shared.PlayersTableViewCell)
        
        viewModel.setPlayerList(playerData: CoreDataManager.shared.getSearchData(searchText: "A") ?? [])
    }
    
    func setupBinders(){
        
        viewModel.$playerList.sink { _ in
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
            
        }.store(in: &cancellables)
    }
    
    func gotToPlayerDetailPage(VC: UIViewController,  playerId id: Int) {
        let detailInfoVC = UIStoryboard(
            name: "Home",
            bundle: nil
            // swiftlint:disable force_cast
        ).instantiateViewController(withIdentifier: Constants.shared.PlayerDetailViewController) as! PlayerDetailViewController
        detailInfoVC.loadViewIfNeeded()
        
        
        
        
        PlayerDetailViewController.viewModel.setPlayerId(byId: id)
        
        if Utilities.shared.checkInternetConnectivity() == true {
            
            PlayerDetailViewController.viewModel.getResponsePlayerData()
        }
        
        VC.navigationController?.pushViewController(detailInfoVC, animated: true)
    }
    
    
    
    @objc func searchPlayerAction(){
        if let searchTxt = searchTextField.text{
            if searchTxt != ""{
                    
                viewModel.setPlayerList(playerData: CoreDataManager.shared.getSearchData(searchText: searchTxt) ?? [])
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                viewModel.setPlayerList(playerData: CoreDataManager.shared.getSearchData(searchText: "A") ?? [])
                
                self.tableView.reloadData()
            }
        }
    }
    

 
    @IBAction func notificationBtnAction(_ sender: Any) {
        
        print("Check notification from PlayersViewController")
    }
    
}


extension PlayersViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        gotToPlayerDetailPage(VC: self, playerId: Int(viewModel.playerList?[indexPath.row].id ?? -1))
        
        
    }
}

extension PlayersViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
        cell.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.1 * Double(indexPath.row), options: [.curveEaseInOut], animations: {
            cell.transform = CGAffineTransform(translationX: 0, y: 0)

            cell.alpha = 1
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.playerList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.shared.PlayersTableViewCell, for: indexPath) as! PlayersTableViewCell
        
        cell.playerImageView.sd_setImage(with: URL(string: viewModel.playerList?[indexPath.row].imagePath ?? ""), placeholderImage: UIImage(systemName: "person"))
        
        cell.playerNameLabel.text = viewModel.playerList?[indexPath.row].fullName ?? ""
        
        
        cell.layer.cornerRadius = 15 // Set the corner radius of the cell
        cell.layer.shadowColor = UIColor.black.cgColor // Set the shadow color
        cell.layer.shadowOffset = CGSize(width: 0, height: 2) // Set the shadow offset
        cell.layer.shadowOpacity = 0.5 // Set the shadow opacity
        cell.layer.shadowRadius = 2 // Set the shadow radius
        cell.layer.masksToBounds = false // Allow the shadow to be visible outside
        
        return cell
    }
    
    
   
    
    
}
