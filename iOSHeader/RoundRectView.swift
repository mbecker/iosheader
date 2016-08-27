//
//  RoundRectView.swift
//  TB_TwitterHeader
//
//  Created by Mats Becker on 8/27/16.
//  Copyright © 2016 Yari D'areglia. All rights reserved.
//

@IBDesignable class RoundRectView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    @IBInspectable var borderWidth: CGFloat = 0.5
    @IBInspectable var shadowOpacity: Float = 0.4
    private var customBackgroundColor: UIColor = UIColor.clearColor()
        
    override var backgroundColor: UIColor?{
        didSet {
            customBackgroundColor = backgroundColor!
            super.backgroundColor = UIColor.clearColor()
        }
    }
    
    func setup() {
        layer.shadowColor = UIColor.blackColor().CGColor;
        layer.shadowOffset = CGSize(width: 0, height: 1);
        layer.shadowRadius = 1.0;
        layer.shadowOpacity = shadowOpacity
        super.backgroundColor = UIColor.clearColor()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.userInteractionEnabled = true
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override func drawRect(rect: CGRect) {
        customBackgroundColor.setFill()
        UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius ?? 0).fill()
        
        let borderRect = CGRectInset(bounds, borderWidth/2, borderWidth/2)
        let borderPath = UIBezierPath(roundedRect: borderRect, cornerRadius: cornerRadius - borderWidth/2)
        borderColor!.setStroke()
        borderPath.lineWidth = borderWidth
        borderPath.stroke()
        
        // whatever else you need drawn
    }
    
    func setShadowAlpha(alpha: CGFloat){
        layer.shadowColor = UIColor.blackColor().CGColor;
        layer.shadowOffset = CGSize(width: 0, height: 1);
        layer.shadowRadius = 1.0;
        layer.shadowOpacity = shadowOpacity * Float(alpha);
        super.backgroundColor = UIColor.clearColor()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if let touch = touches.first {
//            let currentPoint = touch.locationInView(self)
//            // do something with your currentPoint
//        }
        
        
        self.backgroundColor = UIColor.blueColor()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if let touch = touches.first {
//            let currentPoint = touch.locationInView(self)
//            // do something with your currentPoint
//        }
        
        
        self.backgroundColor = UIColor.blueColor()
    }
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if let touch = touches.first {
//            let currentPoint = touch.locationInView(self)
//            // do something with your currentPoint
//        }
        
        self.backgroundColor = UIColor.whiteColor()
    }

}