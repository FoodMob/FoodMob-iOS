//
//  FoodMobExtensions.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/6/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import UIKit

extension UITextField {
    /**
     - returns: The text in the field, and empty string if it's nil (somehow)
     */
    var safeText: String {
        return self.text ?? ""
    }
}