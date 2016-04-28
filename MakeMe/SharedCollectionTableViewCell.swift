//
//  SharedReminderListTableViewCell.swift
//  MakeMe
//
//  Created by Vox on 3/4/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class SharedCollectionTableViewCell: MakeMeTableViewCell {
    
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
            let counts = getCounts()
            fromCountLabel?.text = "\(counts.0)"
            toCountLabel?.text = "\(counts.1)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setLabelTextColor([titleLabel, toLabel, toCountLabel, fromLabel, fromCountLabel], color: SettingsProfile.colors.tableBackground)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func getCounts() -> (Int, Int) {
        var toCount = 0
        var fromCount = 0
        
        for i in 0..<self.reminderList!.count() {
        //for(var i = 0; i < self.reminderList!.count(); i += 1) {
            if(reminderList!.reminders[i].from != nil) {
                fromCount += 1
            } else {
                toCount += 1
            }
        }
        return(fromCount, toCount)
    }
    

}
