//
//  StatisticsDayViewController.swift
//  Accounting
//
//  Created by Yuri Chervonyi on 10/23/18.
//  Copyright © 2018 Red Inc. All rights reserved.
//

import UIKit

class StatisticsDayViewController: UIViewController {

    @IBOutlet weak var inputTextIn: UITextField!
    @IBOutlet weak var inputTextBreak: UITextField!
    @IBOutlet weak var inputTextOut: UITextField!
    
    private var timePicker = UIDatePicker()
    private var durationPicker = DurationPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
    
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
    
    @objc func viewTaped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func timeChangedIn() {
        inputTextIn.text = getSelectedTime()
        view.endEditing(true)
    }
    
    @objc func durationChanged() {
        inputTextBreak.text = durationPicker.selectedItem
        view.endEditing(true)
    }
    
    @objc func timeChangedOut() {
        inputTextOut.text = getSelectedTime()
        view.endEditing(true)
    }
    
    func getSelectedTime() -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short

        return timeFormatter.string(from: timePicker.date)
    }
}
