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

    public func login(emailAddress: String, password: String, completion: ((User?)->())? = nil) {
        guard validateEmailAddress(emailAddress) && validatePassword(password) else {
            completion?(nil)
            return
        }
        if emailAddress.lowercaseString.containsString("foodmob.me") && password.lowercaseString.containsString("pass") {
            let user = User(firstName: "Jonathan", lastName: "Jemson", emailAddress: emailAddress, authToken: "0123456789abcdef")
            fetchCategoriesForUser(user)
            if let completion = completion {
                completion(user)
            }
        }
        if let completion = completion {
            completion(nil)
        }
        
    }

    public func register(firstName firstName: String, lastName: String, emailAddress: String, password: String, completion: ((Bool)->())? = nil) {
        guard validateName(firstName) &&
            validateName(lastName) &&
            validateEmailAddress(emailAddress) &&
            validatePassword(password)
            else {
                completion?(false)
                return
        }
        completion?(true)
    }
    
    public func fetchCategoriesForUser(user: User, completion: ((Bool)->())? = nil) {
        user.categories[FoodCategory.Indian] = Preference.Like
        user.categories[FoodCategory.Mexican] = Preference.Like
        user.categories[FoodCategory.SushiBars] = Preference.Dislike
        user.categories[FoodCategory.Seafood] = Preference.Restriction
        completion?(true)
    }
    
    public func updateCategoriesForUser(user: User) {
        // Not much to mock :P
        print("Updating categories for user")
    }
    
    public func logout(user: User, completion: ((Bool) -> ())? = nil) {
        user.eraseUser()
        completion?(true)
    }
}