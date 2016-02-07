//
//  MockDataSource.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/5/16.
//  Copyright © 2016 Jonathan Jemson. All rights reserved.
//

import Foundation

/**
 A mock data source, useful for testing and verification of in-application functionality.
*/
public struct MockDataSource : FoodMobDataSource {

    public func login(emailAddress: String, password: String) -> User? {
        if emailAddress.lowercaseString.containsString("foodmob.me") && password.lowercaseString.containsString("pass") {
            let user = User(firstName: "Jonathan", lastName: "Jemson", emailAddress: emailAddress, authToken: "0123456789abcdef")
            return user
        }
        return nil
        
    }

    public func register(firstName firstName: String, lastName: String, emailAddress: String, password: String) -> User? {
        guard validateName(firstName) &&
            validateName(lastName) &&
            validateEmailAddress(emailAddress) &&
            validatePassword(password)
            else { return nil }
        return User(firstName: firstName, lastName: lastName, emailAddress: emailAddress, authToken: "9876543210fedcba")
    }
}