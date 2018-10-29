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
    
    var calendar = IncomeCalendar.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSubmit.layer.cornerRadius = buttonSubmit.frame.height / 2
        // TODO: Add dyniamic panel "You have been working for ____"
    }

    @IBAction func onClickSubmit(_ sender: UIButton) {
        if calendar.days[calendar.todayIndex].timeOut == nil {
            let timeFormatter = DateFormatter()
            timeFormatter.dateStyle = .none
            timeFormatter.timeStyle = .short
            
            let time = timeFormatter.string(for: Date())
            calendar.days[calendar.todayIndex].timeOut = time
            
            calendar.save(days: calendar.days)
            print("Save timeOut with time: \(time!)")
        }
    }
    
}
