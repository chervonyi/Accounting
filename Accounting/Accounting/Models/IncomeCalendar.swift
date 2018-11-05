//
//  IncomeCalendar.swift
//  Accounting
//
//  Created by Yuri Chervonyi on 10/25/18.
//  Copyright © 2018 Red Inc. All rights reserved.
//

import Foundation

class IncomeCalendar {
    // Vars:
    private(set) static var instance = IncomeCalendar()
    private(set) var days = [Day]()
    
    // Conts:
    private(set) static var workingDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    static let salaryPerHour = 12
    
    // Properties:
    static var salaryPerMin: Double {
        return Double(salaryPerHour) / Double(60)
    }
    
    var countWokringDays: Int {
        return IncomeCalendar.workingDays.count
    }
    
    // Returns today's or if it not found - next working day's index
    // If next working day is not found too, then returns index of last element
    var todayIndex: Int {
        
        // Find today
        var index = getIndexOfDate(date: Date())
        
        if index != -1 {
            return index
        }
        
        // Find next working day from today
        let nextWorkingDay = getDate(from: Date(), step: 1)
        index = getIndexOfDate(date: nextWorkingDay)
        
        return index != -1 ? index : days.endIndex - 1
    }
    
    var startWeeksIndices: [Int] {
        var starts = [Int]()
        
        for index in days.indices {
            if days[index].isWeekStart {
                starts.append(index)
            }
        }
 
        return starts
    }
    
    // Constructor:
    fileprivate init() {
        days = load()
        
        // Check if last day is today
        if days.count > 0 {
            // When today is last day of working-weeks (Friday) && this day is Finished
            if Calendar.current.isDate(Date(), inSameDayAs: days.last!.date), days.last!.isFinished {
                appendNewWeek(from: getDate(from: Date(), step: 1))
            }
        } else {
            // On very first app run
            var startWeek = Date()
            
            // If today is working day then week will be created from prev monday (-1)
            // Else - week wil be created from next monday (+1)
            let direction = IncomeCalendar.workingDays.contains(startWeek.dayOfWeek()) ? -1 : 1
        
            // Step by step (adding or subtracting) date finds appropriate Monday
            while startWeek.dayOfWeek() != IncomeCalendar.workingDays[0] {
                startWeek = getDate(from: startWeek, step: direction)
            }
            
            appendNewWeek(from: startWeek)
        }
    }
    
    // Push 5 working days.
    // For first day (Monday) sets true to 'isWeekStart'
    func appendNewWeek(from date: Date) {
        var newDate = date

        days.append(Day(newDate))

        // Append new working days
        for _ in 1..<countWokringDays {
            newDate = getDate(from: newDate, step: 1)
            days.append(Day(newDate))
        }
        
        save(days: days)
    }
    
    func getWorkingWeek(withStartWeek startIndex: Int) -> [Day] {
        return Array(days[startIndex..<startIndex + countWokringDays])
    }

    // Data-methods:
    func save(days: [Day]) {
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
    
    // Supporting methods:
    func getDate(from date: Date?, step value: Int) -> Date {
        var newDate = date != nil ? Calendar.current.date(byAdding: .day, value: value, to: date!)! : Date()
        
        while !IncomeCalendar.workingDays.contains(newDate.dayOfWeek()) {
            newDate = Calendar.current.date(byAdding: .day, value: value, to: newDate)!
        }
        
        return newDate
    }
    
    static func calculateTotalIncome(for days: [Day]) -> Double {
        return days.reduce(0.0, {$0 + $1.salary})
    }
    
    static func calculateTotalTime(for days: [Day]) -> Int {
        return days.reduce(0, {$0 + $1.workingTimeInMinutes})
    }
    
    // Returns index of necessary date in days: [Day].
    // If it is not found then returns -1
    func getIndexOfDate(date: Date) -> Int {
        for index in days.indices {
            if Calendar.current.isDate(date, inSameDayAs: days[index].date) {
                return index
            }
        }
        
        return -1
    }
    
}

extension Date {
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}
