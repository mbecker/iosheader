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
let navBarOffset: CGFloat = 22
let centerNavBar:CGFloat = (navBarHeight - navBarOffset) / 2
let headingLabelOffsetToNavBar:CGFloat = 20 // set in autolayout; not the te font size

let iconHeight:CGFloat          = 44
let iconImageHeight:CGFloat     = 11

let iconOffSetToHeader:CGFloat = -iconHeight / 2

let headerLabelFontHeight:CGFloat = 17 // the font size 14px has actual a frame.origin.y of 17px

let headerLabelVerticalCenter:CGFloat   = 0 - 22 - 8.5 - 20
let iconVerticalCenter:CGFloat          = 0 - 22


let offset_HeaderStop:CGFloat = headerHeight - navBarHeight // At this offset the Header stops its transformations
let offset_B_LabelHeader:CGFloat = offset_HeaderStop + headingLabelOffsetToNavBar // At this offset the Black label reaches the Header

let offset_B_iconHeader:CGFloat = offset_HeaderStop - 36 / 2


class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollView:UIScrollView!
    @IBOutlet var avatarImage:UIImageView!
    @IBOutlet var header:UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var sizerView: UIView!
    
    @IBOutlet weak var headerMapIcon: CustomButton!
    @IBOutlet weak var headerFilterIcon: CustomButton!
    @IBOutlet weak var headerCameraIcon: CustomButton!
    
    @IBOutlet weak var headerImage0: UIImageView!
    var headerOverlayImage: UIView = UIView()
    var headerBlurImageView: UIImageView = UIImageView()
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
//    @IBAction func headerMapIconDidTouch(sender: AnyObject) {
//        showMapView()
//    }
//    
//    @IBAction func headerContentIconDidTouch(sender: AnyObject) {
//        showMapView()
//    }
//    
//    
//    func showMapView() {
//        print("Ican tapped ....")
//        
//        self.performSegueWithIdentifier("mapViewControllerSegue", sender: self)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        header.layer.zPosition = 0
        scrollView.layer.zPosition = 1
        
        self.navigationController?.navigationBarHidden = true
        
        // * ToDo: Create image for landscape (best would be to create image new when device rotates)
        headerBlurImageView = UIImageView(frame: headerImage0.bounds)
        headerBlurImageView.image = headerImage0.image?.blurredImageWithRadius(10, iterations: 20, tintColor: UIColor.clearColor())
        headerBlurImageView.contentMode = UIViewContentMode.ScaleAspectFill
        headerBlurImageView.alpha = 0.0
        header.addSubview(headerBlurImageView)
        
        headerImage0.layer.zPosition = -2
        headerBlurImageView.layer.zPosition = -1
        
        logViewHierarchy(self.view, num: 0)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = true
        
        sizerView.backgroundColor = UIColor.clearColor()
        
        self.view.clipsToBounds = true
        header.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        print("**** Scroll start ***")
        
        let offset = scrollView.contentOffset.y
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        // PULL DOWN -----------------
        
        // Hack to move header image to pos(0,0) when scrolling down
        if offset <= 300 - 66 {
            headerImage0.transform          = CGAffineTransformMakeTranslation(0, 0)
            headerBlurImageView.transform   = CGAffineTransformMakeTranslation(0, 0)
        }
        
        if offset < 0 {
            
            let headerScaleFactor:CGFloat = -(offset) / header.bounds.height
            let headerSizevariation = ((header.bounds.height * (1.0 + headerScaleFactor)) - header.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            header.layer.transform = headerTransform
            
            headerMapIcon.hidden        = true
            headerFilterIcon.hidden         = true
            headerCameraIcon.hidden     = true
        }
            
            // SCROLL UP/DOWN ------------
            
        else {
            
            headerMapIcon.hidden        = false
            headerFilterIcon.hidden         = false
            headerCameraIcon.hidden     = false
            
            // Header -----------
            
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            
            
            //  ------------ Transformation
            
            /* Label Transformation
            
                max(stop: label reaches vertical center of navbar, start: when black label reaches header
                stop:  -(offset_B_LabelHeader - 20)  - centerNavbar - (label height / 2)
                start: (offset to label) - (header has an alignment to top sapce of -20) - offset
            
            */
            let labelTransform = CATransform3DMakeTranslation(0, max(headerLabelVerticalCenter, offset_B_LabelHeader - 20 - offset), 0)
            headerLabel.layer.transform = labelTransform
            
            
            //  * Icon transformation
            
            let iconTransform = CATransform3DMakeTranslation(0, max(iconVerticalCenter, offset_HeaderStop - offset), 0)
            
            headerMapIcon.layer.transform       = iconTransform
            headerFilterIcon.layer.transform    = iconTransform
            headerCameraIcon.layer.transform    = iconTransform
            
            
            // * Header Image transformation
            // ** Only move header image when the navbar reaches top
            
            if offset >= offset_HeaderStop {
                // * Move header
                let headerImageTransform = CATransform3DMakeTranslation(0, max(-navBarHeight, headerHeight - navBarHeight - offset), 0)
                headerImage0.layer.transform        = headerImageTransform
                headerOverlayImage.layer.transform  = headerImageTransform
                headerBlurImageView.layer.transform = headerImageTransform
                
                // * Change z position of layer to hide scrollview and show header on top
                header.layer.zPosition = 1
                scrollView.layer.zPosition = 0
            } else {
                header.layer.zPosition = 0
                scrollView.layer.zPosition = 1
            }
            
            //  ------------ Blur
            headerBlurImageView.alpha = 1 -  min (1.0, (offset_HeaderStop - offset) / offset_HeaderStop)
            
            //  ------------ Avatar
            let avatarScaleFactor = (min(offset_HeaderStop, offset)) / offset_HeaderStop / 3.84 // Slow down the animation
            let avatarSizeVariation = ((avatarImage.bounds.height * (1.0 + avatarScaleFactor)) - avatarImage.bounds.height) / 2.0
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
            avatarImage.layer.transform = avatarTransform
            
            //  ------------ Statusbar
            //  ** Change color to dark when white navbar image is shown
            if offset <= offset_B_LabelHeader {
                UIApplication.sharedApplication().statusBarStyle = .LightContent
            } else {
                UIApplication.sharedApplication().statusBarStyle = .Default
            }
        }
        
        // Apply Transformations
        header.layer.transform = headerTransform
        var posy = header.frame.origin.y
        var posx = header.frame.origin.x
        var hheader = header.frame.height
        print("Header posy: \(posy)")
        print("Header posx: \(posx)")
        print("Header h:    \(hheader)")
        
        var labely = headerLabel.frame.origin.y
        var labelh = headerLabel.frame.height
        print("--")
        print("Label y: \(labely)")
        print("Label h: \(labelh)")
        print("= \(labely - labelh / 2)")
        print("_______________")
        print(headerLabelVerticalCenter)
        print(offset_B_LabelHeader - 20 - offset)
        print(max(-(headerLabelVerticalCenter), offset_B_LabelHeader - 20 - offset))
        
    }
    
    func logViewHierarchy(view: UIView, num: Int) {
        
        var index = num
        var chars: String = String()
        for i in 0..<index {
            chars = chars + "_"
        }
        
        index = index + 2
        print("\(chars) \(NSStringFromClass(view.dynamicType)) userInteractionEnabled: \(view.userInteractionEnabled)")
        for subview in view.subviews {
            self.logViewHierarchy(subview, num: index)
        }
    }
    
    
    
}