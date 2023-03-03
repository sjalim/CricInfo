//
//  RankTableViewCell.swift
//  CricInfo
//
//  Created by bjit on 22/2/23.
//

import UIKit

class RankTableViewCell: UITableViewCell {

    @IBOutlet weak var rankSerialNumLabel: UILabel!
    
    @IBOutlet weak var rankImageViewLabel: UIImageView!
    
    @IBOutlet weak var rankTeamNameLabel: UILabel!
    
    
    @IBOutlet weak var rankPointsLabel: UILabel!
    
    @IBOutlet weak var rankRatingLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
