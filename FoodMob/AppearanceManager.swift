//
//  AppearanceManager.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 12/5/15.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import UIKit

// All random-seeming values were generated from Skala Color.

struct AppearanceManager {
    static let applicationBarTintColor: UIColor? = nil

    static let applicationTintColor: UIColor = UIColor(red:0.969, green:0.528, blue:0.268, alpha:1)
    
    /**
     Used in the `GradientView` class.
     */
    static let gradientColors = [UIColor(hue:0.079, saturation:0.996, brightness:0.953, alpha:1),
        UIColor(hue:0.089, saturation:0.819, brightness:0.975, alpha:1)
    ]
    
    static let gradientStops: [Float] = [0.0, 0.78]
    /**
     Used in the `SimpleTextField` class.
     */
    static let lightPlaceholderColor = UIColor(red:0.984, green:0.856, blue:0.746, alpha:1)
    
    /**
     Configures the application's appearance.  
     It is recommended that you call this from the AppDelegate.
     */
    static func configureAppearance() {
        UINavigationBar.appearance().tintColor = AppearanceManager.applicationTintColor
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: AppearanceManager.applicationTintColor]
        UINavigationBar.appearance().barTintColor = AppearanceManager.applicationBarTintColor
        UITabBar.appearance().barTintColor = AppearanceManager.applicationBarTintColor
        UITabBar.appearance().tintColor = AppearanceManager.applicationTintColor
    }

}
