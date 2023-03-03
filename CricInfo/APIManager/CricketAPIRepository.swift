//
//  CricketAPIRepository.swift
//  CricInfo
//
//  Created by bjit on 9/2/23.
//

import Foundation


import Foundation

enum CricketAPIResources: String {
    case fixtures, continents, officials
    case countries, leagues
    case seasons, livescores, teams
    case players, career, lineup, bowling, batting
    case league, visitorteam, localteam, runs
    case teamRankings
    
  

    
    
}

enum CricketAPIFormat: String {
    case wookiee, json
}

enum CricketAPILeagueID: String{
    
    case T20I = "3"
    case BBL = "5"
    case T20C = "10"
}

enum CricketAPIFiterStatus: String{
    case Finished, NS, Running
}

struct CricketAPIRepository {
    
    private init() {}
    static let shared = CricketAPIRepository()
    
    private let urlSession = URLSession.shared
    var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "cricket.sportmonks.com"
        return urlComponents
    }

    func getURL(with resources: CricketAPIResources, parameters: [String: String], pathId id: Int)-> URL? {
        var urlComponents = self.urlComponents
        
        if id == -1 {
            if resources == .teamRankings {
                urlComponents.path = "/api/v2.0/team-rankings"
            } else {
                urlComponents.path = "/api/v2.0/\(resources)"
            }
        }
        else
        {
            urlComponents.path = "/api/v2.0/\(resources)/\(id)"
        }
            
         
        urlComponents.setQueryItems(with: parameters)
         
        guard let url = urlComponents.url else {
            return nil
        }
      let finalURL =  url.appending(queryItems: [
            URLQueryItem(name: "api_token", value: Constants.shared.apiToken)
         ])
    return finalURL
    }
    
}

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
}
