//
//  ShareReminderTableViewController.swift
//  MakeMe
//
//  Created by Vox on 3/5/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class ShareReminderTableViewController: UITableViewController, MakeMeTableViewCellDelegate {

    struct Index {
        static let from = 0
        static let to = 1
    }
    
    var reminderLists = [ReminderList(title: "From"), ReminderList(title: "To")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return reminderLists.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reminderLists[section].reminders.count
    }
    
    func setupReminders(reminderList: ReminderList) {
        for(var i = 0; i < reminderList.count(); i++) {
            if(reminderList.reminders[i].from != nil) {
                self.reminderLists[Index.from].reminders += [reminderList.reminders[i]]
            } else {
                self.reminderLists[Index.to].reminders += [reminderList.reminders[i]]
            }
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // not sure why i have to downcast here ("as!") and cannot just use "as"
        let cellReuseIdentifier = "ReminderTableCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! ReminderTableViewCell
        
        // Configure the cell...
        let reminder = reminderLists[indexPath.section].reminders[indexPath.row]
        
        cell.reminder = reminder
        cell.selectionStyle = .None
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(reminderLists[section].title)"
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Actions
    
    @IBAction func addNewReminder(sender: UIBarButtonItem) {
        let reminder = Reminder(txt: "")
        
        reminderLists[Index.to].reminders += [reminder]
        
        self.tableView.reloadData()
        
        let path = NSIndexPath(forRow: reminderLists[Index.to].reminders.count - 1, inSection: Index.to)
        if let cell = self.tableView.cellForRowAtIndexPath(path) as? ReminderTableViewCell {
            cell.textFieldDidBeginEditing(cell.reminderText)
        }
    }
    
    
    @IBAction func returnToParentViewController(sender: UIBarButtonItem) {
         self.performSegueWithIdentifier("toSharedReminderList", sender: self)
    }
    
    
    
    // MARK: - MakeMeTableViewCellDelegate
    
    func cellHasBeenDeleted(cell: UITableViewCell) {
        
        if let index = self.tableView.indexPathForCell(cell) {
            
            reminderLists[index.section].reminders.removeAtIndex(index.row)
            
            // use the UITableView to animate the removal of this row
            tableView.beginUpdates()
            let indexPathForRow = NSIndexPath(forRow: index.row, inSection: index.section)
            tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
            tableView.endUpdates()
        }
    }

}
