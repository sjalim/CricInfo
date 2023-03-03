//
//  Utilities.swift
//  CricInfo
//
//  Created by bjit on 9/2/23.
//

import Foundation
import UIKit
import SystemConfiguration


class Utilities{
    
    
    
    static let shared = Utilities()
    
    let defaults = UserDefaults.standard

    
    private init(){}
    
    func getDayStartTime(at date: Date)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var dateString = dateFormatter.string(from: date)
        
        return dateString + "T00:00:00.000000Z"
    }
    
    func chechDarkModeStatus() {
        
        if defaults.bool(forKey: Constants.shared.DarkMode) {
            let window = UIApplication.shared.windows[0]
            window.overrideUserInterfaceStyle = .dark
        } else {
            let window = UIApplication.shared.windows[0]
            window.overrideUserInterfaceStyle = .light
        }
        
    }
    
    func getDayEndTime(at date: Date) -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var dateString = dateFormatter.string(from: date)
        
        return dateString + "T24:00:00.000000Z"

    }
    
    func getFormattedDate(at date: Date)-> String{
        // Convert string to Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM,yyyy"

        let dateString = dateFormatter.string(from: date)

        return dateString
    }
    
    
    func getFormattedDate(at dateString: String) -> String
    {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"

        // Convert string to Date
        let convertedDate = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "dd MMM,yyyy"

        guard let curDate = convertedDate else{
            return ""
        }
        // Convert Date to string
        let dateString = dateFormatter.string(from: curDate)
        
        return dateString
    }
    
    func getWinningNoteExtension(from text: String) -> String
    {
        
        if let range = text.range(of: "by") {
            let position = range.upperBound
            let after = text[position...]
            return String(after)
        } else {
            print("Error: in getWinningNoteExtension()")
            return ""
        }
    }
    
    
    func getWinningNotePrefix(from text: String) -> String
    {
        
        if let range = text.range(of: " by") {
            let position = range.lowerBound
            let before = text[...position]
            return String(before)
        } else {
            print("Error: in getWinningNotePrefix()")
            return ""
        }
    }
     
    func getFormattedDate(with dateString: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Dhaka")
        print("date getFormattedDate:", dateString)
        // Convert string to Date
        guard let convertedDate = dateFormatter.date(from: dateString) else {
            print("There is no date.")
            return Date()
        }
        
        print("formattedDate:", convertedDate.description)
        
        return convertedDate
    }
    
    func getFormattedTime(with dateString: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")

        // Convert string to Date
        let convertedDate = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Dhaka")
        
        guard let curDate = convertedDate else{
            return ""
        }
        // Convert Date to string
        let timeString = dateFormatter.string(from: curDate)
        
        return timeString
    }
    
    
    func getCalculatedAge(byDateOfBirth dateString: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        print("dateString:", dateString)
        // Convert string to Date
        let birthDate = dateFormatter.date(from: dateString)
       
        let currentDate = Date()

        let calendar = Calendar.current
        
        guard let birthDate = birthDate else {
            print("Error: getCalculatedAge() 1")
            return ""
        }
        
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: currentDate)
        let age = ageComponents.year
        guard let age = age else {
            print("Error: getCalculatedAge() 2")
            return ""
        }
        
        return String(age)
    }
    
    
    func checkInternetConnectivity() -> Bool {

        var addressDetails = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        addressDetails.sin_len = UInt8(MemoryLayout.size(ofValue: addressDetails))
        addressDetails.sin_family = sa_family_t(AF_INET)

        let routeReachability = withUnsafePointer(to: &addressDetails) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(routeReachability!, &flags) == false {
            return false
        }
        
        let checkReachability = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let result = (checkReachability && !needConnection)

        return result

    }
    
    
    func getCurrentTime() -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentTimeString = dateFormatter.string(from: Date())
        
        let currentDate = dateFormatter.date(from: currentTimeString)
        
        guard let date = currentDate else {
            return Date()
        }
        
        return date
        
        
    }
    
    func getReadableCounter(timeInSeconds: Double) -> String? {
             let formatter = DateComponentsFormatter()
             formatter.allowedUnits = [.day, .hour, .minute, .second]
             formatter.zeroFormattingBehavior = .dropAll
             formatter.unitsStyle = .abbreviated
             formatter.maximumUnitCount = 4

            let formattedDuration = formatter.string(from: timeInSeconds)
            return formattedDuration
         }
}

extension UIView {
    /// show drop shadow under view
    /// - Parameter scale: bool variable to enable scaling
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 10
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1

    }
}




extension UITableViewCell{
    
    
        func dropShadowCell() {
        self.layer.cornerRadius = 8 // Set the corner radius of the cell
        self.layer.shadowColor = UIColor.black.cgColor // Set the shadow color
        self.layer.shadowOffset = CGSize(width: 0, height: 2) // Set the shadow offset
        self.layer.shadowOpacity = 0.5 // Set the shadow opacity
        self.layer.shadowRadius = 2 // Set the shadow radius
        self.layer.masksToBounds = false // Allow the shadow to be visible outside the cell
    }
}

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
