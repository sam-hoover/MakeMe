//
//  MakeMeTableViewController.swift
//  MakeMe
//
//  Created by Vox on 3/12/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class MakeMeTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {

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
    
    
    
    func createQuickAlarmPopover() {
        
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("AddQuickAlarm")
        
        vc.modalPresentationStyle = UIModalPresentationStyle.Popover
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        vc.preferredContentSize = CGSizeMake(screenSize.width, screenSize.width)
        
        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
        
        popover.delegate = self
        popover.sourceView = self.view
        popover.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
        popover.sourceRect = CGRectMake(0, CGRectGetMidY(self.view.bounds), 0, 0)
        
        self.presentViewController(vc, animated: true, completion:nil)
    }
    
    
    // MARK: - UIPopoverPresentationControllerDelegate
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}



