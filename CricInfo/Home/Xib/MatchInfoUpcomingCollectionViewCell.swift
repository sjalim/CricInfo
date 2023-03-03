//
//  MatchInfoUpcomingCollectionViewCell.swift
//  CricInfo
//
//  Created by bjit on 13/2/23.
//

import UIKit
import SDWebImage

class MatchInfoUpcomingCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var matchDate: UILabel!
    
    @IBOutlet weak var shortDesc: UILabel!
    
    @IBOutlet weak var teamFlag1: UIImageView!
    
    @IBOutlet weak var teamFlag2: UIImageView!
    
    @IBOutlet weak var matchStartTime: UILabel!
    
    @IBOutlet weak var teamName1: UILabel!
    
    @IBOutlet weak var teamName2: UILabel!
    
    var timerInterval: Double = 0.0
    var timer: Timer?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        containerView.layer.cornerRadius = 15 // Set the corner radius of the cell
        containerView.layer.shadowColor = UIColor.black.cgColor // Set the shadow color
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2) // Set the shadow offset
        containerView.layer.shadowOpacity = 0.5 // Set the shadow opacity
        containerView.layer.shadowRadius = 2 // Set the shadow radius
        containerView.layer.masksToBounds = false // Allow the shadow to be visible outside
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        timer?.invalidate()
    }
    
    
    func setData(data: DatumUpcomingMatches)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        guard let upcomingMatchDate = dateFormatter.date(from: data.startingAt) else {
            return
        }
        
        timerInterval =  upcomingMatchDate - Utilities.shared.getCurrentTime()
        
        self.timer?.invalidate()
        
      
        teamFlag1.sd_setImage(with: URL(string: data.localteam.imagePath ?? ""), placeholderImage: UIImage(systemName: "flag"))
        
        teamName1.text = data.localteam.name
        //
        teamName2.text = data.visitorteam.name
        teamFlag2.sd_setImage(with: URL(string: data.visitorteam.imagePath ?? ""), placeholderImage: UIImage(systemName: "flag.fill"))
        
        matchDate.text = Utilities.shared.getFormattedDate(at: data.startingAt)
        shortDesc.text = data.type! + ", " + data.league.name + ", " + data.season.name
        
        matchStartTime.text = Utilities.shared.getFormattedTime(with: data.startingAt)
        
        
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ [weak self]
            timer in
            
            guard let self = self else { return }
            
            if self.timerInterval > 0 {
                self.timerInterval -= 1
            }
            DispatchQueue.main.async {
                
                self.timerLabel.text = Utilities.shared.getReadableCounter(timeInSeconds:  self.timerInterval)
            }
            
        }
        
    }
    
}
