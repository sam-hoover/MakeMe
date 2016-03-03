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
    var personal: [Reminder]
    var shared: [Reminder]
    
    init() {
        title = "title"
        personal = [Reminder]()
        shared = [Reminder]()
    }
    
    // temp for testing
    init(title: String) {
        self.title = title
        personal = [Reminder]()
        shared = [Reminder]()
    }
    
}
