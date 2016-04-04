//
//  AddQuickAlertViewController.swift
//  MakeMe
//
//  Created by Vox on 3/12/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class AddQuickAlertViewController: UIViewController {

    var alert: String?
    
    @IBOutlet weak var tonightButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if(eveningHasPassed()) {
            tonightButton.enabled = false
            tonightButton.titleLabel?.textColor = UIColor.grayColor()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let destinationVeiwController = segue.destinationViewController as? PersonalReminderTableViewController {
            
            destinationVeiwController
            
        }
        
    }
    */

    @IBAction func addAlert(sender: UIButton) {
        
        let times = SettingsProfile.Times()
        
        var date = NSDate()
        
        switch(sender.tag) {
        // Later
        case 1:
            date = NSDate(timeIntervalSinceNow: times.twoHoursInSeconds)
            
        // Tonight
        case 2:
            
            
            self.alert = "Tonight"
            
        // Tomorrow Morning
        case 3:
            
            let tempDate = NSDate(timeIntervalSinceNow: times.oneDayInSeconds)
            
            date = NSCalendar.currentCalendar().dateBySettingHour(9, minute: 0, second: 0, ofDate: tempDate, options: NSCalendarOptions())!
            
        // Tomorrow Afternoon
        case 4:
            let tempDate = NSDate(timeIntervalSinceNow: times.oneDayInSeconds)
            
            date = NSCalendar.currentCalendar().dateBySettingHour(12, minute: 0, second: 0, ofDate: tempDate, options: NSCalendarOptions())!
            
        // Tomorrow Evening
        case 5:
            let tempDate = NSDate(timeIntervalSinceNow: times.oneDayInSeconds)
            
            date = NSCalendar.currentCalendar().dateBySettingHour(17, minute: 0, second: 0, ofDate: tempDate, options: NSCalendarOptions())!
            
        // In a couple days
        case 6:
            date = NSDate(timeIntervalSinceNow: times.coupleOfDays)
        
        // Next week
        case 7:
            date = NSDate(timeIntervalSinceNow: times.oneWeekInSeconds)
        
        // Next month
        case 8:
            date = NSDate(timeIntervalSinceNow: times.oneMonthInSeconds)
        default:
             break
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .ShortStyle
        alert = dateFormatter.stringFromDate(date)
        
    }
    
    
    
    func eveningHasPassed() -> Bool {
        let currentDate = NSDate()
        let eveningOfCurrentDate = NSCalendar.currentCalendar().dateBySettingHour(20, minute: 0, second: 0, ofDate: currentDate, options: NSCalendarOptions())!
        
        let eveningHasPassed = currentDate.compare(eveningOfCurrentDate) == NSComparisonResult.OrderedDescending
        
        return(eveningHasPassed)
    }
    
    
}
