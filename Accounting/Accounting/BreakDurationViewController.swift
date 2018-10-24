//
//  BreakDurationViewController.swift
//  Accounting
//
//  Created by Yuri Chervonyi on 10/23/18.
//  Copyright © 2018 Red Inc. All rights reserved.
//

import UIKit

class BreakDurationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var selectedItem: String?
    
    var pickerData: [String] = [String]()
    
    @IBOutlet weak var buttonSubmit: UIButton!
    @IBOutlet weak var durationPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSubmit.layer.cornerRadius = buttonSubmit.frame.height / 2
        
        // Picker vars and info
        selectedItem = nil
        durationPicker.delegate = self
        durationPicker.dataSource = self
        fillPickerData()
    }
    
    func fillPickerData() {
        for i in 0..<60 {
            pickerData.append("\(i) min")
        }
        pickerData.append("1 hour")
    }
    
    @IBAction func onSubmit(_ sender: UIButton) {
        if selectedItem != nil {
            print(selectedItem!)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItem = pickerData[row]
    }
    
    
}
