//
//  BattingSummeryTableViewCell.swift
//  CricInfo
//
//  Created by bjit on 15/2/23.
//

import UIKit

class BattingSummeryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var runLabel: UILabel!
    
    @IBOutlet weak var fourLabel: UILabel!
    
    @IBOutlet weak var bowlLabel: UILabel!
    
    @IBOutlet weak var sixLabel: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    
    @IBOutlet weak var OutStatusLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        containerView.dropShadow()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(data: DatumLive){
        
        
        
    }
    
}
