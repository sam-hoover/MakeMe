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
    
    
    func add(reminder: Reminder) {
        reminders += [reminder]
    }
    
    
    func add(reminderArray: [Reminder]) {
        reminders += reminderArray
    }
    
    
    func remove(atIndex: Int) {
        reminders.removeAtIndex(atIndex)
    }
    
    
    func getCompletionStatusOfReminder(atIndex: Int) -> Bool {
        return reminders[atIndex].completed
    }
    
    
    func getReminder(atIndex: Int) -> Reminder {
        return self.reminders[atIndex]
    }
    
    
    func count() -> Int {
        return reminders.count
    }
    
}
