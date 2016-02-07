//
//  FoodMobDataSource.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/5/16.
//  Copyright © 2016 Jonathan Jemson. All rights reserved.
//

import Foundation

/**
The current data source provider for the application.

For testing purposes, use a mock data source.

For testing client-server interaction and release, use the actual service provider.
*/
let currentDataProvider: FoodMobDataSource = MockDataSource()


/**
 Encapsulates the methods that a FoodMob data provider must include.
*/
public protocol FoodMobDataSource {
    
    /**
     Logs in as an existing user.
     
     - Parameters:
        - emailAddress: The email address for the user
        - password: The password for the user.
     
     - returns: A User object for the currently logged in user. `nil` is returned if the login failed.
     */
    func login(emailAddress: String, password: String) -> User?
    
    /**
     Creates a new user on the server.
     
     - Parameters:
        - firstName: User's first name
        - lastName: User's last name
        - emailAddress: User's email address
        - password: User's password.
     
     - returns: The user object for the new user that is created.
     */
    func register(firstName firstName: String, lastName: String, emailAddress: String, password: String) -> User?
}

public extension FoodMobDataSource {
    /**
     Validates a user's password.
     
     Passwords must be greater than or equal to 8 characters in length.
     
     A user password must contain at least three of the following:
     - Capital letters
     - Lowercase letters
     - Numbers
     - Symbols
     
     - parameter password: The password that is being validated.
     - returns: Whether or not the password is valid.
    */
    public func validatePassword(password: String) -> Bool {
        guard password.length >= 8 else { return false }
        let lowercaseSet = NSCharacterSet.lowercaseLetterCharacterSet()
        let uppercaseSet = NSCharacterSet.uppercaseLetterCharacterSet()
        let numberSet = NSCharacterSet.decimalDigitCharacterSet()
        let symbolSet = NSCharacterSet(charactersInString: "!@#$%^&*(){}|\\/.,`~[];'\"<>?")
        
        let nonLowercaseStrings = password.rangeOfCharacterFromSet(lowercaseSet)
        let nonUppercaseStrings = password.rangeOfCharacterFromSet(uppercaseSet)
        let nonNumberStrings = password.rangeOfCharacterFromSet(numberSet)
        let nonSymbolStrings = password.rangeOfCharacterFromSet(symbolSet)
        
        var classesCovered = 0
        if nonLowercaseStrings != nil { classesCovered += 1 }
        if nonUppercaseStrings != nil { classesCovered += 1 }
        if nonNumberStrings != nil { classesCovered += 1 }
        if nonSymbolStrings != nil { classesCovered += 1 }
        return classesCovered >= 3
    }
    
    /**
     Validates a name.  Names simply cannot be blank.
     
     - parameter name: A user's name.
     - returns: Whether or not a user's name is blank.
    */
    public func validateName(name: String) -> Bool {
        return !name.isBlank
    }
    /**
     Validates an email address.
     
     - parameter emailAddress: A candidate email address
     - returns: Whether the string really was an email address.
    */
    public func validateEmailAddress(emailAddress: String) -> Bool {
        return emailAddress.isEmail
    }
}