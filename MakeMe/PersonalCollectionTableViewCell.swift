//
//  ReminderListTableViewCell.swift
//  MakeMe
//
//  Created by Vox on 3/1/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class PersonalCollectionTableViewCell: MakeMeTableViewCell, UITextFieldDelegate {

    @IBOutlet weak var titleTextBox: UITextField!
    @IBOutlet weak var CountLabel: UILabel!
    
    var addButton: UIBarButtonItem!
    var originalAction: UnsafeMutablePointer<UIBarButtonItem>!
    
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
        
        titleTextBox.textColor = SettingsProfile.colors.tableBackground
        CountLabel.textColor = SettingsProfile.colors.tableBackground
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
        
        delegate!.cellDidBeginEditing()
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        if(reminderList != nil) {
            if(textField.text == "") {
                // delete the cell
                delegate!.deleteWithoutConfirmation(self)
            } else {
                // set the reminder lists text as the text in the cell
                reminderList?.title = textField.text!
                titleTextBox.userInteractionEnabled = false
                
                // emit to server
                //SocketIOManager.instance.createReminderList((reminderList?.title)!, number: "1234567899", to: "")
                
                delegate!.cellDidEndEditing()
            }
        }
    }
    


}
