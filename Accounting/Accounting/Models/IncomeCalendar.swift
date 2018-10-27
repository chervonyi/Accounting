//
//  IncomeCalendar.swift
//  Accounting
//
//  Created by Yuri Chervonyi on 10/25/18.
//  Copyright © 2018 Red Inc. All rights reserved.
//

import Foundation


class IncomeCalendar {
    
    private(set) var days = [Day]()
    
    static let salaryPerHour = 12
    static var salaryPerMin: Double {
        return Double(salaryPerHour) / Double(60)
    }
    
    init() {
        // TODO - Load data from files
        var day = Day(getNextDate())
        day.timeIn = "10:00 AM"
        day.timeOut = "05:20 PM"
        day.breakDuration = 15
        days.append(day)
        
        print("- - - Day 0 - - -")
        print("Date of day: \(day.date)")
        print("Salary: \(day.salary)")
        print("Time: \(day.workingTime)")
        
        day = Day(getNextDate())
        day.timeIn = "09:20 AM"
        day.timeOut = "05:00 PM"
        day.breakDuration = 45
        days.append(day)
        
        print("- - - Day 1 - - -")
        print("Date of day: \(day.date)")
        print("Salary: \(day.salary)")
        print("Time: \(day.workingTime)")
        
        day = Day(getNextDate())
        day.timeIn = "10:20 AM"
        day.timeOut = "06:00 PM"
        day.breakDuration = 0
        days.append(day)
        
        print("- - - Day 2 - - -")
        print("Date of day: \(day.date)")
        print("Salary: \(day.salary)")
        print("Time: \(day.workingTime)")
        
        
    }
    
    func getNextDate() -> Date {
        if let lastDay = days.last {
            print("getNextDate: +1 day")
            let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: lastDay.date)
            return nextDate!
        } else {
             print("getNextDate: Date()")
            return Date()
        }
    }
}
