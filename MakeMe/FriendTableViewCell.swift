//
//  FriendTableViewCell.swift
//  MakeMe
//
//  Created by Vox on 3/8/16.
//  Copyright © 2016 Yashley. All rights reserved.
//

import UIKit

class FriendTableViewCell: MakeMeTableViewCell {

    @IBOutlet weak var friendLabel: UILabel!
    
    var friend: Friend? {
        didSet {
            update()
        }
    }
    
    func update() {
        friendLabel?.text = nil
        
        if let friend = self.friend {
            friendLabel?.text = friend.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}
