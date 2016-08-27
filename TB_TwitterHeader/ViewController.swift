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
    @IBOutlet weak var headerMapIcon: UIImageView!
    @IBOutlet weak var headerFilterIcon: UIImageView!
    @IBOutlet weak var headerCameraIcon: RoundRectView!
    @IBOutlet weak var headerImage0: UIImageView!
    
    
    var headerBlurImageView:UIImageView!
    
//    var headerImageView:UIImageView?
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
        
        // Header - Image
        
//        headerImageView = UIImageView(frame: header.bounds)
//        headerImageView?.image = UIImage(named: "bg-header")
//        headerImageView?.contentMode = UIViewContentMode.ScaleAspectFill
//        header.insertSubview(headerImageView!, belowSubview: headerLabel)
//        headerImageView?.layer.zPosition = -1
//        self.view.bringSubviewToFront(avatarImage)
//        self.view.bringSubviewToFront(headerMapIcon)
//        self.view.bringSubviewToFront(headerFilterIcon)
        
        // Header - Blurred Image
        
//        headerBlurImageView                         = UIImageView(frame: header.bounds)
//        headerBlurImageView?.image                  = UIImage(named: "bg-addo")?.blurredImageWithRadius(10, iterations: 20, tintColor: UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.00))
//        headerBlurImageView?.contentMode            = UIViewContentMode.ScaleAspectFill
//        headerBlurImageView?.alpha                  = 0.0
//        
//        headerNavBarImage                           = UIImageView(frame: CGRect(x: 0, y: 0, width: header.frame.width, height: header.frame.height - 1))
//        headerNavBarImage?.backgroundColor          = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.00)
//        headerNavBarImage?.alpha                    = 0.0
//        
//        headerNavBarImageShadow                     = UIImageView(frame: header.bounds)
//        headerNavBarImageShadow!.backgroundColor    = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.00)
//        headerNavBarImageShadow!.alpha              = 0.0
//        
//        header.insertSubview(headerBlurImageView, belowSubview: headerImage0)
//        header.insertSubview(headerNavBarImage!, belowSubview: headerImage0)
//        header.insertSubview(headerNavBarImageShadow!, belowSubview: headerImage0)
        
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
            
            
            //  ------------ Label
            
            let labelTransform = CATransform3DMakeTranslation(0, max(-(centerNavBar + 21.5 ), offset_B_LabelHeader - 21.5 - offset), 0)
            headerLabel.layer.transform = labelTransform
            
            
            // ToDo: Why "18 / 2"?
            let iconTransform = CATransform3DMakeTranslation(0, max(-(centerNavBar - 18 / 2 ), offset_HeaderStop - offset), 0)
            headerMapIcon.layer.transform       = iconTransform
            headerFilterIcon.layer.transform    = iconTransform
            headerCameraIcon.layer.transform    = iconTransform
            headerCameraIcon.setShadowAlpha(1 - min(1, min(0, offset_HeaderStop - offset) / -(centerNavBar - 18 / 2 )))
            
            if offset > 300 - 66 {
                let headerImageTransform = CATransform3DMakeTranslation(0, max(-66, 300 - 66 - offset), 0)
                headerImage0.layer.transform    = headerImageTransform
                
                // ---- PRINT
                print("----------")
                print("offset                       -   \(offset)")
                print("max(-66, 300 - 66 - offset)  -   \(max(-66, 300 - 66 - offset))")
            }
            
            
            
            
            
            //  ------------ Blur
            
            let imageAlpha:CGFloat = 1 - min (1.0, -((offset - offset_B_LabelHeader)/offset_B_LabelHeader * 1.5))
//            headerBlurImageView?.alpha = min (1.0, (offset - offset_B_LabelHeader)/distance_W_LabelHeader)
//            headerBlurImageView?.alpha      = imageAlpha
            
//            if(offset > offset_HeaderStop){
//                headerNavBarImage?.alpha        = 1
//                headerNavBarImageShadow!.alpha  = 1
//            } else {
//                headerNavBarImage?.alpha        = 0
//                headerNavBarImageShadow!.alpha  = 0
//            }
            
            

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