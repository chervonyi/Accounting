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
    
    // Returns today's index. If is not found then returns index of the last item
    var todayIndex: Int {
        for index in days.indices {
            if Calendar.current.isDate(Date(), inSameDayAs: days[index].date) {
                return index
            }
        }
        return days.endIndex - 1
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
        //clear()
        days = load()
        
        // Check if last day is today
        if days.count > 0 {
            // When today is last day of working-weeks (Friday) && this day is Finished
            if Calendar.current.isDate(Date(), inSameDayAs: days.last!.date), days.last!.isFinished {
                appendNewWeeks(from: getDate(from: Date(), step: 1))
            }
        } else {
            // Very first run
            var startWeeks = Date()
            
            // Find prev first day of wokring week (Monday)
            while startWeeks.dayOfWeek() != IncomeCalendar.workingDays[0] {
                startWeeks = getDate(from: startWeeks, step: -1)
            }
            
            appendNewWeeks(from: startWeeks)
        }
    }
    
    // Push 10 working days.
    // For first day (Monday) sets true to 'isWeekStart'
    func appendNewWeeks(from date: Date) {
        var newDate = date
        let firstMonday = Day(newDate)
        firstMonday.isWeekStart = true
        days.append(firstMonday)
        
        // Append 9 new working days
        for _ in 1...9 {
            newDate = getDate(from: newDate, step: 1)
            days.append(Day(newDate))
        }
        
        save(days: days)
    }
    
    func getWorkingWeeks(withStartWeeks startIndex: Int) -> [Day] {
        return Array(days[startIndex..<startIndex + 10])
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
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: "days")
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
    
}

extension Date {
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}
