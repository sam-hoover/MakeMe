//
//  AddCustomeAlertViewController.swift
//  MakeMe
//
//  Created by Vox on 3/12/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class AddCustomeAlertViewController: UIViewController {

    var alert: String?

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var setAlertButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Custom Alarm"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .LongStyle
        dateFormatter.timeStyle = .ShortStyle
        alert = dateFormatter.stringFromDate(datePicker.date)
    }

}
