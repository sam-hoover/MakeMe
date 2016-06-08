//
//  ReminderTableViewController.swift
//  MakeMe
//
//  Created by Vox on 3/4/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class PersonalReminderTableViewController: MakeMeTableViewController, MakeMeTableViewCellDelegate, UIPopoverPresentationControllerDelegate {

    var reminderList = ReminderList()
    var indexOfSelectedCell: NSIndexPath?

    @IBOutlet weak var addNewReminderButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
                
        setTitle()
    }
    
    
    override func viewWillDisappear(animated : Bool) {
        super.viewWillDisappear(animated)
        
        // add completed items to completed reminder list and remove from this reminder list
        checkForCompleted()
        
        let stackCount = self.navigationController?.viewControllers.count
        
        if stackCount >= 1 {
            // for whatever reason, the last item on the stack is the TaskBuilderViewController (not self), so we only use -1 to access it
            if let dvc = self.navigationController?.viewControllers[stackCount! - 1] as? PersonalCollectionTableViewController {
                dvc.returnFromReminderList(self)
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminderList.count()
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // not sure why i have to downcast here ("as!") and cannot just use "as"
        let cellReuseIdentifier = "ReminderTableCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! ReminderTableViewCell
        
        // Configure the cell...
        let reminder = reminderList.reminders[indexPath.row]
        
        cell.reset()
        
        cell.reminder = reminder
        cell.selectionStyle = .None
        cell.delegate = self
        
        return cell
    }

    
    // MARK: - Navigation
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showAddQuickAlarm" {
            if ((segue.destinationViewController as? AddQuickAlertViewController) != nil) {
                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem
            }
        }
    }

    
    @IBAction func unwindFromAddQuickAlert(segue: UIStoryboardSegue) {
        
        if let sourceViewController = segue.sourceViewController as? AddQuickAlertViewController {
            
            if let selectedIndexPath = indexOfSelectedCell {
                
                reminderList.reminders[selectedIndexPath.row].alert = sourceViewController.alert
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
        }
    }
    
    
    @IBAction func unwindFromAddCustomAlert(segue: UIStoryboardSegue) {
        
        if let sourceViewController = segue.sourceViewController as? AddCustomeAlertViewController {
            
            if let selectedIndexPath = indexOfSelectedCell {
                
                reminderList.reminders[selectedIndexPath.row].alert = sourceViewController.alert
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
        }
    }
    
    
    // MARK: - Actions
    
    @IBAction func addNewReminder(sender: UIBarButtonItem) {
        
        let reminder = Reminder(txt: "")
        
        reminderList.add(reminder)
        
        self.tableView.reloadData()
        
        let path = NSIndexPath(forRow: reminderList.count() - 1, inSection: 0)
        if let cell = self.tableView.cellForRowAtIndexPath(path) as? ReminderTableViewCell {
            cell.textFieldDidBeginEditing(cell.reminderText)
        }
    }
    
    
    // MARK: - MakeMeTableViewCellDelegate
    
    func alertBeingAddedtoCell(cell: UITableViewCell) {
    
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("AddQuickAlarm")
        
        vc.modalPresentationStyle = UIModalPresentationStyle.Popover
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds

        vc.preferredContentSize = CGSizeMake(screenSize.width, screenSize.width)
        
        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
        
        popover.delegate = self
        popover.sourceView = self.view
        popover.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        
        self.presentViewController(vc, animated: true, completion:nil)
    
    }
    
    func cellDidBeginEditing() {
       self.navigationItem.rightBarButtonItem?.enabled = false
    }
    
    func cellDidEndEditing() {
       self.navigationItem.rightBarButtonItem?.enabled = true
    }
    
    func cellHasBeenCompleted(cell: UITableViewCell) {
        
        //let index = self.indexOfSelectedCell
        
        if let rtc = cell as? ReminderTableViewCell {
            if !rtc.isCompleted {
                rtc.reminderText.textColor = UIColor.grayColor()
            } else {
                rtc.reminderText.textColor = SettingsProfile.colors.tableBackground
            }

            rtc.isCompleted = !rtc.isCompleted
        }
    }
    
    func deleteWithConfirmation(cell: UITableViewCell) {
        
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive, handler: {(alert :UIAlertAction!) in
            if let index = self.tableView.indexPathForCell(cell) {
                // could removeAtIndex in the loop but keep it here for when indexOfObject works
                self.reminderList.reminders.removeAtIndex(index.row)
                
                // use the UITableView to animate the removal of this row
                self.tableView.beginUpdates()
                let indexPathForRow = NSIndexPath(forRow: index.row, inSection: 0)
                self.tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
                self.tableView.endUpdates()
            }
        })
        
        confirmDeletion(cell, deleteAction: deleteAction)
        
    }
    
    
    func deleteWithoutConfirmation(cell: UITableViewCell) {
        if let index = self.tableView.indexPathForCell(cell) {
            // could removeAtIndex in the loop but keep it here for when indexOfObject works
            self.reminderList.reminders.removeAtIndex(index.row)
            
            // use the UITableView to animate the removal of this row
            self.tableView.beginUpdates()
            let indexPathForRow = NSIndexPath(forRow: index.row, inSection: 0)
            self.tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
            self.tableView.endUpdates()
        }
    }
    
    
    func cellHasBeenSelected(cell: UITableViewCell) {
        if let index = self.tableView.indexPathForCell(cell) {
            indexOfSelectedCell = index
        }
    }
    
    // MARK: - UIPopoverPresentationControllerDelegate
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        
        let navigationController = UINavigationController(rootViewController: controller.presentedViewController)
        let btnDone = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(PersonalReminderTableViewController.dismiss))
        navigationController.topViewController!.navigationItem.rightBarButtonItem = btnDone
        
        
        return navigationController
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func checkForCompleted() {
        var i = 0
        while i < self.reminderList.count() {
            if self.reminderList.getCompletionStatusOfReminder(i) {
                
                // add the completed item to the completed reminder list
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.completedReminderList.add(self.reminderList.getReminder(i))
                
                // remove the completed item frm this reminder list
                self.reminderList.remove(i)
            } else {
                i += 1
            }
        }
    }
    
    // MARK: - Setup
    
    func setTitle() {
        self.navigationItem.title = reminderList.title
    }

}
