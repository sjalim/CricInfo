//
//  FixtureTableViewCell.swift
//  CricInfo
//
//  Created by bjit on 20/2/23.
//

import UIKit

class FixtureTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var containerUIView: UIView!
    @IBOutlet weak var teamFlag1: UIImageView!
    
    @IBOutlet weak var teamFlag2: UIImageView!
    
    @IBOutlet weak var teamName1: UILabel!
    
    
    @IBOutlet weak var teamName2: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
