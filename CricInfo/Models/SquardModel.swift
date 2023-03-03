//
//  SquardModel.swift
//  CricInfo
//
//  Created by bjit on 17/2/23.
//

import Foundation

class SquadModel {
    
    
    let playerId: Int
    let countryId: Int
    let firstName: String
    let lastName: String
    let fullName: String
    let imagePath: String
    let dateOfBirth: String
    let gender: String
    let battingStyle: String
    let bowlingStyle: String
    let positionName: String
    let teamID: Int
    let captain: Bool
    let wicketKeeper: Bool
    let substitution: Bool
    
    
    init(matchData data: LineupElementMatchById) {
        
        if let playerId = data.id{
            
            self.playerId = playerId
        } else {
            self.playerId = Constants.shared.universalNullInt

        }
        
        if let countryId = data.countryID{
            
            self.countryId = countryId
        } else {
            self.countryId = Constants.shared.universalNullInt

        }
        
        if let firstName = data.firstname{
            
            self.firstName = firstName
        } else {
            self.firstName = Constants.shared.universalNullStr

        }
        if let lastName = data.lastname{
            
            self.lastName = lastName
        } else {
            self.lastName = Constants.shared.universalNullStr

        }
        if let fullName = data.fullname{
            
            self.fullName = fullName
        } else {
            self.fullName = Constants.shared.universalNullStr

        }
        if let imagePath = data.imagePath{
            
            self.imagePath = imagePath
        } else {
            self.imagePath = Constants.shared.universalNullStr

        }
        if let dateOfBirth = data.dateofbirth{
            
            self.dateOfBirth = dateOfBirth
        } else {
            self.dateOfBirth = Constants.shared.universalNullStr

        }
        if let gender = data.gender{
            
            self.gender = gender
        } else {
            self.gender = Constants.shared.universalNullStr

        }
        
        if let battingStyle = data.battingstyle{
            
            self.battingStyle = battingStyle
        } else {
            self.battingStyle = Constants.shared.universalNullStr

        }
        
        if let bowlingStyle = data.bowlingstyle{
            
            self.bowlingStyle = bowlingStyle
        } else {
            self.bowlingStyle = Constants.shared.universalNullStr

        }
        if let positionName = data.position?.name{
            
            self.positionName = positionName
        } else {
            self.positionName = Constants.shared.universalNullStr

        }
        if let teamID = data.lineup?.teamID{
            
            self.teamID = teamID
        } else {
            self.teamID = Constants.shared.universalNullInt

        }
        if let captain = data.lineup?.captain{
            
            self.captain = captain
        } else {
            self.captain = false

        }
        if let wicketKeeper = data.lineup?.wicketkeeper{
            
            self.wicketKeeper = wicketKeeper
        } else {
            self.wicketKeeper = false

        }
        if let substitution = data.lineup?.substitution{
            
            self.substitution = substitution
        } else {
            self.substitution = false

        }
    }
    
}
