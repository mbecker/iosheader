//
//  MapViewController.swift
//  iOSHeader
//
//  Created by Mats Becker on 8/27/16.
//  Copyright © 2016 mats.becker@gmail.com. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "mapCollectionAnimal"
    private let animals = ["Lion 1", "Lion 2", "Lion 3", "Lion 4", "Lion 5", "Lion 6", "Lion 7", "Lion 8", "Lion 9", "Lion 10"]
    let topBorderBackgroundColor = UIColor(hue:0.58, saturation:0.72, brightness:0.95, alpha:1.00)
    private var selectedCell: NSIndexPath = NSIndexPath(forItem: 0, inSection: 0)
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var backButton: UIButton!

    @IBAction func backButtonDidTouch(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func newAnimalButtonDidTouch(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        self.parentViewController?.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationController?.navigationBarHidden = true
        self.tabBarController?.tabBar.hidden = true
        UIApplication.sharedApplication().statusBarStyle = .Default
        
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        collectionView.registerClass(MapViewCell.self, forCellWithReuseIdentifier: cellId)
        
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animals.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath)
        
        var topBorderLine: UIView = UIView(frame: CGRect(x: 0, y: 0, w: 160, h: 120))
        topBorderLine.backgroundColor = topBorderBackgroundColor
        cell.selectedBackgroundView = topBorderLine
        cell.backgroundView = UIView(frame: CGRect(x: 0, y: 0, w: 160, h: 120))
        cell.backgroundView?.backgroundColor = UIColor.cyanColor()
        // Configure the cell
        if(indexPath.item == selectedCell.item){
            selectedCell = indexPath
//            cell.makeActive(true)
//            cell.backgroundColor = topBorderBackgroundColor
//            cell.selected = true
        } else {
//            cell.makeActive(false)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let didEndDisplayingCell = cell as! MapViewCell
        didEndDisplayingCell.makeActive(false)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(160, 120)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("didSelectItem \(indexPath.item)")
        
        
        
        
//        if selectedCell != indexPath {
//            
//
//            let didSelectedCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! MapViewCell
//            didSelectedCell.makeActive(true)
//            
//            
//            print("---")
//            print("Previos cell     \(selectedCell.item)")
        
//            print("select cell      \(indexPath.item)")
//            
//        }
        
        
        
        
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        print("shouldSelectItemAtIndexPath \(indexPath.item)")
        
        return true
    }
    
    func collectionView(collectionView: UICollectionView, shouldDeselectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        print("shouldDeselectItemAtIndexPath \(indexPath.item)")
        return true
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        print("didDeselectItem \(indexPath.item)")
        
        
        
    }
    
    
}
