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
    var reminderIndex: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addAlert(sender: UIButton) {
        
        switch(sender.tag) {
            
        // Later
        case 1:
            self.alert = "Later"
        // Tonight
        case 2:
            self.alert = "Tonight"
            
        // Tomorrow Morning
        case 3:
            self.alert = "Tomorrow Morning"
        
        // Tomorrow Afternoon
        case 4:
            self.alert = "Tomorrow Afternoon"
            
        // Tomorrow Evening
        case 5:
            self.alert = "Tomorrow Evening"
        
        // In a couple days
        case 6:
            self.alert = "In a couple days"
        
        // Next week
        case 7:
            self.alert = "Next week"
        
        // Next month
        case 8:
            self.alert = "Next month"

        default:
             break
        }
        
        
        
    }
}
