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
    
    @IBOutlet weak var toggleCompletedButton: UIButton!
    
    var isCompleted: Bool = false
    
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
        
        reminderText.textColor = SettingsProfile.colors.tableBackground
        alertLabel.textColor = SettingsProfile.colors.tableBackground
        
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
        
        delegate!.cellDidBeginEditing()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if(reminder != nil) {
            if(textField.text == "") {
                // delete the cell
                delegate!.deleteWithoutConfirmation(self)
            } else {
                // set the reminders text as the text in the cell
                reminder?.text = textField.text!
                
                // send the reminder we just created to the server to be stored
                SocketIOManager.instance.createReminder((reminder?.text)!, number: "1234567890", listID: "abcd", alarm: 10)
            }
        }
        
        delegate!.cellDidEndEditing()
        addAlertButton.hidden = true
        
    }
    
    
    // MARK: - Actions
    @IBAction func addAlert(sender: UIButton) {
        reminderText.resignFirstResponder()
        delegate!.cellHasBeenSelected(self)
        
        
        
    }
    
    
    @IBAction func toggleCompleted(sender: UIButton) {
        isCompleted = !isCompleted
        self.reminder?.completed = !((self.reminder?.completed)!)
        
        if(isCompleted) {
            sender.setImage(UIImage(named: "Completed"), forState: .Normal)
            self.reminderText.textColor = SettingsProfile.colors.completedReminderTextColor
            self.alertLabel.textColor = SettingsProfile.colors.completedReminderTextColor
        } else {
            sender.setImage(UIImage(named: "NotCompleted"), forState: .Normal)
            self.reminderText.textColor = SettingsProfile.colors.reminderTextColor
            self.alertLabel.textColor = SettingsProfile.colors.reminderTextColor
        }
    }
    
    
    
} // class
