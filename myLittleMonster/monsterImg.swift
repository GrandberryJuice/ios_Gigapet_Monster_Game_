//
//  monsterImg.swift
//  myLittleMonster
//
//  Created by KENNETH GRANDBERRY on 11/20/15.
//  Copyright © 2015 KENNETH GRANDBERRY. All rights reserved.
//

import Foundation
import UIKit

class MonsterImg: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation()
    }
    
    func playIdleAnimation() {
        //base image for default
        self.image = UIImage(named:"idle1.png")
        
        //wants an array of images
        var imgArray = [UIImage]()
        for var x = 1; x <= 4; x++ {
            let img = UIImage(named: "idle\(x).png")
            imgArray.append(img!)
        }
        /*
        duration-time
        repeatcount- how many time to repeat( 0 is for infinite)
        
        */
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()

    }
    
    func playDeathAnimaiton() {
        //default image
        self.image = UIImage(named:"dead5.png")
        self.animationImages = nil
        
        //wants an array of images
        var imgArray = [UIImage]()
        for var x = 1; x <= 5; x++ {
            let img = UIImage(named: "dead\(x).png")
            imgArray.append(img!)
        }
        /*
        duration-time
        repeatcount- how many time to repeat( 0 is for infinite)
        
        */
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
}