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
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelIncome: UILabel!
    
    private(set) var calendar = IncomeCalendar.instance
    
    // 0th weeks' pair, 1st weeks' pair, 2nd weeks pair, etc
    private lazy var numberOfWeeks = calendar.startWeeksIndices.endIndex - 1
    
    // 0, 10, 20, etc
    private var weeksStartIndex: Int {
        return calendar.startWeeksIndices[numberOfWeeks]
    }
    
    // [days[0]..<days[10]], [days[11]..<days[20]], etc
    private(set) lazy var days = calendar.getWorkingWeeks(withStartWeeks: weeksStartIndex)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

        for index in daysButtons.indices {
            let day = days[index]
            daysButtons[index].setTitle("$\(Int(day.salary))", for: UIControlState.normal)
            
            if Calendar.current.isDate(Date(), inSameDayAs: day.date) {
                daysButtons[index].borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            }
        }
        
        let totalMinutes = IncomeCalendar.calculateTotalTime(for: days)
        let totalSalary = IncomeCalendar.calculateTotalIncome(for: days)
    
        labelTime.text = "Time: \(StatisticsDayViewController.makeWokringTime(with: totalMinutes))"
        labelIncome.text = "Income: $\(totalSalary)"
    }
    
    @IBAction func onClickDayButton(_ sender: UIButton) {
        //let value = UIInterfaceOrientation.portrait.rawValue
        //UIDevice.current.setValue(value, forKey: "orientation")
        
        performSegue(withIdentifier: "MoveToDay", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MoveToDay" {
            if let statisticsDayView = segue.destination as? StatisticsDayViewController,
                let dayIndex = daysButtons.index(of: sender as! UIButton) {
                
                // Calculate index of day in calendar.days
                let generalIndex = dayIndex + calendar.startWeeksIndices[numberOfWeeks]
                statisticsDayView.selectedDayIndex = generalIndex
            }
        }
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
