//
//  Reminder.swift
//  MakeMe
//
//  Created by Vox on 3/2/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import Foundation

class Reminder {
    
    var text: String
    var completed: Bool = false
    var alert: String?
    var to: String?
    var from: String?
    
    init() {
        text = ""
    }
    
    init(txt: String) {
        text = txt
    }
    
    func markAsCompleted() {
        completed = true
    }
    
}