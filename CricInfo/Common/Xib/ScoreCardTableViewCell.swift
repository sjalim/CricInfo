//
//  ScoreCardTableViewCell.swift
//  CricInfo
//
//  Created by bjit on 15/2/23.
//

import UIKit

class ScoreCardTableViewCell: UITableViewCell {
    @IBOutlet weak var oversLabel: UILabel!
    @IBOutlet weak var scoreCardLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
