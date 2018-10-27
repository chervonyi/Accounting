//
//  Day.swift
//  Accounting
//
//  Created by Yuri Chervonyi on 10/25/18.
//  Copyright © 2018 Red Inc. All rights reserved.
//

import Foundation

class Day {
    
    var timeIn: String? = nil
    
    var timeOut: String? = nil
    
    var breakDuration: Int
    
    private(set) var date: Date

    var workingTime: String {
        var minutes = workingTimeInMinutes
        let hrs = Int(minutes / 60)
        minutes = minutes - hrs * 60
        return "\(hrs) hrs \(minutes) min"
    }
    
    var workingTimeInMinutes: Int {
        if timeIn == nil || timeOut == nil {
            return 0
        }
        
        var difference = getMinutes(timeOut!) - getMinutes(timeIn!)
        difference -= breakDuration
        return difference > 0 ? difference : 0
    }
    
    var salary: Double {
        return Double(workingTimeInMinutes) * IncomeCalendar.salaryPerMin
    }
    
    init(_ newDate: Date) {
        date = newDate
        breakDuration = 0
    }
    
    private func getMinutes(_ time: String) -> Int {
        // 05:20 PM || 5:20 PM
        let parts = time.components(separatedBy: " ")
        if let numbers = parts.first {
            let partsOfNUmbers = numbers.components(separatedBy: ":")
            if partsOfNUmbers.count == 2 {
                var hrs = Int(partsOfNUmbers.first!)!
                let min = Int(partsOfNUmbers.last!)!
                
                if parts.last == "PM" {
                    hrs += 12
                }
                
                let res = hrs * 60 + min
                return res
            }
        }
        
        return 0
    }
}

extension String {
    func substring(from: Int, to: Int) -> String{
        let myNSString = self as NSString
        return myNSString.substring(with: NSRange(location: from, length: to - from))
        
    }
}

