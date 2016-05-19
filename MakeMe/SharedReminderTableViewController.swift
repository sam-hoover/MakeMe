//
//  ShareReminderTableViewController.swift
//  MakeMe
//
//  Created by Vox on 3/5/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class SharedReminderTableViewController: MakeMeTableViewController, MakeMeTableViewCellDelegate {

    struct Index {
        static let from = 0
        static let to = 1
    }
    
    
    var reminderLists = [ReminderList(title: "From"), ReminderList(title: "To")]
    var listTitle: String?
    var indexOfSelectedCell: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.estimatedRowHeight = tableView.rowHeight
        //tableView.rowHeight = UITableViewAutomaticDimension
        
        setTitle()
    }
    
    
    override func viewWillDisappear(animated : Bool) {
        super.viewWillDisappear(animated)
        
        let stackCount = self.navigationController?.viewControllers.count
        
        if stackCount >= 1 {
            if let dvc = self.navigationController?.viewControllers[stackCount! - 1] as? SharedCollectionTableViewController {
                dvc.updateCollection(self)
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return reminderLists.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminderLists[section].reminders.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // not sure why i have to downcast here ("as!") and cannot just use "as"
        let cellReuseIdentifier = "ReminderTableCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! ReminderTableViewCell
        
        // Configure the cell...
        let reminder = reminderLists[indexPath.section].reminders[indexPath.row]
        
        cell.reset()
        
        // disables adding alarms or editing reminders from others; user can only complete or delete
        if indexPath.section == Index.from {
            cell.addAlertButton.hidden = true;
            cell.reminderText.userInteractionEnabled = false;
        }
        
        cell.reminder = reminder
        cell.selectionStyle = .None
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(reminderLists[section].title) \(listTitle!)"
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
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
                
                reminderLists[selectedIndexPath.section].reminders[selectedIndexPath.row].alert = sourceViewController.alert
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
        }
    }
    
    
    @IBAction func unwindFromAddCustomAlert(segue: UIStoryboardSegue) {
        
        if let sourceViewController = segue.sourceViewController as? AddCustomeAlertViewController {
        
            if let selectedIndexPath = indexOfSelectedCell {
                
                reminderLists[selectedIndexPath.section].reminders[selectedIndexPath.row].alert = sourceViewController.alert
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
            }
        }
    }
    
    
    
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
    
    
    // MARK: - MakeMeTableViewCellDelegate
    
    func cellDidBeginEditing() {
        self.navigationItem.rightBarButtonItem?.enabled = false
    }
    
    func cellDidEndEditing() {
        self.navigationItem.rightBarButtonItem?.enabled = true
    }
    
    func cellHasBeenCompleted(cell: UITableViewCell) {
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
                
                self.reminderLists[index.section].reminders.removeAtIndex(index.row)
                
                // use the UITableView to animate the removal of this row
                self.tableView.beginUpdates()
                let indexPathForRow = NSIndexPath(forRow: index.row, inSection: index.section)
                self.tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
                self.tableView.endUpdates()
            }
        })
        
        confirmDeletion(cell, deleteAction: deleteAction)
    }
    
    
    func deleteWithoutConfirmation(cell: UITableViewCell) {
        if let index = self.tableView.indexPathForCell(cell) {
            
            self.reminderLists[index.section].reminders.removeAtIndex(index.row)
            
            // use the UITableView to animate the removal of this row
            self.tableView.beginUpdates()
            let indexPathForRow = NSIndexPath(forRow: index.row, inSection: index.section)
            self.tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
            self.tableView.endUpdates()
        }
    }
    
    
    func cellHasBeenSelected(cell: UITableViewCell) {
        if let index = self.tableView.indexPathForCell(cell) {
            indexOfSelectedCell = index
        }
    }
    
    
    // MARK: - Setup
    
    func setupReminders(reminderList: ReminderList) {
        self.listTitle = reminderList.title
        
        for i in 0..<reminderList.count() {
            if(reminderList.reminders[i].from != nil) {
                self.reminderLists[Index.from].reminders += [reminderList.reminders[i]]
            } else {
                self.reminderLists[Index.to].reminders += [reminderList.reminders[i]]
            }
        }
    }
    
    
    func setTitle() {
        if(listTitle != nil) {
            self.navigationItem.title = listTitle
        }
    }
    

}
