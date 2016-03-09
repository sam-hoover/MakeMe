//
//  SignUpViewController.swift
//  MakeMe
//
//  Created by Jordan Soltman on 3/7/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var phoneField: UITextField!
    
    static let KEYBOARD_HEIGHT = 250
    static let KEYBOARD_BUFFER = 125
    
    @IBAction func tapOutside(sender: UITapGestureRecognizer) {
        passwordField.resignFirstResponder()
        nameField.resignFirstResponder()
        phoneField.resignFirstResponder()
    }
    
    @IBAction func editingBegan(sender: UITextField) {
        
        let frameInWindow = sender.convertRect(sender.bounds, toView: self.view)
        let distanceFromBottom = self.view.frame.size.height - (frameInWindow.origin.y + frameInWindow.size.height)
        
        let change = (SignUpViewController.KEYBOARD_HEIGHT + SignUpViewController.KEYBOARD_BUFFER) - Int(distanceFromBottom)
        
        if(change > 0)
        {
            let frame = self.view.frame
            UIView.animateWithDuration(0.3) {
                self.view.frame = CGRectMake(frame.origin.x, CGFloat(-change), frame.size.width, frame.size.height)
            }
        }
        
    }
    
    @IBAction func editingEnded(sender: UITextField)
    {
        let frame = self.view.frame
        UIView.animateWithDuration(0.3) {
            self.view.frame = CGRectMake(frame.origin.x, 0, frame.size.width, frame.size.height)
        }
        
        sender.backgroundColor = UIColor.clearColor()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let greenColor = UIColor(red: 77/255.0, green: 196/255.0, blue: 44/255.0, alpha: 1).CGColor
        continueButton.layer.backgroundColor = greenColor
        continueButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField === nameField {
            phoneField.becomeFirstResponder()
        } else if textField === phoneField {
            passwordField.becomeFirstResponder()
        } else if textField === passwordField {
            passwordField.resignFirstResponder()
        }
        
        return true
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continuePressed()
    {
        
        if nameField.text! == "" {
            highlightField(nameField)
            return
        }
        
        if phoneField.text! == "" {
            highlightField(phoneField)
            return
        }
        
        if passwordField.text! == "" {
            highlightField(passwordField)
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("textCode") as! TextCodeViewController
        vc.phoneNumber = phoneField.text!
        presentViewController(vc, animated: true, completion: nil)
    }
    
    func highlightField(textField: UITextField)
    {
        textField.backgroundColor = UIColor(red: 1.0, green: 193/255.0, blue: 193/255.0, alpha: 1)
        textField.becomeFirstResponder()
        textField.placeholder = "Required field"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.destinationViewController is TextCodeViewController {
            let vc = segue.destinationViewController as! TextCodeViewController
        }
        
        //vc.setPhoneNumber(phoneField.text!)
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
