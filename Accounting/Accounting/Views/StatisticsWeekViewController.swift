//
//  StatisticsWeeksViewController.swift
//  Accounting
//
//  Created by Yuri Chervonyi on 10/30/18.
//  Copyright © 2018 Red Inc. All rights reserved.
//

import UIKit

class StatisticsWeekViewController: UIViewController {

    @IBOutlet var daysButtons: [UIButton]!
    @IBOutlet var dateLabels: [UILabel]!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelIncome: UILabel!
    
    private(set) var calendar = IncomeCalendar.instance
    
    // 0th week, 1st week, 2nd week, etc
    private lazy var numberOfWeeks = calendar.startWeeksIndices.endIndex - 1
    
    // 0, 5, 10, etc
    private var weeksStartIndex: Int {
        return calendar.startWeeksIndices[numberOfWeeks]
    }
    
    // [days[0]...days[5]], [days[6]...days[10]], etc
    private(set) lazy var days = calendar.getWorkingWeek(withStartWeek: weeksStartIndex)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set landscape orientation
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

        updateFrame()
        
        // Swipe
        let rightSwipe = UISwipeGestureRecognizer(target: self, action:  #selector(handleSwipe(sender:)))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action:  #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
    }
    
    func updateFrame() {
        for index in daysButtons.indices {
            let day = days[index]
            daysButtons[index].setTitle("$\(Int(day.salary))", for: UIControlState.normal)
            dateLabels[index].text = "\(day.date.shortDate)"
            
            if Calendar.current.isDate(Date(), inSameDayAs: day.date) {
                daysButtons[index].borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            }
        }
        
        let totalMinutes = IncomeCalendar.calculateTotalTime(for: days)
        let totalSalary = IncomeCalendar.calculateTotalIncome(for: days)
        
        labelTime.text = "Time: \(StatisticsDayViewController.makeWokringTime(with: totalMinutes))"
        labelIncome.text = "Income: $\(totalSalary)"
        
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .right:
                if numberOfWeeks > 0 {
                    numberOfWeeks -= 1
                    days = calendar.getWorkingWeek(withStartWeek: weeksStartIndex)
                    updateFrame()
                }
                
            case .left:
                if numberOfWeeks < calendar.startWeeksIndices.endIndex - 1 {
                    numberOfWeeks += 1
                    days = calendar.getWorkingWeek(withStartWeek: weeksStartIndex)
                    updateFrame()
                }
                
            default: break
            }
        }
    }
    
    @IBAction func onClickDayButton(_ sender: UIButton) {
        performSegue(withIdentifier: "MoveToDay", sender: sender)
    }
    
    // Show StatisticsDayView with appropriate selected day
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
    
    // Turn off rotation
    override open var shouldAutorotate: Bool {
        return false
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
