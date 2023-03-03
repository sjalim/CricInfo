//
//  BowlingSummeryTableViewCell.swift
//  CricInfo
//
//  Created by bjit on 15/2/23.
//

import UIKit

class BowlingSummeryTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var oversLabel: UILabel!
    
    @IBOutlet weak var medianLabel: UILabel!
    
    @IBOutlet weak var runLabel: UILabel!
    
    @IBOutlet weak var wicketLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var rateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
