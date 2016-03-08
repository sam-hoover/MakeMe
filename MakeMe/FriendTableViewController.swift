//
//  FriendTableViewController.swift
//  MakeMe
//
//  Created by Vox on 3/8/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class FriendTableViewController: UITableViewController, MakeMeTableViewCellDelegate {

    var friends = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        loadFriends()
        
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
        return friends.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // not sure why i have to downcast here ("as!") and cannot just use "as"
        let cellReuseIdentifier = "FriendCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! FriendTableViewCell
        
        // Configure the cell...
        let friend = friends[indexPath.row]
        
        cell.friend = friend
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
    
    
    // MARK: - MakeMeTableViewCellDelegate
    
    func cellHasBeenDeleted(cell: UITableViewCell) {
        
        if let index = self.tableView.indexPathForCell(cell) {
            
            friends.removeAtIndex(index.row)
            
            // use the UITableView to animate the removal of this row
            tableView.beginUpdates()
            let indexPathForRow = NSIndexPath(forRow: index.row, inSection: 0)
            tableView.deleteRowsAtIndexPaths([indexPathForRow], withRowAnimation: .Fade)
            tableView.endUpdates()
        }
    }
    
    
    // MARK: - Testing
    
    func loadFriends() {
        let f1 = Friend(name: "Jordan Soltman", phone: "1111111111")
        let f2 = Friend(name: "Casey Earl", phone: "2222222222")
        let f3 = Friend(name: "Norell Tagle", phone: "3333333333")
        let f4 = Friend(name: "Dan Wager", phone: "4444444444")
        let f5 = Friend(name: "Kasey Parker", phone: "5555555555")
        let f6 = Friend(name: "Becky Bach", phone: "6666666666")
        let f7 = Friend(name: "Jason Pace", phone: "7777777777")
        
        friends += [f1, f2, f3, f4, f5, f6, f7]
        
    }

}
