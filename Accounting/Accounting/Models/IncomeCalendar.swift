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
        let day = Day(Date())
        day.timeIn = "10:00 AM"
        day.timeOut = "05:20 PM"
        
        print("Date of day: \(day.date)")
        print("Salary: \(day.salary)")
        print("Time: \(day.workingTime)")
    }
    
    func getNextDate() -> Date? {
        if let lastDay = days.last {
            let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: lastDay.date)
            return nextDate
        } else {
            return Date()
        }
    }
}
