//
//  PlayerDetailBowlingTableViewCell.swift
//  CricInfo
//
//  Created by bjit on 20/2/23.
//

import UIKit

class PlayerDetailBowlingTableViewCell: UITableViewCell {

    @IBOutlet weak var oversLabel: UILabel!
    
    @IBOutlet weak var leagueLabel: UILabel!
    
    @IBOutlet weak var matchesLabel: UILabel!
    
    @IBOutlet weak var inningsLabel: UILabel!
    
    @IBOutlet weak var runsLabel: UILabel!
    
    @IBOutlet weak var medainsLabel: UILabel!
    
    @IBOutlet weak var ecoRateLabel: UILabel!
    
    @IBOutlet weak var wicketsLabel: UILabel!
    
    @IBOutlet weak var averageLabel: UILabel!
    
    @IBOutlet weak var wideLabel: UILabel!
    
    @IBOutlet weak var noBallLabel: UILabel!

    @IBOutlet weak var strinkeRateLabel: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
