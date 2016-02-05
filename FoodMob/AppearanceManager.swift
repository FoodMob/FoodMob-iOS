//
//  AppearanceManager.swift
//  FoodMob-mockup
//
//  Created by Jonathan Jemson on 12/5/15.
//  Copyright © 2015 Jonathan Jemson. All rights reserved.
//

import UIKit

class AppearanceManager: NSObject {
    static let applicationBarTintColor: UIColor? = nil
    static let applicationTintColor: UIColor = UIColor(red:0.969, green:0.528, blue:0.268, alpha:1);
    
    static func configureAppearance() {
//        UIView.appearance().tintColor = AppearanceManager.applicationTintColor
        UINavigationBar.appearance().tintColor = AppearanceManager.applicationTintColor
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: AppearanceManager.applicationTintColor]
        UINavigationBar.appearance().barTintColor = AppearanceManager.applicationBarTintColor
        UITabBar.appearance().barTintColor = AppearanceManager.applicationBarTintColor
        UITabBar.appearance().tintColor = AppearanceManager.applicationTintColor
    }

}
