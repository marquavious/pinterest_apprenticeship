//
//  ViewController.swift
//  Pinterest
//
//  Created by Marquavious on 10/23/17.
//  Copyright © 2017 Marquavious Draggon. All rights reserved.
//

import UIKit
import AVFoundation
import PINRemoteImage

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBarConstraint: NSLayoutConstraint!
    
    var pins = [Pin]()
    var lastContentOffset: CGFloat = 0 // for scroll view
    var searchbarIsUp: Bool = false
    var searchBarIsAnimating: Bool = false
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.isUserInteractionEnabled = false
        setupLayout()
        grabPins()
    }
    
    func setupLayout(){
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 5, bottom: 75, right: 5)
    }
    
    // Initial grab for pins
    func grabPins(){
        PinServiceLayer.grabPins { (error, pins) in
            
            for pin in pins {
                self.pins.append(pin)
            }
            
            self.pins = pins
            self.collectionView.reloadData()
        }
    }
    
    // Insert pins after
    func insertPins(){
        PinServiceLayer.grabPins { (error, pins) in
            
            for pin in pins {
                self.pins.append(pin)
            }
            
            self.collectionView.reloadData()
        }
    }
    
    func hideSearchBar() {
        if !searchbarIsUp && !searchBarIsAnimating {
            searchBarIsAnimating = true
            UIView.animate(withDuration: 0.25, animations: {
                self.searchBarConstraint.constant = -(self.searchBar.frame.height+16)
                self.searchBar.superview?.layoutIfNeeded()
            }, completion: { (bool) in
                if bool {
                    self.searchbarIsUp = true
                    self.searchBarIsAnimating = false
                }
            })
        }
    }
    
    func showSearchBar() {
        if searchbarIsUp && !searchBarIsAnimating {
            searchBarIsAnimating = true
            UIView.animate(withDuration: 0.25, animations: {
                self.searchBarConstraint.constant = 0
                self.searchBar.superview?.layoutIfNeeded()
            }, completion: { (bool) in
                if bool {
                    self.searchbarIsUp = false
                    self.searchBarIsAnimating = false
                }
            })
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pins.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainFeedCollectionViewCell", for: indexPath) as! MainFeedCollectionViewCell
        
        let pin = pins[indexPath.row]
        cell.pin = pin
        cell.imageView.backgroundColor = pin.dominantBackgroundColor
        cell.retrivePhoto()
        
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if (self.lastContentOffset < scrollView.contentOffset.y) {
                hideSearchBar()
            } else if (self.lastContentOffset > scrollView.contentOffset.y) {
                showSearchBar()
            }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if pins.count > 24 { // If the user has scrolled past the way point
            if(scrollView.contentOffset.y + 1000 >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
                insertPins()
            }
        }
    }
}

extension ViewController : PinterestLayoutDelegate {
    
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath, withWidth width:CGFloat) -> CGFloat {
        let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let pin = pins[indexPath.row]
        let size = CGSize(width: pin.width, height: pin.height)
        let rect  = AVMakeRect(aspectRatio: size, insideRect: boundingRect)
        return rect.size.height
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        let annotationPadding = CGFloat(20)
        let annotationHeaderHeight = CGFloat(50)
        let pin = pins[indexPath.row]
        let font = UIFont(name: "Helvetica Neue", size: 12)!
        let commentHeight = pin.heightForComment(font, width: width)
        let height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding
        return CGFloat(height)
    }
    
}

