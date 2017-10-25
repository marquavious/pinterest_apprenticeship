//
//  ViewController.swift
//  Pinterest
//
//  Created by Marquavious on 10/23/17.
//  Copyright © 2017 Marquavious Draggon. All rights reserved.
//

import UIKit
import PINRemoteImage

protocol mainFeedCollectionViewCellDelegate {
    func frameForCircleLoader(frame: CGRect)
}

class MainFeedCollectionViewCell: UICollectionViewCell {
    
    var photoLink: String?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cellPictureBackground: UIView! 
    
    var pin: Pin? {
        didSet {
            if let pin = pin {
                descriptionLabel.text = pin.description
                photoLink = pin.imageLink
            }
        }
    }
    
    func retrivePhoto() {
        guard let photoLink = photoLink  else { return }
        guard let imageLink = URL(string: photoLink) else { return }
        self.imageView.pin_updateWithProgress = true
        self.imageView.pin_setImage(from: imageLink)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.pin_cancelImageDownload()
        imageView.image = nil
        descriptionLabel.text = nil
        cellPictureBackground.backgroundColor = nil
    }
    
    override func awakeFromNib() {
        imageView.layer.masksToBounds = true
        cellPictureBackground.layer.masksToBounds = true
        cellPictureBackground.layer.cornerRadius = 8
    }
}
