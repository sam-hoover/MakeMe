//
//  ReminderTableViewCell.swift
//  MakeMe
//
//  Created by Vox on 3/4/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

protocol ReminderTableViewCellDelegate {
    func reminderHasBeenDeleted(reminder: Reminder, cell: UITableViewCell)
}

class ReminderTableViewCell: UITableViewCell, UITextFieldDelegate {

    var originalCenter = CGPoint()
    var deleteOnDragRelease = false
    // The object that acts as delegate for this cell.
    var delegate: ReminderTableViewCellDelegate?
    
    @IBOutlet weak var reminderText: UITextField!
    
    var reminder: Reminder? {
        didSet {
            update()
        }
    }
    
    
    func update() {
        reminderText?.text = nil
        
        if let reminder = self.reminder {
            reminderText?.text = reminder.text
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        reminderText.delegate = self
        
        // add a pan recognizer
        let recognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        recognizer.delegate = self
        addGestureRecognizer(recognizer)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // hide the keyboard
        textField.resignFirstResponder()
        
        return(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if(reminder != nil) {
            if(textField.text == "") {
                // delete the cell
            } else {
                // set the reminders text as the text in the cell
                reminder?.text = textField.text!
            }
        }
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
            if delegate != nil && reminder != nil {
                // notify the delegate that this item should be deleted
                delegate!.reminderHasBeenDeleted(reminder!, cell: self)
            }
        }
    }
    
    
} // class
