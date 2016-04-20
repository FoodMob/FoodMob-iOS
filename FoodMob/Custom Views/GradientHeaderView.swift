//
//  GradientHeaderView.swift
//  FoodMob
//
//  Created by Jong Han Park on 4/20/16.
//  From Zaappdesigntemplates.com
//

import Foundation
import UIKit

@IBDesignable class GradientHeaderView: UIView {
    
    var gradientLayer: CAGradientLayer!
    
    @IBInspectable var topColor: UIColor = UIColor.blackColor() {
        didSet {
            updateUI()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = UIColor.clearColor() {
        didSet {
            updateUI()
        }
    }
    
    @IBInspectable var bottomYPoint: CGFloat = 0.6 {
        didSet {
            updateUI()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradientLayer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
    }
    
    func setupGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [topColor.CGColor, bottomColor.CGColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: bottomYPoint)
        layer.addSublayer(gradientLayer)
    }
    
    func updateUI() {
        setNeedsDisplay()
    }
    
    func adjustBackground(isClear: Bool) {
        if isClear == true {
            gradientLayer.hidden = false
            backgroundColor = UIColor.clearColor()
        } else {
            gradientLayer.hidden = true
            backgroundColor = UIColor(red: CGFloat(54/255.0), green: CGFloat(54/255.0), blue: CGFloat(54/255.0), alpha: 1.0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = frame
    }
    
    override func prepareForInterfaceBuilder() {
        setupGradientLayer()
    }
}