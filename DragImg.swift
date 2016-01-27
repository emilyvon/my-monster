//
//  DragImg.swift
//  my-monster
//
//  Created by Mengying Feng on 26/01/2016.
//  Copyright © 2016 Mengying Feng. All rights reserved.
//

import Foundation
import UIKit

class DragImg: UIImageView {
    
    var originalPosition: CGPoint!
    var dropTarget: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        originalPosition = self.center
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.locationInView(self.superview)
            self.center = CGPointMake(position.x, position.y)
        }
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {

        if let touch = touches.first, let target = dropTarget {
            
            let position = touch.locationInView(self.superview?.superview)
            
            if CGRectContainsPoint(target.frame, position) {
                
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "onTargetDropped", object: nil))
                
            }
        }
        
        
        self.center = originalPosition
    }
}

/*
NSNotification as static constants
Hello all.
Just an humble suggestion:

I think it would be better to treat NSNotification as static constants, to have more structured code and to not rely on strings wandering around your application

on DragImg

static let ON_TARGET_DROPPED: NSNotification = NSNotification(name: "onTargetDropped", object: nil)

and then use like this

NSNotificationCenter.defaultCenter().postNotification(DragImg.ON_TARGET_DROPPED)

on the view controller (or wherever you want), create an observer this way

NSNotificationCenter.defaultCenter().addObserver(self, selector: "onTargetDropped:", name: DragImg.ON_TARGET_DROPPED.name, object: nil)

Mark, what do you think about this?

=====================================
Mark Price · 2 months ago ·
That is right. You should never duplicate code and things like notification names should always be in constants
*/