//
//  MakeMeTableViewCell.swift
//  MakeMe
//
//  Created by Vox on 3/5/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

protocol MakeMeTableViewCellDelegate {
    func cellHasBeenCompleted(cell: UITableViewCell)
    func cellHasBeenDeleted(cell: UITableViewCell)
    func cellHasBeenSelected(cell: UITableViewCell)
}

class MakeMeTableViewCell: UITableViewCell {

    var originalCenter = CGPoint()
    var deleteOnDragRelease = false
    var completeOnDragRelease = false
    
    var completedImageView: UIImageView!
    var completedImage: UIImage!
    var deletedImageView: UIImageView!
    var deletedImage: UIImage!
    
    var hasBeenDeleted = false
    
    
    let kUICuesMargin: CGFloat = 10.0, kUICuesWidth: CGFloat = 50.0
    
    
    // The object that acts as delegate for this cell.
    var delegate: MakeMeTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // add a pan recognizer
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(MakeMeTableViewCell.handlePan(_:)))
        recognizer.delegate = self
        addGestureRecognizer(recognizer)
    }


    override func layoutSubviews() {
        super.layoutSubviews()
        
        // self.backgroundColor = SettingsProfile.colors.cellBackground
        
        // this allows the contextual cues to be shown outside of the cell bounds
        self.contentView.superview?.clipsToBounds = false
        
        completedImageView = UIImageView(frame: CGRect(x: -frame.size.height, y: 0, width: bounds.size.height, height: bounds.size.height))
        completedImageView.image = UIImage(named: "Complete")
        completedImageView.hidden = true
        
        deletedImageView = UIImageView(frame: CGRect(x: bounds.size.width, y: 0, width: bounds.size.height, height: bounds.size.height))
        deletedImageView.image = UIImage(named: "Delete")
        deletedImageView.hidden = true

        addSubview(completedImageView)
        addSubview(deletedImageView)

    }
    
    
    func addContenxtualCue(cue: UIImageView, cueImage: UIImage, x: CGFloat, y: CGFloat) {
        
        cue.frame = CGRect(x: x, y: y, width: bounds.size.height, height: bounds.size.height)
        cue.image = cueImage
        //contextualCue.contentMode = UIViewContentMode.ScaleToFill
        
        addSubview(cue)
    }
    
    
    // MARK: UIGestureRecognizer
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = panGestureRecognizer.translationInView(superview!)
            if fabs(translation.x) > fabs(translation.y) {
                return true
            }
            return false
        }
        return false
    }
    
    
    //MARK: - horizontal pan gesture methods
    
    func handlePan(recognizer: UIPanGestureRecognizer) {
        
        if recognizer.state == .Began {
            // when the gesture begins, record the current center location
            originalCenter = center
        }
        
        if recognizer.state == .Changed {
            let translation = recognizer.translationInView(self)
            center = CGPointMake(originalCenter.x + translation.x, originalCenter.y)
            
            // has the user dragged the item far enough to initiate a delete/complete?
            deleteOnDragRelease = frame.origin.x < -frame.size.width / 2.0
            completeOnDragRelease = frame.origin.x > frame.size.width / 2.0
            
            if(center.x < frame.size.width / 4) {
                deletedImageView.hidden = false
            } else if(center.x > frame.size.width - (frame.size.width / 4)) {
                completedImageView.hidden = false
            } else {
                completedImageView.hidden = true
                deletedImageView.hidden = true
            }
            
        }
        
        if recognizer.state == .Ended {
            // the frame this cell had before user dragged it
            let originalFrame = CGRect(x: 0, y: frame.origin.y,
                width: bounds.size.width, height: bounds.size.height)
            if !deleteOnDragRelease {
                // if the item is not being deleted, snap back to the original location
                UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
            }
            
            if completeOnDragRelease {
                delegate!.cellHasBeenCompleted(self)
            }
            
        }
        
        if deleteOnDragRelease {
            if delegate != nil {
                // notify the delegate that this item should be deleted
                delegate!.cellHasBeenDeleted(self)
            }
        }
    }
    
    
    
    // MARK: - Utility
    
    func setLabelTextColor(labels: [UILabel], color: UIColor) {
        for label in labels {
            label.textColor = color
        }
    }

    
}
