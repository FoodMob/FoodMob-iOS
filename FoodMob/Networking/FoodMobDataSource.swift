//
//  FoodMobDataSource.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/5/16.
//  Copyright © 2016 Jonathan Jemson. All rights reserved.
//

import Foundation

public protocol FoodMobDataSource {
    
    /**
     Login endpoint.
     
     - Parameters:
        - emailAddress: The email address for the user
        - password: The password for the user.
     
     - returns: A User object for the currently logged in user. `nil` is returned if the login failed.
     */
    func login(emailAddress: String, password: String) -> User?
    
    /**
     Registration endpoint.
     
     - Parameters:
        - firstName: User's first name
        - lastName: User's last name
        - emailAddress: User's email address
        - password: User's password.
     
     - returns: The user object for the new user that is created.
     */
    func register(firstName: String, lastName: String, emailAddress: String, password: String) -> User?
}

let currentDataProvider: FoodMobDataSource = MockDataSource()