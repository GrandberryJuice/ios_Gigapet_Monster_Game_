//
//  DragImg.swift
//  myLittleMonster
//
//  Created by KENNETH GRANDBERRY on 11/20/15.
//  Copyright © 2015 KENNETH GRANDBERRY. All rights reserved.
//

import Foundation
import UIKit

//when using subclasses you need UIKit

class DragImg: UIImageView {
    
    var originalPosition: CGPoint!
    var dropTarget: UIView?
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        originalPosition = self.center
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //grab the first touch in the set<UItouch> and where the person is dragging grab the point
        if let touch = touches.first{
            let position = touch.locationInView(self.superview)
            self.center = CGPointMake(position.x, position.y)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first, let target = dropTarget {
            let position = touch.locationInView(self.superview)
            // if the postion you touched on landed inside the target
            if CGRectContainsPoint(target.frame, position) {
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name:"onTargetDropped", object: nil))
            }
        }
        
        //goes back to orginal Postion
        self.center = originalPosition
        
        
    }
}