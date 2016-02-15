//
//  SimpleTextField.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/6/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import UIKit

@IBDesignable
class SimpleTextField: UITextField {
    override func drawRect(rect: CGRect) {
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName: AppearanceManager.lightPlaceholderColor])
        let layer = CALayer()
        let width = CGFloat(1.0)
        layer.frame = CGRect(x: 0.0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        layer.borderColor = UIColor.whiteColor().CGColor
        layer.borderWidth = width
        self.layer.addSublayer(layer)
        self.layer.masksToBounds = true
        self.textColor = UIColor.whiteColor()
    }
}
