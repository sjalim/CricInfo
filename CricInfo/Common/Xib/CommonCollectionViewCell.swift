//
//  CommonCollectionViewCell.swift
//  CricInfo
//
//  Created by bjit on 23/2/23.
//

import UIKit

class CommonCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 15 // Set the corner radius of the cell
        containerView.layer.shadowColor = UIColor.black.cgColor // Set the shadow color
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2) // Set the shadow offset
        containerView.layer.shadowOpacity = 0.5 // Set the shadow opacity
        containerView.layer.shadowRadius = 2 // Set the shadow radius
        containerView.layer.masksToBounds = false

    }

}
