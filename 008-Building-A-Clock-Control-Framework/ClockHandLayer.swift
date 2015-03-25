//
//  ClockFace.swift
//  008-Building-A-Clock-Control-Framework
//
//  Created by Audrey Li on 3/24/15.
//  Copyright (c) 2015 Shomigo. All rights reserved.
//

import UIKit

class ClockHandLayer: CAShapeLayer {
  
    private var hourHand: CAShapeLayer!
    private var minuteHand: CAShapeLayer!
    private var secondHand: CAShapeLayer!
    var isShowingSystemTime = false
    
    
    var time: NSDate!{
        didSet {
            println(oldValue)
            let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar) // can also use NSCalendar.currentCalendar()
            let timeComponents = calendar!.components(NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond, fromDate: oldValue)
            
            createClockAnimation(timeComponents.hour, minute: timeComponents.minute, second: timeComponents.second)
            
            self.hourHand.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(Double(timeComponents.hour) / 12.0 * 2.0 * M_PI)))
            self.minuteHand.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(Double(timeComponents.minute) / 60 * 2.0 * M_PI)))
            
        }
    }

    func createClockAnimation(hour: Int, minute: Int, second: Int) {
        
        var timeSpeed: Int = isShowingSystemTime ? 3600 : 1
        println(timeSpeed)
        
        let hourToValue = CGFloat(hour) / 12.0 * 2.0 * CGFloat(M_PI)
        let hourDuration = CFTimeInterval (hour * timeSpeed)
        let minuteToValue = CGFloat(minute) / 60.0 * 2.0 * CGFloat(M_PI) + CGFloat(hour) * 2.0  * CGFloat(M_PI)
        let minuteDuration = CFTimeInterval(minute * timeSpeed) / 60 + hourDuration
        let secondToValue = CGFloat(second) / 60.0 * 2.0 * CGFloat(M_PI) + CGFloat(minute) * 2.0 * CGFloat(M_PI) + CGFloat(hour) * 3600 * 2.0  * CGFloat(M_PI)
        let secondDuration = CFTimeInterval(second * timeSpeed) / 3600 + hourDuration + minuteDuration
        
        createAnimation(hourHand, keyPath: "transform.rotation", fromValue: 0.0, toValue: hourToValue, duration: hourDuration, repeat: 0)
        createAnimation(minuteHand, keyPath: "transform.rotation", fromValue: 0.0, toValue: minuteToValue, duration: minuteDuration, repeat: 0)
        createAnimation(secondHand, keyPath: "transform.rotation", fromValue: 0.0, toValue: secondToValue, duration: secondDuration, repeat: 0)
        
        println("\(hourDuration)  \(minuteDuration) \(secondDuration)")
    }
    
    
    func createAnimation(layer: CAShapeLayer, keyPath: String, fromValue: CGFloat, toValue: CGFloat, duration: CFTimeInterval, repeat: Float) {
        let animation = CABasicAnimation(keyPath: keyPath)
        
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.repeatCount = repeat
        animation.duration = duration
        
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards

        layer.addAnimation(animation, forKey: keyPath)
    }
    
 
    override init() {
        super.init()
        time = NSDate()

        bounds = CGRectMake(0, 0, 233, 233)
        
        hourHand = makeHand(-2, y: -50, width: 4, height: 50)
        minuteHand = makeHand(-2, y: -60, width: 3, height: 60)
        secondHand = makeHand(-2, y: -70, width: 2, height: 70)
        addSublayer(hourHand)
        addSublayer(minuteHand)
        addSublayer(secondHand)

    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func makeHand(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> CAShapeLayer{
        var hand = CAShapeLayer()
        hand.path = UIBezierPath(rect: CGRectMake(x, y, width, height)).CGPath
        hand.fillColor = UIColor.blackColor().CGColor
        hand.position = CGPoint(x: bounds.size.width/2, y: bounds.size.height/2)
        return hand
    }    
    
}
