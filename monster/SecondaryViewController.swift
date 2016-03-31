//
//  SecondaryViewController.swift
//  monster
//
//  Created by Christian Morera Figueroa on 3/29/16.
//  Copyright © 2016 Christian Morera Figueroa. All rights reserved.
//

import UIKit

class SecondaryViewController: UIViewController {

    var character: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let _secondVC = segue.destinationViewController as! ViewController
        _secondVC.received = character
        //with this function i am sending the value from variable character which is a flag that will set either the user selects the first or second pet.
    }

    
    @IBAction func player1(sender: AnyObject) {
        character = 0 //if user selects first pet then the value is 0
    }
    
    @IBAction func player2(sender: AnyObject) {
        character = 1 //if user selects first pet then the value is 0
    }

}
