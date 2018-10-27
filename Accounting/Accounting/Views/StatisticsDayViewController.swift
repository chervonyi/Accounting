//
//  StatisticsDayViewController.swift
//  Accounting
//
//  Created by Yuri Chervonyi on 10/23/18.
//  Copyright © 2018 Red Inc. All rights reserved.
//

import UIKit

class StatisticsDayViewController: UIViewController {

    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var labelIncome: UILabel!
    @IBOutlet weak var inputTextIn: UITextField!
    @IBOutlet weak var inputTextBreak: UITextField!
    @IBOutlet weak var inputTextOut: UITextField!
    
    private var timePicker = UIDatePicker()
    private var durationPicker = DurationPickerView()
    
    private(set) var calendar = IncomeCalendar()
    lazy private var selectedDayIndex = calendar.days.endIndex - 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("size: \(calendar.days.count)")
        
        // Settings for both types of pickers
        timePicker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        timePicker.datePickerMode = .time
        durationPicker.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        durationPicker.delegate = durationPicker
        durationPicker.dataSource = durationPicker
        
        // Removing picker on usual tap
        let tapGesure = UITapGestureRecognizer(target: self, action: #selector(StatisticsDayViewController.viewTaped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesure)
        
        tieUpDoneButton(for: inputTextIn)
        tieUpDoneButton(for: inputTextBreak)
        tieUpDoneButton(for: inputTextOut)
        
        // Set pickers
        inputTextIn.inputView = timePicker
        inputTextOut.inputView = timePicker
        inputTextBreak.inputView = durationPicker
        
        fillInfo(about: calendar.days[selectedDayIndex])
        
        // Swipe
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        leftSwipe.direction = .left
        
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)
    }
    
    // Swipe
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .right:
                if selectedDayIndex - 1 >= 0 {
                    selectedDayIndex -= 1
                    fillInfo(about: calendar.days[selectedDayIndex])
                }
               
            case .left:
                if selectedDayIndex + 1 < calendar.days.endIndex {
                    selectedDayIndex += 1
                    fillInfo(about: calendar.days[selectedDayIndex])
                }
                
            default:
                break
            }
        }
    }
    
    // Fills all of fields with the day information
    func fillInfo(about day: Day) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .short
        timeFormatter.timeStyle = .none
        
        labelDate.text = timeFormatter.string(for: day.date)
        inputTextIn.text = day.timeIn
        inputTextOut.text = day.timeOut
        
        inputTextBreak.text = transformDuration(day.breakDuration)
        
        updateResult(with: day)
    }
    
    // Puts 'Done' button on top of the TimePicker panel
    func tieUpDoneButton(for textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton: UIBarButtonItem
        
        switch textField {
        case inputTextIn: doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timeChangedIn))
            
        case inputTextBreak: doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(durationChanged))
            
        case inputTextOut: doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timeChangedOut))
            
        default:
            doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        }
        
        toolBar.setItems([doneButton], animated: true)
        textField.inputAccessoryView = toolBar
    }
    
    
   // 3 listeners on textField changes
    @objc func durationChanged() {
        inputTextBreak.text = durationPicker.selectedItem
        calendar.days[selectedDayIndex].breakDuration = transformDuration(durationPicker.selectedItem)
        updateResult(with: calendar.days[selectedDayIndex])
        view.endEditing(true)
    }
    
    @objc func timeChangedIn() {
        inputTextIn.text = getSelectedTime()
        calendar.days[selectedDayIndex].timeIn = getSelectedTime()
        updateResult(with: calendar.days[selectedDayIndex])
        view.endEditing(true)
    }
    
    @objc func timeChangedOut() {
        inputTextOut.text = getSelectedTime()
        calendar.days[selectedDayIndex].timeOut = getSelectedTime()
        updateResult(with: calendar.days[selectedDayIndex])
        view.endEditing(true)
    }
    
    // Supporting methods:
    func transformDuration(_ duration: String) -> Int {
        if let num = duration.components(separatedBy: " ").first {
            return Int(num)!
        }
        return 0
    }
    
    func transformDuration(_ duration: Int) -> String {
        if duration == 60 {
            return "1 hour"
        } else {
            return "\(duration) min"
        }
    }
    
    func updateResult(with day: Day) {
        labelResult.text = "Result: \(day.workingTime)"
        
        if day.salary.isPotentialInt {
            labelIncome.text = "$\(Int(day.salary))"
        } else {
            labelIncome.text = "$\(day.salary)"
        }
    }
    
    func getSelectedTime() -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short

        return timeFormatter.string(from: timePicker.date)
    }
    
    @objc func viewTaped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}

extension Double {
    var isPotentialInt: Bool {
        return self.truncatingRemainder(dividingBy: 1) == 0
    }
}

