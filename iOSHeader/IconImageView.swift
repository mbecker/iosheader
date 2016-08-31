//
//  IconImageView.swift
//  iOSHeader
//
//  Created by Mats Becker on 8/27/16.
//  Copyright © 2016 Yari D'areglia. All rights reserved.
//

import UIKit

class IconImageView: UIImageView {
    
    override func awakeFromNib() {
        self.image = self.image
        
        
        self.layer.cornerRadius = 12
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 1.0
    }
}

