//
//  ScorecardModel.swift
//  CricInfo
//
//  Created by bjit on 16/2/23.
////
//
import Foundation

class BattingModel{
    
    
    let batsmanId: Int
    let fixtureID: Int
    let teamID: Int
    let active: Bool
    let playerID: Int
    let ball: Int
    let scoreID: Int
    let score: Int
    let fourX: Int
    let sixX: Int
    let catchStumpPlayerID: Int
    let bowlingPlayerID: Int
    let batsmanCountryID: Int
    let batsmanFirstname: String
    let batsmanLastname: String
    let batsmanFullname: String
    let batsmanImagePath: String
    let batsmanDateofbirth: String
    let batsmanGender: String
    let batsmanBattingstyle: String
    let batsmanPositionID: Int
    let batsmanPositionName: String
    let rate: Double
    let resultId: Int
    let resultName: String
    let resultRuns: Int
    let resultFour: Bool
    let resultSix: Bool
    let resultBye: Int
    let resultLegBye: Int
    let resultNoBall: Int
    let resultIsWicket: Bool
    let resultBall: Bool
    let resultOut: Bool
    
    init(matchData data: BattingMatchById) {
        
        
        if let batsmanId = data.id {
            
            self.batsmanId = batsmanId
        } else {
            self.batsmanId = Constants.shared.universalNullInt
            
        }
        
        if let fixtureID = data.fixtureID {
            
            self.fixtureID = fixtureID
        } else {
            self.fixtureID = Constants.shared.universalNullInt
            
        }
        
        if let teamID = data.teamID {
            
            self.teamID = teamID
        } else {
            self.teamID = Constants.shared.universalNullInt
            
        }
        
        if let active = data.active {
            
            self.active = active
        } else {
            self.active = false
            
        }
        
        if let playerID = data.playerID {
            
            self.playerID = playerID
        } else {
            self.playerID = Constants.shared.universalNullInt
            
        }
        
        if let ball = data.ball {
            
            self.ball = ball
        } else {
            self.ball = Constants.shared.universalNullInt
            
        }
        
        if let scoreID = data.scoreID {
            
            self.scoreID = scoreID
        } else {
            self.scoreID = Constants.shared.universalNullInt
            
        }
        
        if let score = data.score {
            
            self.score = score
        } else {
            self.score = Constants.shared.universalNullInt
            
        }
        
        if let fourX = data.fourX {
            
            self.fourX = fourX
        } else {
            self.fourX = Constants.shared.universalNullInt
            
        }
        
        if let sixX = data.sixX {
            
            self.sixX = sixX
        } else {
            self.sixX = Constants.shared.universalNullInt
            
        }
        
        if let catchStumpPlayerID = data.catchStumpPlayerID {
            
            self.catchStumpPlayerID = catchStumpPlayerID
        } else {
            self.catchStumpPlayerID = Constants.shared.universalNullInt
            
        }
        
        if let bowlingPlayerID = data.bowlingPlayerID {
            
            self.bowlingPlayerID = bowlingPlayerID
        } else {
            self.bowlingPlayerID = Constants.shared.universalNullInt
            
        }
        
        if let batsmanCountryID = data.batsman.countryID {
            
            self.batsmanCountryID = batsmanCountryID
        } else {
            self.batsmanCountryID = Constants.shared.universalNullInt
            
        }
        
        if let batsmanFirstname = data.batsman.firstname {
            
            self.batsmanFirstname = batsmanFirstname
        } else {
            self.batsmanFirstname = Constants.shared.universalNullStr
            
        }
        
        if let batsmanLastname = data.batsman.lastname {
            
            self.batsmanLastname = batsmanLastname
        } else {
            self.batsmanLastname = Constants.shared.universalNullStr
            
        }
        
        if let batsmanFullname = data.batsman.fullname {
            
            self.batsmanFullname = batsmanFullname
        } else {
            self.batsmanFullname = Constants.shared.universalNullStr
            
        }
        
        if let batsmanImagePath = data.batsman.imagePath {
            
            self.batsmanImagePath = batsmanImagePath
        } else {
            self.batsmanImagePath = Constants.shared.universalNullStr
            
        }
        
        if let batsmanDateofbirth = data.batsman.dateofbirth {
            
            self.batsmanDateofbirth = batsmanDateofbirth
        } else {
            self.batsmanDateofbirth = Constants.shared.universalNullStr
            
        }
        
        if let batsmanGender = data.batsman.gender {
            
            self.batsmanGender = batsmanGender
        } else {
            self.batsmanGender = Constants.shared.universalNullStr
            
        }
        
        if let batsmanBattingstyle = data.batsman.battingstyle {
            
            self.batsmanBattingstyle = batsmanBattingstyle
        } else {
            self.batsmanBattingstyle = Constants.shared.universalNullStr
            
        }
        
        if let batsmanPositionID = data.batsman.position?.id {
            
            self.batsmanPositionID = batsmanPositionID
        } else {
            self.batsmanPositionID = Constants.shared.universalNullInt
            
        }
        
        if let batsmanPositionName = data.batsman.position?.name {
            
            self.batsmanPositionName = batsmanPositionName
        } else {
            self.batsmanPositionName = Constants.shared.universalNullStr
            
        }
        
        if let rate = data.rate {
            
            self.rate = rate
        } else {
            self.rate = Constants.shared.universalNullDouble
            
        }
        
        if let resultId = data.result?.id {
            
            self.resultId = resultId
        } else {
            self.resultId = Constants.shared.universalNullInt
            
        }
        
        if let resultName = data.result?.name {
            self.resultName = resultName
            
        } else {
            self.resultName = Constants.shared.universalNullStr
            
        }
        
        if let resultRuns = data.result?.runs {
            
            self.resultRuns = resultRuns
        } else {
            self.resultRuns = Constants.shared.universalNullInt
            
        }
        
        if let resultFour = data.result?.four {
            
            self.resultFour = resultFour
        } else {
            self.resultFour = false
            
        }
        
        if let resultSix = data.result?.six {
            
            self.resultSix = resultSix
        } else {
            self.resultSix = false
            
        }
        
        if let resultBye = data.result?.bye {
            
            self.resultBye = resultBye
        } else {
            self.resultBye = Constants.shared.universalNullInt
            
        }
        
        if let resultLegBye = data.result?.legBye {
            
            self.resultLegBye = resultLegBye
        } else {
            self.resultLegBye = Constants.shared.universalNullInt
            
        }
        
        if let resultNoBall = data.result?.noball {
            
            self.resultNoBall = resultNoBall
        } else {
            self.resultNoBall = Constants.shared.universalNullInt
            
        }
        
        if let resultIsWicket = data.result?.isWicket {
            
            self.resultIsWicket = resultIsWicket
        } else {
            self.resultIsWicket = false
            
        }
        
        if let resultBall = data.result?.ball{
            
            self.resultBall = resultBall
        } else {
            self.resultBall = false
            
        }
        
        if let resultOut = data.result?.out {
            
            self.resultOut = resultOut
        } else {
            self.resultOut = false
        }
        
    }
    
}

class ScoreCardModel{
    
    let localTeamName: String
    let localTeamScore: Int
    let localTeamWickets: Int
    let localTeamOvers: Double
    
    let visitorTeamName: String
    let visitorTeamScore: Int
    let visitorTeamWickets: Int
    let visitorTeamOvers: Double
    
    
    init(matchData data: DataClassMatchById) {
        
        var localTeamRunsIndex: Int = 0
        var visitorTeamRunsIndex: Int = 1
        
        if let localTeamName = data.localteam?.name {
            
            self.localTeamName = localTeamName
        } else{
            self.localTeamName = Constants.shared.universalNullStr
            
        }
        
        if let visitorTeamName = data.visitorteam?.name {
            
            self.visitorTeamName = visitorTeamName
        } else{
            self.visitorTeamName = Constants.shared.universalNullStr
            
        }
        
        if data.runs.count > 0 {
            
            
            if data.localteamID == data.runs[0]?.teamID{
                localTeamRunsIndex = 0
                visitorTeamRunsIndex = 1
            } else {
                localTeamRunsIndex = 1
                visitorTeamRunsIndex = 0
                
            }
            
            if let localTeamScore = data.runs[localTeamRunsIndex]?.score {
                self.localTeamScore = localTeamScore
            } else{
                self.localTeamScore = Constants.shared.universalNullInt
            }
            
            if let localTeamWickets = data.runs[localTeamRunsIndex]?.wickets {
                
                self.localTeamWickets = localTeamWickets
                
            } else{
                self.localTeamWickets = Constants.shared.universalNullInt
                
            }
            
            if let localTeamOvers = data.runs[localTeamRunsIndex]?.overs {
                
                self.localTeamOvers = localTeamOvers
            } else{
                self.localTeamOvers = Constants.shared.universalNullDouble
                
            }
            
            if let visitorTeamScore = data.runs[visitorTeamRunsIndex]?.score {
                
                self.visitorTeamScore = visitorTeamScore
            } else{
                self.visitorTeamScore = Constants.shared.universalNullInt
                
            }
            
            if let visitorTeamWickets = data.runs[visitorTeamRunsIndex]?.wickets {
                
                self.visitorTeamWickets = visitorTeamWickets
            } else{
                self.visitorTeamWickets = Constants.shared.universalNullInt
                
            }
            
            if let visitorTeamOvers = data.runs[visitorTeamRunsIndex]?.overs {
                self.visitorTeamOvers = visitorTeamOvers
            } else{
                self.visitorTeamOvers = Constants.shared.universalNullDouble
            }
            
        } else {
            self.localTeamScore = Constants.shared.universalNullInt
            self.localTeamWickets = Constants.shared.universalNullInt
            self.localTeamOvers = Constants.shared.universalNullDouble
            self.visitorTeamScore = Constants.shared.universalNullInt
            self.visitorTeamWickets = Constants.shared.universalNullInt
            self.visitorTeamOvers = Constants.shared.universalNullDouble

        }
        
        
        
    }
}

class BowlingModel{
    
    let overs: Double
    let medians: Int
    let wickets: Int
    let wide: Int
    let noBall: Int
    let rate: Double
    let teamID: Int
    let runs: Int
    let bowlerPlayerId: Int
    let bowlerFullName: String
    let bowlerFirstName: String
    let bowlerLastName: String
    let bowlerCountryId: Int
    let bowlerImagePath: String
    let bowlerDateOfBirth: String
    let bowlerGender: String
    let bowlerBattingStyle: String
    let bowlerBowlingStyle: String
    let bowlerPositionName: String
    
    init(matchData data: BowlingMatchById) {
        
        if let teamID = data.teamID{
            self.teamID = teamID
        } else {
            self.teamID = Constants.shared.universalNullInt

        }
        
        if let bowlerPlayerId = data.bowler?.id{
            
            self.bowlerPlayerId = bowlerPlayerId
        } else {
            self.bowlerPlayerId = Constants.shared.universalNullInt
            
        }
        
        if let bowlerFullName = data.bowler?.fullname{
            
            self.bowlerFullName = bowlerFullName
        } else {
            self.bowlerFullName = Constants.shared.universalNullStr
            
        }
        
        if let bowlerFirstName = data.bowler?.firstname{
            
            self.bowlerFirstName = bowlerFirstName
        } else {
            self.bowlerFirstName = Constants.shared.universalNullStr
            
        }
        
        if let bowlerLastName = data.bowler?.lastname{
            
            self.bowlerLastName = bowlerLastName
        } else {
            self.bowlerLastName = Constants.shared.universalNullStr
            
        }
        
        if let bowlerCountryId = data.bowler?.countryID{
            
            self.bowlerCountryId = bowlerCountryId
        } else {
            self.bowlerCountryId = Constants.shared.universalNullInt
            
        }
        
        if let bowlerImagePath = data.bowler?.imagePath{
            self.bowlerImagePath = bowlerImagePath
        } else {
            self.bowlerImagePath = Constants.shared.universalNullStr
        }
        
        if let bowlerDateOfBirth = data.bowler?.dateofbirth{
            self.bowlerDateOfBirth = bowlerDateOfBirth
            
        } else {
            self.bowlerDateOfBirth = Constants.shared.universalNullStr
            
        }
        
        if let bowlerGender = data.bowler?.gender{
            self.bowlerGender = bowlerGender
            
        } else {
            self.bowlerGender = Constants.shared.universalNullStr
            
        }
        
        if let bowlerBattingStyle = data.bowler?.battingstyle{
            self.bowlerBattingStyle = bowlerBattingStyle
            
        } else {
            self.bowlerBattingStyle = Constants.shared.universalNullStr
            
        }
        
        if let bowlerBowlingStyle = data.bowler?.bowlingstyle{
            self.bowlerBowlingStyle = bowlerBowlingStyle
            
        } else {
            self.bowlerBowlingStyle = Constants.shared.universalNullStr

        }
        
        if let bowlerPositionName = data.bowler?.position?.name{
            self.bowlerPositionName = bowlerPositionName
            
        } else {
            self.bowlerPositionName = Constants.shared.universalNullStr

        }
        
        if let overs = data.overs{
            self.overs = overs
            
        } else {
            self.overs = Constants.shared.universalNullDouble
            
        }
        
        if let medians = data.medians{
            self.medians = medians
            
        } else {
            self.medians = Constants.shared.universalNullInt
        }
        
        if let wickets = data.wickets{
            self.wickets = wickets
            
        } else {
            self.wickets = Constants.shared.universalNullInt
            
        }
        
        if let wide = data.wide{
            self.wide = wide
        } else {
            self.wide = Constants.shared.universalNullInt
        }
        
        if let noBall = data.noball{
            self.noBall = noBall
        } else {
            self.noBall = Constants.shared.universalNullInt
        }
        
        if let rate = data.rate{
            self.rate = rate
        } else {
            self.rate = Constants.shared.universalNullDouble
        }
        
        if let runs = data.runs{
            self.runs = runs
        } else {
            self.runs = Constants.shared.universalNullInt
        }
        
    }
}
