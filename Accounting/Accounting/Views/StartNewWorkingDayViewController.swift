//
//  ViewController.swift
//  Accounting
//
//  Created by Yuri Chervonyi on 10/22/18.
//  Copyright © 2018 Red Inc. All rights reserved.
//

import UIKit

class StartNewWorkingDayViewController: UIViewController {

    @IBOutlet weak var buttonSubmit: HighlightedBackgroundButton!
    
    var calendar = IncomeCalendar.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSubmit.layer.cornerRadius = buttonSubmit.frame.height / 2
    }
    
    @IBAction func onClickSubmit(_ sender: UIButton) {
        if calendar.days[calendar.todayIndex].timeIn == nil {
            let timeFormatter = DateFormatter()
            timeFormatter.dateStyle = .none
            timeFormatter.timeStyle = .short
            
            let time = timeFormatter.string(for: Date())
            calendar.days[calendar.todayIndex].timeIn = time
            
            save(days: calendar.days)
            print("Save timeIn with time: \(time!)")
        }
    }
    
    func save(days: [Day]) {
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: days)
        userDefaults.set(encodedData, forKey: "days")
        userDefaults.synchronize()
    }
}

class HighlightedBackgroundButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? #colorLiteral(red: 0.912443329, green: 0, blue: 0.04534024001, alpha: 1) : .red
        }
    }
}

class HighlightedFontButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                setTitleColor(#colorLiteral(red: 0.8767406088, green: 0, blue: 0.04356613542, alpha: 1), for: UIControlState.normal)
            } else {
                setTitleColor(.red, for: UIControlState.normal)
            }
        }
    }
}


