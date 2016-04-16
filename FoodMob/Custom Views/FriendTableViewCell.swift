//
//  FriendTableViewCell.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 4/16/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: RoundedImageView!
    @IBOutlet weak var userNameField: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCellForUser(user: User) {
        self.userImageView.setImageForUser(user)
        self.userNameField.text = user.fullName
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
