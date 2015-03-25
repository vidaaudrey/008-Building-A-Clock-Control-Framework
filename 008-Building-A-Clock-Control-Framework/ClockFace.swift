//
//  ClockFace.swift
//  008-Building-A-Clock-Control-Framework
//
//  Created by Audrey Li on 3/24/15.
//  Copyright (c) 2015 Shomigo. All rights reserved.
//

import UIKit

// this ClockFace view is without Animation, currently not used 
class ClockFace: CAShapeLayer {
   
    private var hourHand: CAShapeLayer!
    private var minuteHand: CAShapeLayer!
    private var secondHand: CAShapeLayer!
    
    var time: NSDate!{
        willSet {
            let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar) // can also use NSCalendar.currentCalendar()
            let timeComponents = calendar!.components(NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond, fromDate: newValue)
            self.hourHand.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(Double(timeComponents.hour) / 12.0 * 2.0 * M_PI)))
            self.minuteHand.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(Double(timeComponents.minute) / 60 * 2.0 * M_PI)))

        }
    }
    
    override init() {
        super.init()
        time = NSDate()
        bounds = CGRectMake(0, 0, 200, 200)
        path = UIBezierPath(ovalInRect: bounds).CGPath
        fillColor = UIColor.whiteColor().CGColor
        strokeColor = UIColor.blackColor().CGColor
        lineWidth = 5
        
        hourHand = makeHand(-3, y: -70, width: 4, height: 70)
        minuteHand = makeHand(-2, y: -85, width: 3, height: 85)
        addSublayer(hourHand)
        addSublayer(minuteHand)

    }
    
    func makeHand(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> CAShapeLayer{
        var hand = CAShapeLayer()
        hand.path = UIBezierPath(rect: CGRectMake(x, y, width, height)).CGPath
        hand.fillColor = UIColor.blackColor().CGColor
        hand.position = CGPoint(x: bounds.size.width/2, y: bounds.size.height/2)
        return hand
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
