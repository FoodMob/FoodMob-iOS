//
//  RoundedImageView.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/15/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import UIKit

/**
 A circle image view.  Required to be square.
 */
@IBDesignable
class RoundedImageView: UIImageView {
    
    override func setNeedsDisplay() {
        self.layer.cornerRadius = self.frame.size.width / 2;
        self.layer.masksToBounds = true
    }

}
