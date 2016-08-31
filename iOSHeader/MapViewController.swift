//
//  MapViewController.swift
//  iOSHeader
//
//  Created by Mats Becker on 8/27/16.
//  Copyright © 2016 mats.becker@gmail.com. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    override func viewDidLoad() {
        self.navigationController?.navigationBarHidden = true
        self.tabBarController?.tabBar.hidden = true
        UIApplication.sharedApplication().statusBarStyle = .Default
        
        let labely = backButton.frame.origin.y
        let labelh = backButton.frame.height
        print("--")
        print("Label y: \(labely)")
        print("Label h: \(labelh)")
        print("= \(labely - labelh / 2)")
        print("_______________")
    }
    
    
    @IBOutlet weak var backButton: UIButton!

    @IBAction func backButtonDidTouch(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func newAnimalButtonDidTouch(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
