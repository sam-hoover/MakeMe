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
}



