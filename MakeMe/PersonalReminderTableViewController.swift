//
//  ReminderTableViewController.swift
//  MakeMe
//
//  Created by Vox on 3/4/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class PersonalReminderTableViewController: UITableViewController, MakeMeTableViewCellDelegate {

    var reminderList = ReminderList()
    var indexOfSelectedCell: NSIndexPath?

    @IBOutlet weak var addNewReminderButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTitle()
        
        self.tableView.rowHeight = UIScreen.mainScreen().bounds.height / 11
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
        
        reminder.alert = "Alert"
        
        cell.reminder = reminder
        cell.selectionStyle = .None
        cell.delegate = self
        
        return cell
    }

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        /*
        if(segue.identifier == "showAddQuickAlarm") {
            if let destinationViewController = segue.destinationViewController as? AddQuickAlertViewController {
                
        // TODO: Need to find a way to get the index of the current cell to be able to add alert to the correct reminder
        
        
            }
        }
        */
    }
    
    
    @IBAction func unwindFromAddQuickAlert(segue: UIStoryboardSegue) {
        
        if let sourceViewController = segue.sourceViewController as? AddQuickAlertViewController {
            
            //let list = sourceViewController.reminderList
            
            if let selectedIndexPath = sourceViewController.reminderIndex {
                // update an existing list
                
                // set the reminder's alert at the selected cell
                reminderList.reminders[selectedIndexPath.row].alert = sourceViewController.alert
                
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                
            } else {
                // add a new list
                
            }
            // Save the list to disc here
            
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
    
    
    @IBAction func returnToParentViewController(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("toPersonalReminderList", sender: self)
    }
    
    
    // MARK: - MakeMeTableViewCellDelegate

    func cellHasBeenDeleted(cell: UITableViewCell) {

            if let index = self.tableView.indexPathForCell(cell) {
        
            // could removeAtIndex in the loop but keep it here for when indexOfObject works
            reminderList.reminders.removeAtIndex(index.row)
        
            // use the UITableView to animate the removal of this row
            tableView.beginUpdates()
            let indexPathForRow = NSIndexPath(forRow: index.row, inSection: 0)
            tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
            tableView.endUpdates()
        }
    }
    
    
    // MARK: - Setup
    
    func setTitle() {
        self.navigationItem.title = reminderList.title
    }

}
