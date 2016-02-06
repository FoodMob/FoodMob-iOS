//
//  MockDataSource.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/5/16.
//  Copyright © 2016 Jonathan Jemson. All rights reserved.
//

import Foundation

public struct MockDataSource : FoodMobDataSource {
    
    @warn_unused_result
    public func login(emailAddress: String, password: String) -> User? {
        if emailAddress.lowercaseString.containsString("foodmob.me") && password.lowercaseString.containsString("pass") {
            let user = User(firstName: "Jonathan", lastName: "Jemson", emailAddress: emailAddress, authToken: "0123456789abcdef")
            return user
        }
        return nil
        
    }
    
    @warn_unused_result
    public func register(firstName: String, lastName: String, emailAddress: String, password: String) -> User? {
        return nil
    }
}