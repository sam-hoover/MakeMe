//
//  Settings.swift
//  MakeMe
//
//  Created by Vox on 3/8/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import Foundation
import UIKit


class SettingsProfile {
    
    struct ColorProfile {
        // Spinach Green
        let cellBackground = UIColor.greenColor()
    }
    
    struct SizeProfile {
        let tableViewRowHeight = UIScreen.mainScreen().bounds.height / 11
    }
    
    struct Times {
        let oneHourInSeconds: Double = 3600
        let twoHoursInSeconds: Double = 7200
        let coupleOfDays: Double = 172800
        let oneWeekInSeconds: Double = 604800
        let oneMonthInSeconds: Double = 2419200
    }
    
}