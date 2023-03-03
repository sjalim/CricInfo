//
//  SquadTableViewCell.swift
//  CricInfo
//
//  Created by bjit on 16/2/23.
//

import UIKit

class SquadTableViewCell: UITableViewCell {

    @IBOutlet weak var playerImageView: UIImageView!
    
    
    @IBOutlet weak var playerPositionLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        playerImageView.layer.cornerRadius = 30
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
