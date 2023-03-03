//
//  SettingsDetailViewModel.swift
//  CricInfo
//
//  Created by bjit on 26/2/23.
//

import Foundation


class SettingsDetailViewModel {
    
    
    @Published var labelData: String?
    @Published var headingData: String?
    
    func setData(data: String, headingData: String) {
        
        self.labelData = data
        self.headingData = headingData
    }
}
