//
//  OrientationHelper.swift
//  iOSHeader
//
//  Created by Mats Becker on 8/30/16.
//  Copyright © 2016 mats.becker@gmail.com. All rights reserved.
//

import UIKit

struct Orientation {
    var screenWidth: CGFloat {
        if UIInterfaceOrientationIsPortrait(screenOrientation) {
            return UIScreen.mainScreen().bounds.size.width
        } else {
            return UIScreen.mainScreen().bounds.size.height
        }
    }
    
    var screenHeight: CGFloat {
        if UIInterfaceOrientationIsPortrait(screenOrientation) {
            return UIScreen.mainScreen().bounds.size.height
        } else {
            return UIScreen.mainScreen().bounds.size.width
        }
    }
    var screenOrientation: UIInterfaceOrientation {
        return UIApplication.sharedApplication().statusBarOrientation
    }
    
    var maxScreenWidth: CGFloat {
        if screenWidth < screenHeight {
            return screenHeight
        }
        return  screenWidth
    }
    
    
}