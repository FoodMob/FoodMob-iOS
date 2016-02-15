//
//  GradientView.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/6/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import UIKit

/**
 A gradient view controller, as specified from Appearance Manager.
*/
@IBDesignable
class GradientView : UIView {
    override class func layerClass() ->  AnyClass {
        return CAGradientLayer.self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initGradientLayer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initGradientLayer()
    }
    
    func initGradientLayer() {
        let colors = AppearanceManager.gradientColors.map { (color) -> CGColor in
            return color.CGColor
        }
        let locations: [Float] = AppearanceManager.gradientStops
        let gradientLayer = self.layer as! CAGradientLayer
        gradientLayer.colors = colors
        gradientLayer.locations = locations
    }
    
}
