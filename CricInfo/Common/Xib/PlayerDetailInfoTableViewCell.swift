//
//  PlayerDetailInfoTableViewCell.swift
//  CricInfo
//
//  Created by bjit on 17/2/23.
//

import UIKit

class PlayerDetailInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var contentTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
