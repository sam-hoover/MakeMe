//
//  AddListTypeSelectionViewController.swift
//  MakeMe
//
//  Created by Vox on 3/2/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class AddListTypeSelectionViewController: UIViewController {

    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    
    @IBOutlet weak var addPersonalListButton: UIButton!
    @IBOutlet weak var addSharedListButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
