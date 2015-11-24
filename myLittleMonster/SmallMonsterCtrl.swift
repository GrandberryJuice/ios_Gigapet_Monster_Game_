//
//  smallMonster.swift
//  myLittleMonster
//  ****SmallMonsterImg-idicates the View
//  Created by KENNETH GRANDBERRY on 11/22/15.
//  Copyright © 2015 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import AVFoundation

class SmallMonsterCtrl: UIViewController {
    
    //outlets
    @IBOutlet weak var smallMonsterImg: SmallMonsterImg!
    @IBOutlet weak var cherryImg: DragImg!
    @IBOutlet weak var appleImg: DragImg!
    @IBOutlet weak var mangoImg: DragImg!
    @IBOutlet weak var skull1Img: UIImageView!
    @IBOutlet weak var skull2Img: UIImageView!
    @IBOutlet weak var skull3Img: UIImageView!
    
    //variables
    let DIM_ALPHA:CGFloat = 0.2
    let OPAQUE:CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer:NSTimer!
    var smallMonsterHappy = false
    var currentItem:UInt32 = 0
    var musicPlayer:AVAudioPlayer!
    var sfxBite:AVAudioPlayer!
    var sfxHeart:AVAudioPlayer!
    var sfxDeath:AVAudioPlayer!
    var sfxSkull:AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cherryImg.dropTarget = smallMonsterImg
        appleImg.dropTarget = smallMonsterImg
        mangoImg.dropTarget = smallMonsterImg
        
        skull1Img.alpha = DIM_ALPHA
        skull2Img.alpha = DIM_ALPHA
        skull3Img.alpha = DIM_ALPHA
        
        //the colon indicate that there has to be something passed through the parameters
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name:"onTargetDropped", object: nil)
        
        do {
            let resourcePath = NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!
            let url = NSURL(fileURLWithPath: resourcePath)
            try musicPlayer = AVAudioPlayer(contentsOfURL: url)
            
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType:"wav")!))
            
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType:"wav")!))
            
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType:"wav")!))
            
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType:"wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxDeath.prepareToPlay()
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxSkull.prepareToPlay()
            
        }catch let err as NSError {
            print(err.debugDescription)
        }
        
        startTimer()
    }

    func itemDroppedOnCharacter(notif:AnyObject) {
        smallMonsterHappy = true
        startTimer()
        
        cherryImg.alpha = DIM_ALPHA
        cherryImg.userInteractionEnabled = false
        
        appleImg.alpha = DIM_ALPHA
        appleImg.userInteractionEnabled = false
        
        mangoImg.alpha = DIM_ALPHA
        mangoImg.userInteractionEnabled = false
        
        sfxBite.play()
    }
    
    func startTimer() {
        
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        if !smallMonsterHappy {
            penalties++
            
            sfxSkull.play()
            
            if penalties == 1{
                skull1Img.alpha = OPAQUE
                skull2Img.alpha = DIM_ALPHA
                skull3Img.alpha = DIM_ALPHA
            } else if penalties == 2{
                skull2Img.alpha = OPAQUE
                skull3Img.alpha = DIM_ALPHA
                skull1Img.alpha = OPAQUE
                
            } else if penalties >= 3{
                skull3Img.alpha = OPAQUE
                skull1Img.alpha = OPAQUE
                skull2Img.alpha = OPAQUE
            } else {
                skull1Img.alpha = DIM_ALPHA
                skull2Img.alpha  = DIM_ALPHA
                skull3Img.alpha = DIM_ALPHA
            }
            
            
            if penalties >= MAX_PENALTIES {
                gameOver()
            }
            
        }
        
        let rand = arc4random_uniform(3)//0 or 1
        
        if rand == 0 {
            cherryImg.alpha = OPAQUE
            cherryImg.userInteractionEnabled = true
            
            appleImg.alpha = DIM_ALPHA
            appleImg.userInteractionEnabled = false
            
            mangoImg.alpha = DIM_ALPHA
            mangoImg.userInteractionEnabled = false
            
        } else if rand == 1 {
            appleImg.alpha = OPAQUE
            appleImg.userInteractionEnabled = true
            
            cherryImg.alpha = DIM_ALPHA
            cherryImg.userInteractionEnabled = false
            
            mangoImg.alpha = DIM_ALPHA
            mangoImg.userInteractionEnabled = false
            
        } else {
            mangoImg.alpha = OPAQUE
            mangoImg.userInteractionEnabled = true
            
            cherryImg.alpha = DIM_ALPHA
            cherryImg.userInteractionEnabled = false
            
            appleImg.alpha = DIM_ALPHA
            appleImg.userInteractionEnabled = false
        }
        
        currentItem = rand
        smallMonsterHappy = false
    }
    
    func gameOver() {
        timer.invalidate()
        smallMonsterImg.playDealthAnimation()
        sfxDeath.play()
    }

}
