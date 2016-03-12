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
        
        self.tableView.rowHeight = UIScreen.mainScreen().bounds.height / 11
    }
    
}
