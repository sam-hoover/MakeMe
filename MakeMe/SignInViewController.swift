//
//  SignInViewController.swift
//  MakeMe
//
//  Created by Jordan Soltman on 3/7/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let greenColor = UIColor(red: 77/255.0, green: 196/255.0, blue: 44/255.0, alpha: 1).CGColor
        continueButton.layer.backgroundColor = greenColor
        continueButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)

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

}
