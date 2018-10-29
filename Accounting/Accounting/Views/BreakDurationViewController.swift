//
//  BreakDurationViewController.swift
//  Accounting
//
//  Created by Yuri Chervonyi on 10/23/18.
//  Copyright © 2018 Red Inc. All rights reserved.
//

import UIKit

class BreakDurationViewController: UIViewController {
    
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var durationPicker: DurationPickerView!

    var calendar = IncomeCalendar.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSubmit.layer.cornerRadius = buttonSubmit.frame.height / 2
        
        // Picker vars and info
        durationPicker.delegate = durationPicker
        durationPicker.dataSource = durationPicker
    }
    
    @IBAction func onClickSubmit(_ sender: UIButton) {
        // Transfrom selected duration (from UIPickerView) from String to Int
        calendar.days[calendar.todayIndex].breakDuration = StatisticsDayViewController.transformDuration(durationPicker.selectedItem)
        
        calendar.save(days: calendar.days)
    }
    
}


