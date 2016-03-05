//
//  ReminderTableViewCell.swift
//  MakeMe
//
//  Created by Vox on 3/4/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {

    @IBOutlet weak var reminderLabel: UILabel!
    
    var reminder: Reminder? {
        didSet {
            update()
        }
    }
    
    
    func update() {
        reminderLabel?.text = nil
        
        if let reminder = self.reminder {
            reminderLabel?.text = reminder.text
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
