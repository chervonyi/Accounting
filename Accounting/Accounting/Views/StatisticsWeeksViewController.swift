//
//  StatisticsWeeksViewController.swift
//  Accounting
//
//  Created by Yuri Chervonyi on 10/30/18.
//  Copyright © 2018 Red Inc. All rights reserved.
//

import UIKit

class StatisticsWeeksViewController: UIViewController {

    @IBOutlet var daysButtons: [UIButton]!
    
    private(set) var calendar = IncomeCalendar.instance
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    func updateWeeks(with days: [Day]) {
        // TODO: Add:
        // updateDaysButtons()
        // lalbelIncome.text = IncomeCalendar.calculateIncome(days)
        // labelTime.text = IncomeCalendar.calculateTime(days)
    }

}

extension UIView {
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
