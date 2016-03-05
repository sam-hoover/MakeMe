//
//  ReminderTableViewCell.swift
//  MakeMe
//
//  Created by Vox on 3/4/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class ReminderTableViewCell: UITableViewCell, UITextFieldDelegate {

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
        if reminder != nil {
            reminder?.text = textField.text!
        }
    }

}
