//
//  SharedReminderListTableViewController.swift
//  MakeMe
//
//  Created by Vox on 3/4/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

extension Array {
    func getInsertionIndexForNewElement(elem: Element, isOrderedBefore: (Element, Element) -> Bool) -> Int {
        var lo = 0
        var hi = self.count - 1
        while lo <= hi {
            let mid = (lo + hi)/2
            if isOrderedBefore(self[mid], elem) {
                lo = mid + 1
            } else if isOrderedBefore(elem, self[mid]) {
                hi = mid - 1
            } else {
                return mid // found at position mid
            }
        }
        return lo // not found, would be inserted at position lo
    }
}


class SharedCollectionTableViewController: CollectionTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        // for testing
        setupTestLists()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // not sure why i have to downcast here ("as!") and cannot just use "as"
        let cellReuseIdentifier = "SharedReminderListCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! SharedCollectionTableViewCell
        
        // Configure the cell...
        let reminderList = reminderListCollection[indexPath.row]
        
        cell.reminderList = reminderList
        cell.selectionStyle = .None
        cell.delegate = self
        
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "ShowSharedList") {
            if let ReminderListTableViewController = segue.destinationViewController as? SharedReminderTableViewController {
                
                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem
                
                // Get the cell that generated this segue.
                if let selectedCell = sender as? SharedCollectionTableViewCell {
                    // the location of the selected list from the table view
                    let indexPath = tableView.indexPathForCell(selectedCell)!
                    
                    // gets the selected reminder list from the array
                    let selectedReminderList = reminderListCollection[indexPath.row]
                    
                    // sets the destinationVC's reminder list to the list that was selected
                    ReminderListTableViewController.setupReminders(selectedReminderList)
                }
            }
        }
    }
    
    
    @IBAction func unwindSharedReminderList(segue: UIStoryboardSegue) {

        if let sourceViewController = segue.sourceViewController as? SharedReminderTableViewController {
            
            let list = ReminderList()
            
            list.title = sourceViewController.listTitle!
            
            list.add(sourceViewController.reminderLists[0].reminders + sourceViewController.reminderLists[1].reminders)
            
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
    
    
    // MARK: - Helper functions
    func addReminderListToCollection(reminderList: ReminderList) {
        
        // get the in order index of where the new list should be added to the shared reminders lists
        let index = reminderListCollection.getInsertionIndexForNewElement(reminderList) { (list1, list2) -> Bool in
            if(list1.title < list2.title) {
                return(true)
            }
            return(false)
        }

        
        let newIndexPath = NSIndexPath(forRow: index, inSection: 0)
        
        self.reminderListCollection.insert(reminderList, atIndex: index)
        
        tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
    }
    
    
    
    // MARK: - Testing
    var friend1 = ReminderList(title: "Lois Lane")
    var friend2 = ReminderList(title: "Mary-Jane Watson")
    var friend3 = ReminderList(title: "Selina Kyle")
    
    func setupTestLists() {
        
        // adding lists to be displayed
        friend1.reminders += [Reminder(txt: "do something"), Reminder(txt: "read something")];
        friend2.reminders += [Reminder(txt: "do something"), Reminder(txt: "read something")];
        friend3.reminders += [Reminder(txt: "do something"), Reminder(txt: "read something")];
        friend1.reminders[0].from = "Lois Lane"
        friend2.reminders[0].from = "Mary-Jane Watson"
        friend3.reminders[0].from = "Selina Kyle"
        reminderListCollection += [friend1, friend2, friend3]
        
    }
    
    
} // class
