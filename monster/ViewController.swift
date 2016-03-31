//
//  ViewController.swift
//  monster
//
//  Created by Christian Morera Figueroa on 3/13/16.
//  Copyright © 2016 Christian Morera Figueroa. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var foodImg: DragImage!
    @IBOutlet weak var hearthImg: DragImage!
    
    @IBOutlet weak var penalty1Img: UIImageView!
    @IBOutlet weak var penalty2Img: UIImageView!
    @IBOutlet weak var penalty3Img: UIImageView!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    var penalties = 0
    var timer: NSTimer!
    var monsterHappy = false
    var currentItem: UInt32 = 0
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    var received: Int = 0 //Variable that will receive the value from SecondaryViewController
    
    override func viewDidLoad() {
        print(received) //this value will print either user selected first or second monster
        super.viewDidLoad()
        foodImg.dropTarget = monsterImg
        hearthImg.dropTarget = monsterImg
        penalty1Img.alpha = DIM_ALPHA
        penalty2Img.alpha = DIM_ALPHA
        penalty3Img.alpha = DIM_ALPHA

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnTarget:", name: "onTargetDropped", object: nil)
       
        
        do {
            let resourcePath = NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")
            let url = NSURL(fileURLWithPath: resourcePath!)
            try musicPlayer = AVAudioPlayer(contentsOfURL: url)
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxSkull.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
         startTimer()
    }
    

    
    func itemDroppedOnTarget(notif: AnyObject) {
        monsterHappy = true
        startTimer()
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        hearthImg.alpha = DIM_ALPHA
        hearthImg.userInteractionEnabled = false
        
        if currentItem == 0 {
            sfxHeart.play()
        } else {
            sfxBite.play()
        }
        
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        if !monsterHappy {
            penalties++
            sfxSkull.play()
            if penalties == 1 {
                penalty2Img.alpha = DIM_ALPHA
                penalty1Img.alpha = OPAQUE
            } else if penalties == 2 {
                penalty2Img.alpha = OPAQUE
                penalty3Img.alpha = DIM_ALPHA
            } else if penalties >= 3 {
                penalty3Img.alpha = OPAQUE
            } else {
                penalty1Img.alpha = DIM_ALPHA
                penalty2Img.alpha = DIM_ALPHA
                penalty3Img.alpha = DIM_ALPHA
            }
            
            if penalties >= MAX_PENALTIES {
                gameOver()
            }
        }
        
        let rand = arc4random_uniform(2)
        if rand == 0 {
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            hearthImg.alpha = OPAQUE
            hearthImg.userInteractionEnabled = true
        } else {
            foodImg.alpha = OPAQUE
            foodImg.userInteractionEnabled = true
            hearthImg.alpha = DIM_ALPHA
            hearthImg.userInteractionEnabled = false
        }
        currentItem = rand
        monsterHappy = false

    }
    
    func gameOver() {
        timer.invalidate()
        monsterImg.deathPlayAnimation()
        sfxDeath.play()
    }
    
    @IBAction func restartGame(sender: AnyObject) {
        penalties = 0
        viewDidLoad()
        
    }

}

