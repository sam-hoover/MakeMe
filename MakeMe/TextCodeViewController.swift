//
//  TextCodeViewController.swift
//  MakeMe
//
//  Created by Jordan Soltman on 3/7/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit
import AudioToolbox

class TextCodeViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var field1: UILabel!
    @IBOutlet weak var field2: UILabel!
    @IBOutlet weak var field3: UILabel!
    @IBOutlet weak var field4: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var round: UIView!
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var topBarTop: NSLayoutConstraint!
    @IBOutlet weak var incorrectCodeWarning: UILabel!
    @IBOutlet weak var textMessageContent: UILabel!
    
    @IBOutlet weak var hiddenTextField: UITextField!
    
    var fields = [UILabel]()
    var enteredNumbers = [Int]()
    var correctNumbers: [Int] = []
    var phoneNumber: String = ""
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Generate a code and set the text message up
        correctNumbers = (1...4).map{_ in Int(arc4random_uniform(9))}
        textMessageContent.text = "Your verification code is \(correctNumbers[0])\(correctNumbers[1])\(correctNumbers[2])\(correctNumbers[3])!"
        
        fields = [field1, field2, field3, field4]
        
        hiddenTextField.delegate = self
        hiddenTextField.text = "d"
        
        infoLabel.text = "We've texted you a verification code to \(phoneNumber). Please enter it here."
        
        for field in fields {
            field.backgroundColor = UIColor.whiteColor()
            field.layer.borderWidth = 0.5
            field.layer.borderColor = UIColor(white: 0.7, alpha: 1).CGColor
            field.layer.cornerRadius = 3.0
            field.font = UIFont.systemFontOfSize(field.layer.bounds.size.width * 2)
        }
        
        clearFields()
        
        topBar.hidden = false
        
        hiddenTextField.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.view.layoutIfNeeded()
        self.topBarTop.constant = 0
        
        // This code emulates a text vibration
        let delay = 2.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue()) {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    
        // This code drops the text message down
        
        UIView.animateWithDuration(0.5, delay: 2.0, usingSpringWithDamping: 1, initialSpringVelocity: 3, options: [], animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
        
    }

    
    @IBAction func keyPress(sender: UITextField) {
        
        // This function does some weird shit. You can't display a keyboard without
        // a text field and so we use a hidden text field to capture values from the keyboard.
        // We always leave a "d" in the text field so that after a key is pressed we can
        // check to see if a delete key was pressed.
        // It's a little funk but it works well
        
        if let value = sender.text {
            if value == "" { deletePressed() }
            else {
                let index = value.startIndex.advancedBy(1)
                let stringValue = value.substringFromIndex(index)
                let intValue = Int(stringValue)!
                numberPressed(intValue)
            }
        }
        
        sender.text = "d"
        
    }
    
    func clearFields()
    {
        for field in fields {
            field.text = "•"
        }
        enteredNumbers = []
    }
    
    func numberPressed(number: Int)
    {
        
        if(enteredNumbers.count < 4)
        {
            fields[enteredNumbers.count].text = "\(number)"
        }
        
        enteredNumbers.append(number)
        
        if(enteredNumbers.count == 4)
        {
            if enteredNumbers == correctNumbers {
                self.performSegueWithIdentifier("tutorialSegue", sender: self)
            } else {
                
                let delay = 0.4 * Double(NSEC_PER_SEC)
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue()) {
                    self.clearFields()
                }
                
                self.incorrectCodeWarning.alpha = 1.0
                
                UIView.animateWithDuration(1.0, delay: 1.0, options: [], animations: {
                    self.incorrectCodeWarning.alpha = 0.0

                    }, completion: nil)
                
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
        }
        
        print(enteredNumbers)
    }
    
    func deletePressed()
    {
        if enteredNumbers.count > 0 {
            enteredNumbers.removeLast()
            fields[enteredNumbers.count].text = "•"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textfiel(textField: UITextField) {
        print("edited")
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
