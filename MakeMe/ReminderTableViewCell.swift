//
//  ReminderTableViewCell.swift
//  MakeMe
//
//  Created by Vox on 3/4/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class ReminderTableViewCell: MakeMeTableViewCell, UITextFieldDelegate {

    @IBOutlet weak var reminderText: UITextField!
    @IBOutlet weak var addAlertButton: UIButton!
    @IBOutlet weak var alertLabel: UILabel!
    
    var reminder: Reminder? {
        didSet {
            update()
        }
    }
    
    
    func update() {
        reminderText?.text = nil
        alertLabel?.text = nil
        
        if let reminder = self.reminder {
            reminderText?.text = reminder.text
            alertLabel?.text = reminder.alert
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
        addAlertButton.hidden = true
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // hide the keyboard
        textField.resignFirstResponder()
        
        return(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        addAlertButton.hidden = false
        textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if(reminder != nil) {
            if(textField.text == "") {
                // delete the cell
                delegate!.cellHasBeenDeleted(self)
            } else {
                // set the reminders text as the text in the cell
                reminder?.text = textField.text!
            }
        }
        
        addAlertButton.hidden = true
    }
    
    
    // MARK: - Actions
    @IBAction func addAlert(sender: UIButton) {
        delegate!.cellHasBeenSelected(self)
    }
    
    
} // class
