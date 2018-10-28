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
    
    // Returns today's index. If is not found then returns index of the last item
    var todayIndex: Int {
        for index in days.indices {
            if Calendar.current.isDate(Date(), inSameDayAs: days[index].date) {
                return index
            }
        }
        return days.endIndex - 1
    }
    
    private var workingDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    
    fileprivate init() {
        //clear()
        days = load()
        
        // Check if last day is today
        if days.count > 0 {
            // TODO: Maybe should condition like: lastElement is today && lastElement is Finished
            // Or set condition like: lastElement is Finished
            if Calendar.current.isDate(Date(), inSameDayAs: days.last!.date) {
                appendNewDay(withDate: getNextDate())
            }
        } else {
            appendNewDay(withDate: getNextDate())
        }
        
        //testFill()
        //save()
    }
    
    func appendNewDay(withDate date: Date) {
        days.append(Day(date))
        save()
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
    
    // Returns a next-working-date from the last day in 'days'.
    func getNextDate() -> Date {
        var nextDay = days.last != nil ? Calendar.current.date(byAdding: .day, value: 1, to: days.last!.date)! : Date()
        
        while !workingDays.contains(nextDay.dayOfWeek()) {
            nextDay = Calendar.current.date(byAdding: .day, value: 1, to: nextDay)!
        }
        
        return nextDay
    }
}

extension Date {
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}
