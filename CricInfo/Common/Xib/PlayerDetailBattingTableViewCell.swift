//
//  PlayerDetailBattingTableViewCell.swift
//  CricInfo
//
//  Created by Mafruha Leavin on 19.2.2023.
//

import UIKit

class PlayerDetailBattingTableViewCell: UITableViewCell {
    @IBOutlet weak var leagueLabel: UILabel!
    
    @IBOutlet weak var matchesCountLabel: UILabel!
    
    @IBOutlet weak var inningsLabel: UILabel!
    
    @IBOutlet weak var runsLabel: UILabel!
    
    @IBOutlet weak var notOutLabel: UILabel!
    
    @IBOutlet weak var maxInnScrLabel: UILabel!
    
    @IBOutlet weak var strikeRateLabel: UILabel!
    
    @IBOutlet weak var ballsFacedLabel: UILabel!
    
    @IBOutlet weak var averagesLabel: UILabel!
    
    @IBOutlet weak var totalFoursLabel: UILabel!
    
    @IBOutlet weak var totalSixesLabel: UILabel!
    
    @IBOutlet weak var hundredsLabel: UILabel!
    
    @IBOutlet weak var fiftiesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
