//
//  IncomeCalendar.swift
//  Accounting
//
//  Created by Yuri Chervonyi on 10/25/18.
//  Copyright © 2018 Red Inc. All rights reserved.
//

import Foundation

class IncomeCalendar {
    private(set) static var instance = IncomeCalendar()
    private(set) var days = [Day]()
    
    static let salaryPerHour = 12
    static var salaryPerMin: Double {
        return Double(salaryPerHour) / Double(60)
    }
    
    fileprivate init() {
        //clear()
        days = load()
    }
    
    func testFill() {
        var day = Day(getNextDate())
        day.timeIn = "10:00 AM"
        day.timeOut = "05:20 PM"
        day.breakDuration = 15
        days.append(day)
       
        day = Day(getNextDate())
        day.timeIn = "09:20 AM"
        day.timeOut = "05:00 PM"
        day.breakDuration = 45
        days.append(day)
    
        day = Day(getNextDate())
        day.timeIn = "10:20 AM"
        day.timeOut = "06:00 PM"
        day.breakDuration = 0
        days.append(day)
    }
    
    func save() {
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: days)
        userDefaults.set(encodedData, forKey: "days")
        userDefaults.synchronize()
    }
    
    func load() -> [Day] {
        let userDefaults = UserDefaults.standard
        
        if userDefaults.object(forKey: "days") != nil {
            let decoded  = userDefaults.object(forKey: "days") as! Data
            let decodedDays = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Day]
            return decodedDays
        }
        return [Day]()
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: "days")
    }
    
    func getNextDate() -> Date {
        if let lastDay = days.last {
            let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: lastDay.date)
            return nextDate!
        } else {
            return Date()
        }
    }
}
