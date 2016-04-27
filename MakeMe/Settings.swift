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
    
    static let colors = ColorProfile()
    
    struct ColorProfile {
        let cellBackground = UIColor.clearColor()
        let tableBackground = UIColor(red: 75/255, green: 169/255, blue: 185/255, alpha: 1)
    }
    
    struct SizeProfile {
        let tableViewRowHeight = UIScreen.mainScreen().bounds.height / 11
    }
    
    struct Times {
        let oneHourInSeconds: Double = 3600
        let twoHoursInSeconds: Double = 7200
        let oneDayInSeconds: Double = 86400
        let coupleOfDays: Double = 172800
        let oneWeekInSeconds: Double = 604800
        let oneMonthInSeconds: Double = 2419200
    }
    
}