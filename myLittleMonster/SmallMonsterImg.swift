//
//  SmallMonsterImg.swift
//  myLittleMonster
//
//  Created by KENNETH GRANDBERRY on 11/22/15.
//  Copyright © 2015 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class SmallMonsterImg: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        PlayIdleAnnimation()
    }
    
    func PlayIdleAnnimation() {
        self.image = UIImage(named:"character2idle1.png")
        
        var imageArray = [UIImage]()
        for var x = 1; x <= 4; x++ {
            let img = UIImage(named:"character2idle\(x).png")
            imageArray.append(img!)
        }
        
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()

    }
    
    func playDealthAnimation() {
        
        //default image
        self.image = UIImage(named:"character2dead5.png")
        self.animationImages = nil
        
        //wants an array of images
        var imgArray = [UIImage]()
        for var x = 1; x <= 5; x++ {
            let img = UIImage(named: "character2dead\(x).png")
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
