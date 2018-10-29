//
//  EndWorkingDayViewController.swift
//  Accounting
//
//  Created by Yuri Chervonyi on 10/23/18.
//  Copyright © 2018 Red Inc. All rights reserved.
//

import UIKit

class EndWorkingDayViewController: UIViewController {

    @IBOutlet weak var buttonSubmit: HighlightedBackgroundButton!
    @IBOutlet weak var labelTime: UILabel!
    
    var calendar = IncomeCalendar.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSubmit.layer.cornerRadius = buttonSubmit.frame.height / 2
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        
        let timeEnd = timeFormatter.string(for: Date())
        calendar.days[calendar.todayIndex].timeOut = timeEnd
        
        let time = calendar.days[calendar.todayIndex].workingTimeInMinutes
        let strTime = StatisticsDayViewController.makeWokringTime(with: time)
        labelTime.text = "You have been working for \(strTime)"
        
        calendar.save(days: calendar.days)
    }

    @IBAction func onClickLater(_ sender: UIButton) {
        // Remove saved timeOut before in 'viewDidLoad' method
        calendar.days[calendar.todayIndex].timeOut = nil
        calendar.save(days: calendar.days)
    }
    
}
