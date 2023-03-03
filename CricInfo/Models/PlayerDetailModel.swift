//
//  PlayerDetailModel.swift
//  CricInfo
//
//  Created by Mafruha Leavin on 19.2.2023.
//

import Foundation


class PlayerDetailModel{
    
    
    let fullName: String
    let lastName: String
    let firstName: String
    let imagePath: String
    let age: String
    let gender: String
    let battingStyle: String
    let bowlingStyle: String
    let role: String
    let dateOfBirth: String
    let countryImagePath: String
    let countryName: String
    
    init(playerData data: DataClassPlayerById) {
        
        if let fullName = data.fullname {
            self.fullName = fullName
            
        } else {
            self.fullName = Constants.shared.universalNullStr
        }
        
        if let lastName = data.lastname {
            
            self.lastName = lastName
        } else {
            self.lastName = Constants.shared.universalNullStr

        }
        
        if let firstName = data.firstname {
            
            self.firstName = firstName
        } else {
            self.firstName = Constants.shared.universalNullStr

        }
        
        if let imagePath = data.imagePath {
            
            self.imagePath = imagePath
        } else {
            self.imagePath = Constants.shared.universalNullStr

        }
        
        if let gender = data.gender {
            
            if gender == "m"{
                
                self.gender = "male"
            } else {
                self.gender = "Female"

            }
            
        } else {
            self.gender = Constants.shared.universalNullStr

        }
        
        if let battingStyle = data.battingstyle {
            
            self.battingStyle = battingStyle
        } else {
            self.battingStyle = "None"

        }
        
        if let bowlingStyle = data.bowlingstyle {
            
            self.bowlingStyle = bowlingStyle
        } else {
            self.bowlingStyle = "None"

        }
        
        if let role = data.position?.name {
            self.role = role
            
        } else {
            self.role = Constants.shared.universalNullStr

        }
        
        if let dateOfBirth = data.dateofbirth {
            self.dateOfBirth = dateOfBirth
            self.age = Utilities.shared.getCalculatedAge(byDateOfBirth: dateOfBirth)
            
        } else {
            self.dateOfBirth = Constants.shared.universalNullStr
            self.age = Constants.shared.universalNullStr
        }
        
        if let countryImagePath = data.country?.imagePath{
            self.countryImagePath = countryImagePath
        } else {
            self.countryImagePath = Constants.shared.universalNullStr

        }
        
        if let countryName = data.country?.name {
            
            self.countryName = countryName
        } else {
            self.countryName = Constants.shared.universalNullStr
        }
        
        
    }
    
    
    
}
