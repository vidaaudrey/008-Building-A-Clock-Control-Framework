//
//  ClockViewController.swift
//  008-Building-A-Clock-Control-Framework
//
//  Created by Audrey Li on 3/24/15.
//  Copyright (c) 2015 Shomigo. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var clockHandView: ClockHandView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg")!)
        
    }
    @IBAction func setSystemTime(sender: UIButton) {
        clockHandView.isShowingSystemTime = true
        clockHandView.time = NSDate()
       
    }
    @IBAction func setSpeedUpTime(sender: UIButton) {
        clockHandView.isShowingSystemTime = false
        clockHandView.time = datePicker.date
    }

}

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    var cgFloatValue: CGFloat {
        return CGFloat ((self as NSString).floatValue)
    }
}