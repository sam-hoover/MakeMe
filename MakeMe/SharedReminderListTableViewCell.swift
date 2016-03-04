//
//  SharedReminderListTableViewCell.swift
//  MakeMe
//
//  Created by Vox on 3/4/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class SharedReminderListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toCountLabel: UILabel!
    @IBOutlet weak var fromCountLabel: UILabel!
    
    var reminderList: ReminderList? {
        didSet {
            update()
        }
    }
    
    func update() {
        titleLabel?.text = nil
        toCountLabel?.text = nil
        fromCountLabel?.text = nil
        
        if let reminderList = self.reminderList {
            titleLabel?.text = reminderList.title
            
            // set to this value for testing, should be count of reminders in the ReminderList
            toCountLabel?.text = "0"
            fromCountLabel?.text = "0"
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
