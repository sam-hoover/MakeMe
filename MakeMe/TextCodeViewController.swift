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
    @IBOutlet weak var topBar: UIVisualEffectView!
    
    @IBOutlet weak var hiddenTextField: UITextField!
    
    var fields = [UILabel]()
    var enteredNumbers = [Int]()
    var correctNumbers = [9,3,0,7]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fields = [field1, field2, field3, field4]
        
        hiddenTextField.delegate = self
        hiddenTextField.text = "d"
                
        round.layer.cornerRadius = 4
        
        for field in fields {
            field.backgroundColor = UIColor.whiteColor()
            field.layer.borderWidth = 0.5
            field.layer.borderColor = UIColor(white: 0.7, alpha: 1).CGColor
            field.layer.cornerRadius = 3.0
            field.font = UIFont.systemFontOfSize(field.layer.bounds.size.width * 2)
        }
        
        clearFields()
        
        hiddenTextField.becomeFirstResponder()
        

        // Do any additional setup after loading the view.
    }

    
    @IBAction func keyPress(sender: UITextField) {
        
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
    
    func setPhoneNumber(phoneNumber: String)
    {
        infoLabel.text = "We've texted you a verification code to \(phoneNumber). Please enter it here."
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
                clearFields()
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

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
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
