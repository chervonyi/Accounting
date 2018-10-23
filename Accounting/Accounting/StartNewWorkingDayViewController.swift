//
//  ViewController.swift
//  Accounting
//
//  Created by Yuri Chervonyi on 10/22/18.
//  Copyright © 2018 Red Inc. All rights reserved.
//

import UIKit

class StartNewWorkingDayViewController: UIViewController {

    @IBOutlet weak var buttonAgree: UIButton!
    
    @IBOutlet weak var buttonStatistics: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonAgree.layer.cornerRadius = buttonAgree.frame.height / 2
        
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


