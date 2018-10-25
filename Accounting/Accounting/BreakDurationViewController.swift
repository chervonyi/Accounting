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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSubmit.layer.cornerRadius = buttonSubmit.frame.height / 2
        
        // Picker vars and info
        durationPicker.delegate = durationPicker
        durationPicker.dataSource = durationPicker
    }
    
    @IBAction func onSubmit(_ sender: UIButton) {
        print(durationPicker.selectedItem)
    }
}


