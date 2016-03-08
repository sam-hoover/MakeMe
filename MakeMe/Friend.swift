//
//  Friend.swift
//  MakeMe
//
//  Created by Vox on 3/8/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import Foundation


class Friend {
    
    var name: String?
    var phone: String?
    
    init() {
        
    }
    
    init(name: String, phone: String) {
        self.name = name
        self.phone = phone
    }
}