//
//  FoodMobExtensions.swift
//  FoodMob
//  
//  Provides useful extensions to the classes in
//  the iOS SDK and the Swift Standard Library.
//
//  Created by Jonathan Jemson on 2/6/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import UIKit
import AlamofireImage
import CryptoSwift

extension UIImageView {
    func setImageForUser(user: User) {
        let md5 = user.emailAddress.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).lowercaseString.md5()
        let size = self.frame.size.width * UIScreen.mainScreen().scale
        self.af_setImageWithURL(NSURL(string: "https://www.gravatar.com/avatar/\(md5).jpg?d=identicon&s=\(size)")!, placeholderImage: UIImage(named: "NoFriendImage")!, imageTransition: .CrossDissolve(0.2))
    }
}

extension UIViewController {
    /**
     Present a UIAlertController with the specified title, optional message, and a dismiss button.
     This method is intended to work similar to a JavaScript alert.
     
     - parameters:
        - title: The title of the alert.
        - message: An optional message to display with the alert
        - dismissButtonTitle: The text to display on the dismiss button.  Defaults to "OK"
     
     */
    func alert(title: String, message: String?, dismissButtonTitle: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: dismissButtonTitle, style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

extension UINavigationController {
    func presentTransparentNavigationBar() {
        self.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationBar.translucent = true
        self.navigationBar.shadowImage = UIImage()
        self.setNavigationBarHidden(false, animated: true)
    }
    
    func hideTransparentNavigationBar() {
        self.setNavigationBarHidden(true, animated:false)
        self.navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImageForBarMetrics(UIBarMetrics.Default), forBarMetrics:UIBarMetrics.Default)
        self.navigationBar.translucent = UINavigationBar.appearance().translucent
        self.navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
    }
}

extension UITextField {
    /**
     - returns: The text in the field, and empty string if it's nil (somehow)
     */
    var safeText: String {
        return self.text ?? ""
    }
}

extension String {
    
    /**
     Simply characters.count
     
     - returns: the number of characters in the string (including grapheme clusters).
     */
    var length: Int {
        return self.characters.count
    }
    
    /**
     - returns: Whether the String is blank or not
     */
    var isBlank: Bool {
        get {
            let trimmed = stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
            return trimmed.isEmpty
        }
    }
    
    /**
     - returns: Whether the String is a valid email address or not.
     */
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .CaseInsensitive)
            return regex.firstMatchInString(self, options: [], range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
}
