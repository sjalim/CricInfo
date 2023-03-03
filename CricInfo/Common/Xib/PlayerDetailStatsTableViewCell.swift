//
//  PlayerDetailStatsTableViewCell.swift
//  CricInfo
//
//  Created by bjit on 23/2/23.
//

import UIKit

class PlayerDetailStatsTableViewCell: UITableViewCell {

    @IBOutlet weak var sectionLabel: UILabel!
    
    @IBOutlet weak var matchesLabel: UILabel!
    
    @IBOutlet weak var inningsLabel: UILabel!
    
    @IBOutlet weak var runsOversLabel: UILabel!
    
    @IBOutlet weak var notout_medainLabel: UILabel!
    
    @IBOutlet weak var maxsrc_runsLabel: UILabel!
    
    @IBOutlet weak var strike_ecoRateLabel: UILabel!
    
    
    @IBOutlet weak var totalFour_wideLabel: UILabel!
    
    
    @IBOutlet weak var totalSixes_noballLabel: UILabel!
    
    
    @IBOutlet weak var hundreds_wicketLabel: UILabel!
    
    
    @IBOutlet weak var fifties_rateLabel: UILabel!
    
    
    @IBOutlet weak var matchesKeyLabel: UILabel!
    
    
    @IBOutlet weak var inningsKeyLabel: UILabel!
    
    
    @IBOutlet weak var runs_oversKeyLabel: UILabel!
    
    @IBOutlet weak var notout_medianKeyLabel: UILabel!
    
    
    @IBOutlet weak var maxscr_runsKeyLabel: UILabel!
    
    @IBOutlet weak var strike_eco_rateKeyLabel: UILabel!
    
    @IBOutlet weak var totalFour_wideKeyLabel: UILabel!
    
    @IBOutlet weak var totalSixes_noballKeyLabel: UILabel!
    
    @IBOutlet weak var hundreds_wicketKeyLabel: UILabel!
    
    @IBOutlet weak var fifties_rateKeyLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    func setBatting(playerData: PlayerDetailsStatsModel?){
        
        guard let data = playerData else {
            print("Empty player data from setBatting")
            return
        }
        
        sectionLabel.text = "Batting"
        runs_oversKeyLabel.text = "Runs"
        notout_medianKeyLabel.text = "Not Out"
        maxscr_runsKeyLabel.text = "Max Score"
        strike_eco_rateKeyLabel.text = "Strike Rate"
        totalFour_wideKeyLabel.text = "Total Four"
        totalSixes_noballKeyLabel.text = "Total Sixes"
        hundreds_wicketKeyLabel.text = "Hundreds"
        fifties_rateKeyLabel.text = "Fifties"
        
        matchesLabel.text = String(data.matchesBatting)
        
        inningsLabel.text = String(data.innings)
        
        runsOversLabel.text = String(data.runsScored)
        notout_medainLabel.text = String(data.notOut)
        maxsrc_runsLabel.text = String(data.highestInningsScore)
        strike_ecoRateLabel.text = String(format: "%.2f", data.strikeRate)
        totalFour_wideLabel.text = String(data.totalFour)
        totalSixes_noballLabel.text = String(data.totalSixes)
        hundreds_wicketLabel.text = String(data.hundreds)
        fifties_rateLabel.text = String(data.fiftes)
    }
    
    func setBowling(playerData: PlayerDetailsStatsModel?){
        guard let data = playerData else {
            print("Empty player data from setBowling")
            return
        }
        sectionLabel.text = "Bowling"
        runs_oversKeyLabel.text = "Overs"
        notout_medianKeyLabel.text = "Median"
        maxscr_runsKeyLabel.text = "Runs"
        strike_eco_rateKeyLabel.text = "Economy Rate"
        totalFour_wideKeyLabel.text = "Wide"
        totalSixes_noballKeyLabel.text = "No Ball"
        hundreds_wicketKeyLabel.text = "Wickets"
        fifties_rateKeyLabel.text = "Rate"
        
        matchesLabel.text = String(data.matchesBowling)
        inningsLabel.text = String(data.innings)
        runsOversLabel.text = String(format: "%.1f", data.overs)
        notout_medainLabel.text = String(data.median)
        maxsrc_runsLabel.text = String(data.runsGive)
        strike_ecoRateLabel.text = String(format: "%.2f", data.ecoRate)
        totalFour_wideLabel.text = String(data.wide)
        hundreds_wicketLabel.text = String(data.wickets)
        fifties_rateLabel.text = String(format: "%.2f", data.rate)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
