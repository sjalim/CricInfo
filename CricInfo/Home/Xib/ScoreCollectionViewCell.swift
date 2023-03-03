//
//  ScoreCollectionViewCell.swift
//  CricInfo
//
//  Created by bjit on 10/2/23.
//

import UIKit

class ScoreCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var liveIndicatorImageView: UIImageView!
    
    
    
    @IBOutlet weak var matchDate: UILabel!
    
    @IBOutlet weak var shortDesc: UILabel!
    
    @IBOutlet weak var teamFlag1: UIImageView!
    
    @IBOutlet weak var teamCode1: UILabel!
    @IBOutlet weak var teamScoreCard1: UILabel!
    @IBOutlet weak var teamOvers1: UILabel!
    
    @IBOutlet weak var teamFlag2: UIImageView!
    
    @IBOutlet weak var teamCode2: UILabel!
    
    @IBOutlet weak var teamScoreCard2: UILabel!
    
    @IBOutlet weak var teamOvers2: UILabel!
    
    @IBOutlet weak var winText: UILabel!
    
    @IBOutlet weak var winShortDetails: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        //        teamFlag1.layer.cornerRadius = 45
        //        teamFlag2.layer.cornerRadius = 45
        
        
        containerView.layer.cornerRadius = 15 // Set the corner radius of the cell
        containerView.layer.shadowColor = UIColor.black.cgColor // Set the shadow color
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2) // Set the shadow offset
        containerView.layer.shadowOpacity = 0.5 // Set the shadow opacity
        containerView.layer.shadowRadius = 2 // Set the shadow radius
        containerView.layer.masksToBounds = false // Allow the shadow to be visible outside
        
    }
    
    func setData(data: DatumLive){
        matchDate.text = Utilities.shared.getFormattedDate(at: data.startingAt)
        shortDesc.text = data.type + ", " + data.league.name + ", " + data.season.name
        
        //        winText.text = Utilities.shared.getWinningNotePrefix(from: data.note)
        winText.text = data.status
        
        //        winShortDetails.text = "by " + Utilities.shared.getWinningNoteExtension(from: data.note)
        winShortDetails.text = ""
        
        
        if data.status == "1st Innings" || data.status == "Innings Break"{
            
            if data.localteam.id == data.runs[0].teamID{
                teamFlag1.sd_setImage(with: URL(string: data.localteam.imagePath ?? ""), placeholderImage: UIImage(systemName: "flag"))
                teamCode1.text = data.localteam.code
                teamScoreCard1.text = String(data.runs[0].score) + " - " + String(data.runs[0].wickets)
                teamOvers1.text = String(data.runs[0].overs)
                
                
                teamFlag2.sd_setImage(with: URL(string: data.visitorteam.imagePath ?? ""), placeholderImage: UIImage(systemName: "flag.fill"))
                teamCode2.text = data.visitorteam.code
                
                teamScoreCard2.text = "Yet To Play"
                teamOvers2.text = ""
                //                teamScoreCard2.text = String(data.runs[1].score)
                //                + " - " + String(data.runs[1].wickets)
                //                teamOvers2.text = String(data.runs[1].overs)
            }
            else
            {
                teamFlag2.sd_setImage(with: URL(string: data.localteam.imagePath ?? ""), placeholderImage: UIImage(systemName: "flag"))
                teamCode2.text = data.localteam.code
                teamScoreCard2.text = String(data.runs[0].score) + " - " + String(data.runs[0].wickets)
                teamOvers2.text = String(data.runs[0].overs)
                
                
                teamFlag1.sd_setImage(with: URL(string: data.visitorteam.imagePath ?? ""), placeholderImage: UIImage(systemName: "flag.fill"))
                teamCode1.text = data.visitorteam.code
                
                teamScoreCard1.text = "Yet To Play"
                //                teamScoreCard1.text = String(data.runs[1].score)
                //                + " - " + String(data.runs[1].wickets)
                //                teamOvers1.text = String(data.runs[1].overs)
            }
        } else if  data.status == "2nd Innings"{
            if data.localteam.id == data.runs[0].teamID{
                teamFlag1.sd_setImage(with: URL(string: data.localteam.imagePath ?? ""), placeholderImage: UIImage(systemName: "flag"))
                teamCode1.text = data.localteam.code
                teamScoreCard1.text = String(data.runs[0].score) + " - " + String(data.runs[0].wickets)
                teamOvers1.text = String(data.runs[0].overs)
                
                
                teamFlag2.sd_setImage(with: URL(string: data.visitorteam.imagePath ?? ""), placeholderImage: UIImage(systemName: "flag.fill"))
                teamCode2.text = data.visitorteam.code
                teamScoreCard2.text = String(data.runs[1].score)
                + " - " + String(data.runs[1].wickets)
                teamOvers2.text = String(data.runs[1].overs)
            }
            else
            {
                teamFlag2.sd_setImage(with: URL(string: data.localteam.imagePath ?? ""), placeholderImage: UIImage(systemName: "flag"))
                teamCode2.text = data.localteam.code
                teamScoreCard2.text = String(data.runs[0].score) + " - " + String(data.runs[0].wickets)
                teamOvers2.text = String(data.runs[0].overs)
                
                
                teamFlag1.sd_setImage(with: URL(string: data.visitorteam.imagePath ?? ""), placeholderImage: UIImage(systemName: "flag.fill"))
                teamCode1.text = data.visitorteam.code
                teamScoreCard1.text = String(data.runs[1].score)
                + " - " + String(data.runs[1].wickets)
                teamOvers1.text = String(data.runs[1].overs)
            }
            
        }
    }
    
    func setData(data: DatumRecetMatches)
    {
        matchDate.text = Utilities.shared.getFormattedDate(at: data.startingAt)
        shortDesc.text = data.type! + ", " + data.league.name + ", " + data.season.name
        
        winText.text = Utilities.shared.getWinningNotePrefix(from: data.note)
        
        winShortDetails.text = "by " + Utilities.shared.getWinningNoteExtension(from: data.note)
        
        if data.runs.count > 1 {
            
            
            if data.localteam.id == data.runs[0].teamID{
                teamFlag1.sd_setImage(with: URL(string: data.localteam.imagePath ?? ""), placeholderImage: UIImage(systemName: "flag"))
                teamCode1.text = data.localteam.code
                teamScoreCard1.text = String(data.runs[0].score) + " - " + String(data.runs[0].wickets)
                teamOvers1.text = String(data.runs[0].overs)
                
                teamFlag2.sd_setImage(with: URL(string: data.visitorteam.imagePath ?? ""), placeholderImage: UIImage(systemName: "flag.fill"))
                teamCode2.text = data.visitorteam.code
                teamScoreCard2.text = String(data.runs[1].score)
                + " - " + String(data.runs[1].wickets)
                teamOvers2.text = String(data.runs[1].overs)
            }
            else
            {
                teamFlag2.sd_setImage(with: URL(string: data.localteam.imagePath ?? ""), placeholderImage: UIImage(systemName: "flag"))
                teamCode2.text = data.localteam.code
                teamScoreCard2.text = String(data.runs[0].score) + " - " + String(data.runs[0].wickets)
                teamOvers2.text = String(data.runs[0].overs)
                
                
                teamFlag1.sd_setImage(with: URL(string: data.visitorteam.imagePath ?? ""), placeholderImage: UIImage(systemName: "flag.fill"))
                teamCode1.text = data.visitorteam.code
                teamScoreCard1.text = String(data.runs[1].score)
                + " - " + String(data.runs[1].wickets)
                teamOvers1.text = String(data.runs[1].overs)
            }
        }
    }
    
}
