//
//  ReminderListTableViewCell.swift
//  MakeMe
//
//  Created by Vox on 3/1/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class ReminderListTableViewCell: UITableViewCell {

    var reminderList: ReminderList? {
        didSet {
            update()
        }
    }
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var CountLabel: UILabel!
    
    
    func update() {
        TitleLabel?.text = nil
        CountLabel?.text = nil
        
        if let reminderList = self.reminderList {
            TitleLabel?.text = reminderList.title
            
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
