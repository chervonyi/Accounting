//
//  CloseViewController.swift
//  Accounting
//
//  Created by Yuri Chervonyi on 10/28/18.
//  Copyright © 2018 Red Inc. All rights reserved.
//

import UIKit

class CloseViewController: UIViewController {

    @IBOutlet weak var buttonClose: HighlightedBackgroundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonClose.layer.cornerRadius = buttonClose.frame.height / 2
    }
    @IBAction func onClickClose(_ sender: UIButton) {
        print("Close app")
        exit(0)
    }
    
}
