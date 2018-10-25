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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Removing picker on usual tap
        let tapGesure = UITapGestureRecognizer(target: self, action: #selector(StatisticsDayViewController.viewTaped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesure)
        
        tieUpDoneButton(for: inputTextIn)
        tieUpDoneButton(for: inputTextOut)
        
        timePicker.datePickerMode = .time
        inputTextOut.inputView = timePicker
        inputTextIn.inputView = timePicker
    }
    
    func tieUpDoneButton(for textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton: UIBarButtonItem
        if textField == inputTextIn {
            doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timeChangedIn))
        } else {
            doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(timeChangedOut))
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
