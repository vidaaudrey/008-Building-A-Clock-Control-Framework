//
//  ClockView.swift
//  008-Building-A-Clock-Control-Framework
//
//  Created by Audrey Li on 3/24/15.
//  Copyright (c) 2015 Shomigo. All rights reserved.
//

import UIKit

class ClockBGView: UIView {
    
    override func drawRect(rect: CGRect) {
        StyleKit.drawClock(frame: bounds, numbersColor: UIColor.blackColor(), rimColor: UIColor.grayColor(), tickColor: UIColor.blackColor(), faceColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.8))
    }

}
