//
//  PlayersTableViewCell.swift
//  CricInfo
//
//  Created by bjit on 21/2/23.
//

import UIKit

class PlayersTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var playerNameLabel: UILabel!
    
    
    @IBOutlet weak var playerImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 15
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
