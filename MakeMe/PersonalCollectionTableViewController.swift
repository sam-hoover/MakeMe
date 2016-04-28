//
//  ReminderListTableViewController.swift
//  MakeMe
//
//  Created by Vox on 3/1/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class PersonalCollectionTableViewController: CollectionTableViewController {
    
    private struct Storyboard {
        static let CellReuseIdentifier = "ReminderListTableCell"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adding lists to be displayed
        setupTestLists()
    }


    // MARK: - Table view data source

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // not sure why i have to downcast here ("as!") and cannot just use "as"
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! PersonalCollectionTableViewCell

        // Configure the cell...
        let reminderList = reminderListCollection[indexPath.row]
        
        cell.reminderList = reminderList
        cell.selectionStyle = .None
        cell.delegate = self
                
        return cell
    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "ShowPersonalList") {
            if let ReminderListTableViewController = segue.destinationViewController as? PersonalReminderTableViewController {
                
                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem
                
                // Get the cell that generated this segue.
                if let selectedCell = sender as? PersonalCollectionTableViewCell {
                    // the location of the selected list from the table view
                    let indexPath = tableView.indexPathForCell(selectedCell)!
                    
                    // gets the selected reminder list from the array
                    let selectedReminderList = reminderListCollection[indexPath.row]
                    
                    // sets the destinationVC's reminder list to the list that was selected
                    ReminderListTableViewController.reminderList = selectedReminderList
                }
            }
        }
    }
    
    
    @IBAction func unwindReminderList(segue: UIStoryboardSegue) {
        
        if let sourceViewController = segue.sourceViewController as? PersonalReminderTableViewController {
            
            let list = sourceViewController.reminderList
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // update an existing list
                
                reminderListCollection[selectedIndexPath.row] = list
                
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                
            } else {
                // add a new list
                
                let newIndexPath = NSIndexPath(forRow: reminderListCollection.count, inSection: 0)
                
                reminderListCollection.append(list)
                
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            
            // Save the list to disc here
            
        }
    }
    

    // MARK: - Actions
    
    @IBAction func addNewReminderList(sender: UIBarButtonItem) {
        let reminders = ReminderList(title: "")
        
        reminderListCollection += [reminders]
        
        self.tableView.reloadData()
        
        let path = NSIndexPath(forRow: reminderListCollection.count - 1, inSection: 0)
        if let cell = self.tableView.cellForRowAtIndexPath(path) as? PersonalCollectionTableViewCell {
            cell.textFieldDidBeginEditing(cell.titleTextBox)
        }
    }
    
    
    // MARK: - Testing
    
    var testHomeList = ReminderList(title: "Home Reminders")
    var testSchoolList = ReminderList(title: "School Reminders")
    
    func setupTestLists() {
        let home1 = Reminder(txt: "go to store")
        let home2 = Reminder(txt: "do laundry")
        let school1 = Reminder(txt: "study for math test")
        let school2 = Reminder(txt: "read Ender's Game")
        
        testHomeList.reminders += [home1, home2]
        testSchoolList.reminders += [school1, school2]
        reminderListCollection += [testHomeList, testSchoolList]
    }
    
    

} // class
