//
//  MapViewCell.swift
//  iOSHeader
//
//  Created by Mats Becker on 9/1/16.
//  Copyright © 2016 mats.becker@gmail.com. All rights reserved.
//

import UIKit

class MapViewCell: UICollectionViewCell {
    
    var topBorderLine: UIView = UIView(frame: CGRect(x: 0, y: 0, w: 0, h: 0))
    let topBorderHeight: CGFloat = 4
    let topBorderBackgroundColor = UIColor(hue:0.58, saturation:0.72, brightness:0.95, alpha:1.00)
    
    var constraintView:     [String : AnyObject]    = ["line": NSNull()]
    var constraintMetric:   [String : AnyObject]    = ["line": NSNull()]
    var constraintTop:      [NSLayoutConstraint]    = [NSLayoutConstraint()]
    var constraintHeight:   [NSLayoutConstraint]    = [NSLayoutConstraint()]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        constraintView      = ["line": topBorderLine]
        constraintMetric    = ["lineWidth": topBorderHeight]
        constraintTop       = NSLayoutConstraint.constraintsWithVisualFormat("|[line]|", options: [], metrics: nil, views: constraintView)
        constraintHeight    = NSLayoutConstraint.constraintsWithVisualFormat("V:[line(==lineWidth)]|", options: [], metrics: constraintMetric, views: constraintView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
//        iv.image = UIImage(named: "spot1")
        iv.contentMode = .ScaleAspectFill
        iv.layer.cornerRadius = 0
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Disney Build It: Frozen"
        label.font = UIFont.systemFontOfSize(14)
        label.numberOfLines = 2
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Entertainment"
        label.font = UIFont.systemFontOfSize(13)
        label.textColor = UIColor.darkGrayColor()
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$3.99"
        label.font = UIFont.systemFontOfSize(13)
        label.textColor = UIColor.darkGrayColor()
        return label
    }()
    
    func setupViews() {
        addSubview(imageView)
//        addSubview(nameLabel)
//        addSubview(categoryLabel)
//        addSubview(priceLabel)
        
        imageView.frame = CGRectMake(0, 0, 160, 120)
        
        topBorderLine.translatesAutoresizingMaskIntoConstraints = false
        topBorderLine.backgroundColor = topBorderBackgroundColor
        imageView.addSubview(topBorderLine)
        
        
//        nameLabel.frame = CGRectMake(0, frame.width + 2, frame.width, 40)
//        categoryLabel.frame = CGRectMake(0, frame.width + 38, frame.width, 20)
//        priceLabel.frame = CGRectMake(0, frame.width + 56, frame.width, 20)
    }
    
    
    
    
    public func makeActive(isActive: Bool){
        if isActive {
            topBorderLine.frame = CGRect(x: 0, y: 0, w: imageView.frame.width, h: topBorderHeight)
            addConstraints(constraintTop)
            addConstraints(constraintHeight)
        } else {
            topBorderLine.frame = CGRect(x: 0, y: 0, w: 0, h: 0)
            removeConstraints(constraintTop)
            removeConstraints(constraintHeight)
        }
    }
    
}
