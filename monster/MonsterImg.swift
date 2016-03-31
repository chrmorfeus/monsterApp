//
//  MonsterImg.swift
//  monster
//
//  Created by Christian Morera Figueroa on 3/17/16.
//  Copyright © 2016 Christian Morera Figueroa. All rights reserved.
//

import Foundation
import UIKit



class MonsterImg: UIImageView {
    var temp = 0
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation()
    }
    
    func playIdleAnimation() {
        self.image = UIImage(named: "idle1.png")
        self.animationImages = nil
        var imgArray =  [UIImage]()
        for var x = 1; x <= 4; x++ {
            let img = UIImage(named: "idle\(x).png")
            imgArray.append(img!)
        }
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func deathPlayAnimation() {
        self.image = UIImage(named: "dead5.png")
        self.animationImages = nil
        var imgArray =  [UIImage]()
        for var x = 1; x <= 5; x++ {
            let img = UIImage(named: "dead\(x).png")
            imgArray.append(img!)
        }
        self.animationImages = imgArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
}