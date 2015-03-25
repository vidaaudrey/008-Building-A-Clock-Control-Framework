//
//  TestClockView.swift
//  008-Building-A-Clock-Control-Framework
//
//  Created by Audrey Li on 3/24/15.
//  Copyright (c) 2015 Shomigo. All rights reserved.
//

import UIKit

class ClockHandView: UIView {
    
    var clockFaceLayer = ClockHandLayer()
    var time: NSDate! {
        didSet {
            clockFaceLayer.time = oldValue
            setNeedsDisplay()
        }
    }
    var isShowingSystemTime: Bool! {
        didSet {
            clockFaceLayer.isShowingSystemTime = oldValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        time = NSDate()
        isShowingSystemTime = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        clockFaceLayer.frame = bounds
        clockFaceLayer.time = time
        clockFaceLayer.isShowingSystemTime = isShowingSystemTime
        self.layer.addSublayer(clockFaceLayer)
    }

}
