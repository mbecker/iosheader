//
//  CustomButton.swift
//  iOSHeader
//
//  Created by Mats Becker on 8/27/16.
//  Copyright © 2016 mats.becker@gmail.com. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable override var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.CGColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.grayColor() {
        didSet {
            layer.shadowColor = shadowColor.CGColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 1.0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 1.0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var masksToBounds: Bool = true {
        didSet {
            layer.masksToBounds = masksToBounds
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSizeMake(0.0, 1.0) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override var highlighted: Bool {
        didSet {
            if highlighted {
                backgroundColor = UIColor(red:0.89, green:0.93, blue:0.93, alpha:1.00)
            } else {
                backgroundColor = UIColor.whiteColor()
            }
        }
    }
    
    
}
