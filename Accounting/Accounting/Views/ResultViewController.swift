//
//  ResultViewController.swift
//  Accounting
//
//  Created by Yuri Chervonyi on 10/23/18.
//  Copyright © 2018 Red Inc. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var buttonSubmit: HighlightedBackgroundButton!
    @IBOutlet weak var labelResult: UILabel!
    
    var calendar = IncomeCalendar.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let salaryForToday = calendar.days[calendar.todayIndex].salary
        
        if salaryForToday.isPotentialInt {
            labelResult.text = "$\(Int(salaryForToday))"
        } else {
            labelResult.text = "$\(salaryForToday)"
        }
        print("Calculated salary from calendar")
        
        buttonSubmit.layer.cornerRadius = buttonSubmit.frame.height / 2
    }
}
