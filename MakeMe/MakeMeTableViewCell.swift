//
//  MakeMeTableViewCell.swift
//  MakeMe
//
//  Created by Vox on 3/5/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

protocol MakeMeTableViewCellDelegate {
    func cellHasBeenDeleted(cell: UITableViewCell)
    func cellHasBeenSelected(cell:UITableViewCell)
}

class MakeMeTableViewCell: UITableViewCell {

    var originalCenter = CGPoint()
    var deleteOnDragRelease = false
    
    var completedImage: UIImage!
    var deletedImage: UIImage!
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

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        let completedImageView = UIImageView(frame: CGRect(x: -kUICuesWidth - kUICuesMargin, y: 0, width: kUICuesWidth, height: bounds.size.height))
        
        let deletedImageView = UIImageView(frame: CGRect(x: bounds.size.width + kUICuesMargin, y: 0, width: kUICuesWidth, height: bounds.size.height))
        
        completedImage = UIImage(named: "Complete")
        completedImageView.image = completedImage
        
        deletedImage = UIImage(named: "Deleted")
        deletedImageView.image = deletedImage
        
        addSubview(completedImageView)
        addSubview(deletedImageView)
        
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
            
        }
        
        if recognizer.state == .Ended {
            // the frame this cell had before user dragged it
            let originalFrame = CGRect(x: 0, y: frame.origin.y,
                width: bounds.size.width, height: bounds.size.height)
            if !deleteOnDragRelease {
                // if the item is not being deleted, snap back to the original location
                UIView.animateWithDuration(0.2, animations: {self.frame = originalFrame})
            }
        }
        
        if deleteOnDragRelease {
            if delegate != nil {
                // notify the delegate that this item should be deleted
                delegate!.cellHasBeenDeleted(self)
            }
        }
    }

    
}
