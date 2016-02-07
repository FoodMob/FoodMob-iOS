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

extension UITextField {
    /**
     - returns: The text in the field, and empty string if it's nil (somehow)
     */
    var safeText: String {
        return self.text ?? ""
    }
}

extension String {
    
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
            return regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
}