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


    // MARK: - MakeMeTableViewCellDelegate
    
    func alertBeingAddedtoCell(cell: UITableViewCell) { /* nothing is need here */ }
    
    func cellDidBeginEditing() {
        self.navigationItem.rightBarButtonItem?.enabled = false
    }
    
    func cellDidEndEditing() {
        self.navigationItem.rightBarButtonItem?.enabled = true
    }
    
    func cellHasBeenCompleted(cell: UITableViewCell) { /* nothing is need here */ }
    
    
    func deleteWithConfirmation(cell: UITableViewCell) {
        
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertActionStyle.Destructive, handler: {(alert :UIAlertAction!) in
            if let index = self.tableView.indexPathForCell(cell) {
                
                self.reminderListCollection.removeAtIndex(index.row)
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
            
            self.reminderListCollection.removeAtIndex(index.row)
            // use the UITableView to animate the removal of this row
            self.tableView.beginUpdates()
            let indexPathForRow = NSIndexPath(forRow: index.row, inSection: 0)
            self.tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
            self.tableView.endUpdates()
            
        }
        
        // must re-enable the add button
        self.navigationItem.rightBarButtonItem?.enabled = true
    }
    
    
    func cellHasBeenSelected(cell: UITableViewCell) { /* nothing is needed here */ }
    

}
