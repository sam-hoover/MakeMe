//
//  AddPersonalListViewController.swift
//  MakeMe
//
//  Created by Vox on 3/2/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class AddPersonalListViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    var personalList: ReminderList?
    
    @IBOutlet weak var listTitleLabel: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        listTitleLabel.delegate = self
        
        
        // check title to enable save button
        checkValidTitle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    // MARK: - Actions
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(saveButton === sender) {
                print("save button prepare for seque")
            
                let title = listTitleLabel.text ?? ""
            
                personalList = ReminderList(title: title)
        }
    }

    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // hide the keyboard
        
        textField.resignFirstResponder()
        
        return(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidTitle()
    }
    
    func checkValidTitle() {
        // Disable the Save button if the text field is empty.
        let title = listTitleLabel.text ?? ""
        saveButton.enabled = !title.isEmpty
    }


}
