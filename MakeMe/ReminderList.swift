//
//  ReminderList.swift
//  MakeMe
//
//  Created by Vox on 3/1/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import Foundation

class ReminderList {
 
    var title: String
    var reminders: [Reminder]
    
    init() {
        title = "title"
        reminders = [Reminder]()
    }
    
    // temp for testing
    init(title: String) {
        self.title = title
        reminders = [Reminder]()
    }
    
}
