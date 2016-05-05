//
//  CollectionTableViewController.swift
//  MakeMe
//
//  Created by Vox on 3/12/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class CollectionTableViewController: MakeMeTableViewController, MakeMeTableViewCellDelegate {

    var reminderListCollection = [ReminderList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return reminderListCollection.count
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    
    
    func confirmDeletion(cell: UITableViewCell) {
        
        let alertController: UIAlertController! = UIAlertController(title: "Delete", message: "Are you sure you would like to delete?", preferredStyle: UIAlertControllerStyle.Alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive, handler: {(alert :UIAlertAction!) in
            //self.deleteCell(cell)
            if let index = self.tableView.indexPathForCell(cell) {
                
                self.reminderListCollection.removeAtIndex(index.row)
                
                // use the UITableView to animate the removal of this row
                self.tableView.beginUpdates()
                let indexPathForRow = NSIndexPath(forRow: index.row, inSection: 0)
                self.tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
                self.tableView.endUpdates()
            }
            self.presentViewController(alertController, animated: true, completion: nil)
        })
        alertController.addAction(deleteAction)
        
        let okAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {(alert :UIAlertAction!) in
            
            if let index = self.tableView.indexPathForCell(cell) {
                self.tableView.reloadRowsAtIndexPaths([index], withRowAnimation: .Fade)
            }
            
            //self.returnCellToOriginPosition(cell)
            //alertController.removeFromParentViewController()
            alertController.dismissViewControllerAnimated(true, completion: nil)
            
            
        
        })
        alertController.addAction(okAction)
        
        
        if self.presentedViewController == nil {
            //self.presentViewController(alertController, animated: true, completion: nil)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.presentViewController(alertController, animated: true, completion: nil)
            })
        }
        
    }
    
    func deleteCell(cell: UITableViewCell) {
        if let index = self.tableView.indexPathForCell(cell) {
            
            self.reminderListCollection.removeAtIndex(index.row)
            
            // use the UITableView to animate the removal of this row
            self.tableView.beginUpdates()
            let indexPathForRow = NSIndexPath(forRow: index.row, inSection: 0)
            self.tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
            self.tableView.endUpdates()
        }
    }
    
    func returnCellToOriginPosition(cell: UITableViewCell) {
        if let tvc = cell as? MakeMeTableViewCell {
            tvc.hasBeenDeleted = false
        }
        
        let origin = CGRect(x: 0, y: cell.frame.origin.y, width: cell.bounds.size.width, height: cell.bounds.size.height)
        
        UIView.animateWithDuration(0.2, animations: {cell.frame = origin})
        
        
    }
    
    
    // MARK: - MakeMeTableViewCellDelegate
    
    func cellHasBeenCompleted(cell: UITableViewCell) {
        /*
         if let rtc = cell as? ReminderTableViewCell {
            if !rtc.isCompleted {
                rtc.textLabel?.textColor = UIColor.grayColor()
            } else {
                rtc.textLabel?.textColor = SettingsProfile.colors.tableBackground
            }
        }
        */
    }
    
    
    func cellHasBeenDeleted(cell: UITableViewCell) {
        //confirmDeletion(cell)
        deleteCell(cell)
    }
    
    func cellHasBeenSelected(cell: UITableViewCell) { /* nothing is needed here */ }
    

}
