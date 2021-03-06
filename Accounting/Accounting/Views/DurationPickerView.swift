//
//  DurationPickerView.swift
//  Accounting
//
//  Created by Yuri Chervonyi on 10/25/18.
//  Copyright © 2018 Red Inc. All rights reserved.
//

import UIKit

class DurationPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    lazy private(set) var pickerData = getDataSrouce()
    
    lazy private(set) var selectedItem = pickerData[0]
    
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
    
    func getDataSrouce() -> [String] {
        var data = [String]()
        for i in 0..<60 {
            data.append("\(i) min")
        }
        data.append("1 hour")
        return data
    }
}

