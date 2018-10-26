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
        var hrs = Int(time.substring(from: 0, to: 2))!
        let min = Int(time.substring(from: 3, to: 5))!
        let AM_PM = time.substring(from: 6, to: 8)
        
        if AM_PM == "PM" {
            hrs += 12
        }
        
        let res = hrs * 60 + min
        return res
    }
}

extension String {
    func substring(from: Int, to: Int) -> String{
        let myNSString = self as NSString
        return myNSString.substring(with: NSRange(location: from, length: to - from))
        
    }
}

