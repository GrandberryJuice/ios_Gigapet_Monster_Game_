//
//  ViewController.swift
//  myLittleMonster
//
//  Created by KENNETH GRANDBERRY on 11/20/15.
//  Copyright © 2015 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    @IBOutlet weak var monsterImg:MonsterImg!
    @IBOutlet weak var foodImg:DragImg!
    @IBOutlet weak var heart:DragImg!
    @IBOutlet weak var penalty1Img: UIImageView!
    @IBOutlet weak var penalty2Img: UIImageView!
    @IBOutlet weak var penalty3Img: UIImageView!
    
    //1.0 is full image
    let DIM_ALPHA:CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var penalties = 0
    var timer:NSTimer!
    
    var monsterHappy = false
    var currentItem:UInt32 = 0
    
    var musicPlayer:AVAudioPlayer!
    var sfxBite:AVAudioPlayer!
    var sfxHeart:AVAudioPlayer!
    var sfxDeath:AVAudioPlayer!
    var sfxSkull:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //intialize the optional from the monsterImg
        foodImg.dropTarget = monsterImg
        heart.dropTarget = monsterImg
        
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA
        
        
        //the colon looks for parameters so you need parameters selector is the function and name is the name of the listener
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name:"onTargetDropped", object: nil)
        
        do{
            //easier way to view it
            let resourcePath = NSBundle.mainBundle().pathForResource("cave-music", ofType:"mp3")!
            let url = NSURL(fileURLWithPath: resourcePath)
            try musicPlayer = AVAudioPlayer(contentsOfURL: url)
            
            //try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music",     ofType:"mp3")!))
        
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
            
        
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
        
        startTimer()
    }
    
    //must have the same name of the listner
    func itemDroppedOnCharacter(notif:AnyObject) {
        monsterHappy = true
        startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heart.alpha = DIM_ALPHA
        heart.userInteractionEnabled = false
        
        if currentItem == 0 {
        sfxHeart.play()
        } else {
            sfxBite.play()
        }
    }
    
    func startTimer() {
        //if there is a timer restart timer
        if timer != nil {
            timer.invalidate()
        }
        // the selector is the function no colon because there are no parameters being passed
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
      
    }

    
    func changeGameState(){
        if !monsterHappy {
            penalties++
            
            sfxSkull.play()
            
            if penalties == 1{
                penalty1Img.alpha = OPAQUE
                penalty2Img.alpha = DIM_ALPHA
                
            } else if penalties == 2{
                penalty2Img.alpha = OPAQUE
                penalty3Img.alpha = DIM_ALPHA
                
            } else if penalties >= 3{
                penalty3Img.alpha = OPAQUE
                
            } else {
                penalty1Img.alpha = DIM_ALPHA
                penalty2Img.alpha  = DIM_ALPHA
                penalty3Img.alpha = DIM_ALPHA
            }
            
            
            if penalties >= MAX_PENALTIES {
                gameOver()
            }

        }
        
        let rand = arc4random_uniform(2)//0 or 1
        
        if rand == 0 {
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            
            heart.alpha = OPAQUE
            heart.userInteractionEnabled = true
            
        } else {
            heart.alpha = DIM_ALPHA
            heart.userInteractionEnabled = false
            
            foodImg.alpha = OPAQUE
            foodImg.userInteractionEnabled = true
        }
        
        currentItem = rand
        monsterHappy = false
    }
    
    
    func gameOver() {
        timer.invalidate()
        monsterImg.playDeathAnimaiton()
        sfxDeath.play()
    }
    
}

