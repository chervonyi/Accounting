//
//  Day.swift
//  Accounting
//
//  Created by Yuri Chervonyi on 10/25/18.
//  Copyright © 2018 Red Inc. All rights reserved.
//

import Foundation

class Day: NSObject, NSCoding {
    
    var timeIn: String? = nil
    var timeOut: String? = nil
    var breakDuration: Int
    private(set) var date: Date

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
    
    // Constructor
    init(_ newDate: Date) {
        date = newDate
        breakDuration = 0
    }
    
    init(_ date: Date, _ timeIn: String, _ timeOut: String, _ breakDuration: Int) {
        self.date = date
        self.timeIn = timeIn
        self.timeOut = timeOut
        self.breakDuration = breakDuration
    }
    
    // Methods for saving instance of class
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: "date")
        aCoder.encode(timeIn, forKey: "timeIn")
        aCoder.encode(timeOut, forKey: "timeOut")
        aCoder.encode(breakDuration, forKey: "breakDuration")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let date = aDecoder.decodeObject(forKey: "date") as! Date
        let timeIn = aDecoder.decodeObject(forKey: "timeIn") as! String
        let timeOut = aDecoder.decodeObject(forKey: "timeOut") as! String
        let breakDuration = aDecoder.decodeInteger(forKey: "breakDuration")
        self.init(date, timeIn, timeOut, breakDuration)
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

