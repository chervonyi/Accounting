//
//  StatisticsGraphViewController.swift
//  Accounting
//
//  Created by Yuri Chervonyi on 11/5/18.
//  Copyright © 2018 Red Inc. All rights reserved.
//

import UIKit

class StatisticsGraphViewController: UIViewController {

    // Conts
    private let MAX_ELEMENTS = 15
    
    // Vars
    private(set) var calendar = IncomeCalendar.instance
    
    var data: [[String : Int]] {
        var vault = [[String : Int]]()
        
        var start = 0
        let end = calendar.days.count
        
        if calendar.days.count > MAX_ELEMENTS {
            start = calendar.days.count - MAX_ELEMENTS
        }
        
        for index in start..<end {
            let day = calendar.days[index]
            vault.append([day.date.graphDate : Int(day.salary)])
        }
        
        return vault
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set landscape orientation
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        let x: CGFloat = 10
        let y: CGFloat = 30
        var width = self.view.frame.width
        var height = self.view.frame.height
        
        if height > width {
            let tmp = height
            height = width
            width = tmp
        }
        
        
        let graph = GraphView(frame: CGRect(x: x, y: y, width: width-x*2, height: height * 0.7), data: data)
        
        self.view.addSubview(graph)
    }


    // Turn off rotation
    override open var shouldAutorotate: Bool {
        return false
    }
}
