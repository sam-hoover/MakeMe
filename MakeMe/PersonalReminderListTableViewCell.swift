//
//  ReminderListTableViewCell.swift
//  MakeMe
//
//  Created by Vox on 3/1/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class PersonalReminderListTableViewCell: MakeMeTableViewCell, UITextFieldDelegate {

    @IBOutlet weak var titleTextBox: UITextField!
    @IBOutlet weak var CountLabel: UILabel!
    
    var reminderList: ReminderList? {
        didSet {
            update()
        }
    }
    
    func update() {
        titleTextBox?.text = nil
        CountLabel?.text = nil
        
        if let reminderList = self.reminderList {
            titleTextBox?.text = reminderList.title
            
            CountLabel?.text = "\(reminderList.count())"
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleTextBox.delegate = self
        titleTextBox.userInteractionEnabled = false
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
        titleTextBox.userInteractionEnabled = true
        textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if(reminderList != nil) {
            if(textField.text == "") {
                // delete the cell
                delegate!.cellHasBeenDeleted(self)
            } else {
                // set the reminder lists text as the text in the cell
                reminderList?.title = textField.text!
                titleTextBox.userInteractionEnabled = false
            }
        }
    }
    

}
