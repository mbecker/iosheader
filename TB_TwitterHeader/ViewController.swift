//
//  ViewController.swift
//  TB_TwitterHeader
//
//  Created by Yari D'areglia on 17/01/15.
//  Copyright (c) 2015 Yari D'areglia. All rights reserved.
//

import UIKit

/* ---- CONST SCREEN ---- */
let headerHeight:CGFloat = 300
let navBarHeight:CGFloat = 66
let headingLabelOffsetToNavBar:CGFloat = 20

let iconHeight:CGFloat = 44
let iconOffSetToHeader:CGFloat = -iconHeight / 2

let headerLabelHeight:CGFloat = 21.5
let centerNavBar:CGFloat = navBarHeight / 2


let offset_HeaderStop:CGFloat = headerHeight - navBarHeight // At this offset the Header stops its transformations
let offset_B_LabelHeader:CGFloat = offset_HeaderStop + headingLabelOffsetToNavBar // At this offset the Black label reaches the Header
let distance_W_LabelHeader:CGFloat = centerNavBar // The distance between the bottom of the Header and the top of the navbar label
let offset_B_iconHeader:CGFloat = offset_HeaderStop - 36 / 2


class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollView:UIScrollView!
    @IBOutlet var avatarImage:UIImageView!
    @IBOutlet var header:UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var sizerView: UIView!
    
    
    
    @IBOutlet weak var headerMapIcon: RoundRectView!
    @IBOutlet weak var headerFilterIcon: RoundRectView!
    @IBOutlet weak var headerCameraIcon: RoundRectView!
    
    
    @IBOutlet weak var headerImage0: UIImageView!
    
    
    var headerBlurImageView:UIImageView!
    
    var blurredHeaderImageView:UIImageView?
    var headerNavBarImage:UIImageView?
    var headerNavBarImageShadow:UIImageView?
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
    }

    override func viewDidAppear(animated: Bool) {
        
        sizerView.backgroundColor = UIColor.clearColor()
        
        header.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        // PULL DOWN -----------------
        
        if offset < 0 {
            
            let headerScaleFactor:CGFloat = -(offset) / header.bounds.height
            let headerSizevariation = ((header.bounds.height * (1.0 + headerScaleFactor)) - header.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            header.layer.transform = headerTransform
        }
        
        // SCROLL UP/DOWN ------------
            
        else {
            
            // Header -----------
            
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            
            
            //  ------------ Transformation
            
            // - Label Transformation
            
            let labelTransform = CATransform3DMakeTranslation(0, max(-(centerNavBar + 25 ), offset_B_LabelHeader - 20 - offset), 0)
            headerLabel.layer.transform = labelTransform
            
            
            // - Icon transformation
            //      ToDo: Why "-6"?
            
            let iconTransform = CATransform3DMakeTranslation(0, max(-(centerNavBar - 6 ), offset_HeaderStop - offset), 0)
            let iconAlpha = 1 - min(1, min(0, offset_HeaderStop - offset) / -(centerNavBar - 6 / 2 ))
            
            headerMapIcon.layer.transform       = iconTransform
            headerFilterIcon.layer.transform    = iconTransform
            headerCameraIcon.layer.transform    = iconTransform
            
            
            headerMapIcon.setShadowAlpha(iconAlpha)
            headerFilterIcon.setShadowAlpha(iconAlpha)
            headerCameraIcon.setShadowAlpha(iconAlpha)
            
            // - Header Image transformation
            
            if offset > 300 - 66 {
                // Only move header image when the navbar reaches top
                let headerImageTransform = CATransform3DMakeTranslation(0, max(-66, 300 - 66 - offset), 0)
                headerImage0.layer.transform    = headerImageTransform
            }
            

            // Avatar -----------
            let avatarScaleFactor = (min(offset_HeaderStop, offset)) / offset_HeaderStop / 3.84 // Slow down the animation
            let avatarSizeVariation = ((avatarImage.bounds.height * (1.0 + avatarScaleFactor)) - avatarImage.bounds.height) / 2.0
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
            
            
            if offset <= offset_HeaderStop {
                
                if avatarImage.layer.zPosition < header.layer.zPosition{
                    header.layer.zPosition = 0
                }
                
            }else {
                if avatarImage.layer.zPosition >= header.layer.zPosition{
                    header.layer.zPosition = 1
                }
            }
            
            // Change statusBarStyle color
            if offset <= offset_B_LabelHeader {
                UIApplication.sharedApplication().statusBarStyle = .LightContent
            } else {
                UIApplication.sharedApplication().statusBarStyle = .Default
            }
            
            
        }
        
        // Apply Transformations
        
        header.layer.transform = headerTransform
        avatarImage.layer.transform = avatarTransform
    }
    
}