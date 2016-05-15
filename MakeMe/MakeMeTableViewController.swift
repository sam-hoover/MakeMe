//
//  MakeMeTableViewController.swift
//  MakeMe
//
//  Created by Vox on 3/12/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class MakeMeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting cell height
        self.tableView.rowHeight = UIScreen.mainScreen().bounds.height / 11
        
        // setting table's background color
        //self.tableView.backgroundColor = SettingsProfile.colors.tableBackground
        
        // setting navigation bar's colors
        self.navigationController!.navigationBar.barTintColor = SettingsProfile.colors.tableBackground
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.translucent = false
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        // setting tab bar's colors
        self.tabBarController!.tabBar.barTintColor = SettingsProfile.colors.tableBackground
        self.tabBarController!.tabBar.translucent = false
        self.tabBarController!.tabBar.tintColor = UIColor.whiteColor()
    
    }
    
    
    func confirmDeletion(cell: UITableViewCell, deleteAction: UIAlertAction) {
        
        let alertController: UIAlertController! = UIAlertController(title: "Delete", message: "Are you sure you would like to delete?", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {(alert :UIAlertAction!) in
            if let index = self.tableView.indexPathForCell(cell) {
                self.tableView.reloadRowsAtIndexPaths([index], withRowAnimation: .Fade)
            }
        })
        
        alertController.addAction(deleteAction)
        alertController.addAction(okAction)
        
        if self.presentedViewController == nil {
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    
    
}



