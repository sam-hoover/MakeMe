//
//  SharedReminderListTableViewController.swift
//  MakeMe
//
//  Created by Vox on 3/4/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class SharedReminderListTableViewController: UITableViewController {

    var sharedReminderList = [ReminderList]()
    
    var friend1 = ReminderList(title: "Lois Lane")
    var friend2 = ReminderList(title: "Mary-Jane Watson")
    var friend3 = ReminderList(title: "Selina Kyle")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // adding lists to be displayed
        sharedReminderList += [friend1, friend2, friend3]
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
        return sharedReminderList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // not sure why i have to downcast here ("as!") and cannot just use "as"
        let cellReuseIdentifier = "SharedReminderListCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! SharedReminderListTableViewCell
        
        // Configure the cell...
        let reminderList = sharedReminderList[indexPath.row]
        
        cell.reminderList = reminderList
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            sharedReminderList.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

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
        
        if(segue.identifier == "ShowSharedList") {
            if let ReminderListTableViewController = segue.destinationViewController as? ReminderTableViewController {
                
                // Get the cell that generated this segue.
                if let selectedCell = sender as? SharedReminderListTableViewCell {
                    // the location of the selected list from the table view
                    let indexPath = tableView.indexPathForCell(selectedCell)!
                    
                    // gets the selected reminder list from the array
                    let selectedReminderList = sharedReminderList[indexPath.row]
                    
                    // sets the destinationVC's reminder list to the list that was selected
                    ReminderListTableViewController.reminderList = selectedReminderList
                    
                    ReminderListTableViewController.sendingViewController = "Shared"
                }
            }
        }
    }
    
    
    @IBAction func unwindSharedReminderList(segue: UIStoryboardSegue) {
        
        if let sourceViewController = segue.sourceViewController as? ReminderTableViewController {
            
            let list = sourceViewController.reminderList
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // update an existing list
                
                sharedReminderList[selectedIndexPath.row] = list
                
                tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                
            } else {
                // add a new list
                
                let newIndexPath = NSIndexPath(forRow: sharedReminderList.count, inSection: 0)
                
                sharedReminderList.append(list)
                
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            
            // Save the list to disc here
            
        }
    }
    
    
    
} // class
