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
    
    //var addPersonalListButton: UIButton!
    //var addSharedListButton: UIButton!
    
    private struct Button {
        static let personalText = "Add Personal List"
        static let sharedText = "Add Shared List"
        static let dimensions = CGRectMake(0, 0, 200, 75)
        static let borderWidth: CGFloat = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupButton(button: UIButton, text: String, position: CGPoint) {
        
        //let button = UIButton()
        button.frame = Button.dimensions
        button.center = position
        button.setTitle(text, forState: .Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.layer.borderColor = UIColor.blackColor().CGColor
        button.layer.borderWidth = Button.borderWidth
        
       // self.view.addSubview(button)
    }
    
    
    func setupDisplay() {
        
        //let padding = screenHeight / CGFloat(10)
        
        //self.view.bounds = CGRect(x: padding / 2, y: padding, width: screenWidth - padding / 2, height: screenHeight - padding)
        self.view.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.4)
        
        let buttonX = self.view.bounds.width / 2
        let personalY = self.view.bounds.height / 3
        let sharedY = self.view.bounds.height - personalY
        
        setupButton(addPersonalListButton, text: Button.personalText, position: CGPoint(x: buttonX, y: personalY))
         setupButton(addSharedListButton, text: Button.sharedText, position: CGPoint(x: buttonX, y: sharedY))
        
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
