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
let currentDataProvider: FoodMobDataSource = FoodMobService()


/**
 Encapsulates the methods that a FoodMob data provider must include.
*/
public protocol FoodMobDataSource {
    
    /**
     Logs in as an existing user.
     
     - Parameters:
        - emailAddress: The email address for the user
        - password: The password for the user.
        - completion: When request is done, this block is called.
     
     - returns: A User object for the currently logged in user. `nil` is returned if the login failed.
     */
    func login(emailAddress: String, password: String, completion: ((User?)->())?)
    
    /**
     Logs the user out.
     
     - Parameters:
        - user: The user to log out.
     */
    func logout(user: User, completion: ((Bool) -> ())?)
    
    /**
     Creates a new user on the server.
     
     - Parameters:
        - firstName: User's first name
        - lastName: User's last name
        - emailAddress: User's email address
        - password: User's password.
        - completion: When request is done, this block is called
     
     - returns: The user object for the new user that is created.
     */
    func register(firstName firstName: String, lastName: String,
         emailAddress: String, password: String, completion: ((Bool) -> ())?)
    
    /**
     Retrieve the list of categories for the user and store it in the user object.
     
     - Parameters:
        - user: The current user.
        - completion: Completion block to be called with a success code.
     */
    func fetchCategoriesForUser(user: User, completion: ((Bool)->())?)
    
    /**
     Push the user's categories up to the server.
     
     - Parameters:
         - user: The current user.
     */
    func updateCategoriesForUser(user: User)
    
    /**
     Perform a search given a restaruant search object.
     
     - Parameter search: A restaurant search object.
     - Parameter completion: The completion handler for when the server responds
     */
    func fetchRestaurantsForSearch(search: RestaurantSearch, withUser user: User, completion: (([Restaurant]) -> ())?)
    
    func fetchCategoryListing(completion: (([String: FoodCategory]) -> ())?)

    func fetchFriendsListing(forUser user: User, completion: (([User])->())?)

    func addFriendWithEmail(emailAddress: String, forUser user: User, completion: ((Bool, String)->())?)
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
    
    public func fetchCategoryListing(completion: (([String: FoodCategory]) -> ())?) {
        var categories = [FoodCategory]()
        categories.append(FoodCategory(displayName: "Pizza", yelpIdentifier: "pizza"))
        categories.append(FoodCategory(displayName: "Mexican", yelpIdentifier: "mexican"))
        categories.append(FoodCategory(displayName: "American (Traditional)", yelpIdentifier: "tradamerican"))
        categories.append(FoodCategory(displayName: "Burgers", yelpIdentifier: "burgers"))
        categories.append(FoodCategory(displayName: "Bars", yelpIdentifier: "bars"))
        categories.append(FoodCategory(displayName: "Chicken Wings", yelpIdentifier: "chicken_wings"))
        categories.append(FoodCategory(displayName: "Chinese", yelpIdentifier: "chinese"))
        categories.append(FoodCategory(displayName: "American (New)", yelpIdentifier: "newamerican"))
        categories.append(FoodCategory(displayName: "Breakfast and Brunch", yelpIdentifier: "breakfast_brunch"))
        categories.append(FoodCategory(displayName: "Italian", yelpIdentifier: "italian"))
        categories.append(FoodCategory(displayName: "Seafood", yelpIdentifier: "seafood"))
        categories.append(FoodCategory(displayName: "Barbeque", yelpIdentifier: "barbeque"))
        categories.append(FoodCategory(displayName: "Japanese", yelpIdentifier: "japanese"))
        categories.append(FoodCategory(displayName: "Sushi Bars", yelpIdentifier: "sushibars"))
        categories.append(FoodCategory(displayName: "Diners", yelpIdentifier: "diners"))
        categories.append(FoodCategory(displayName: "Southern", yelpIdentifier: "southern"))
        categories.append(FoodCategory(displayName: "Sports Bars", yelpIdentifier: "sportsbars"))
        categories.append(FoodCategory(displayName: "Tex-Mex", yelpIdentifier: "tex-mex"))
        categories.append(FoodCategory(displayName: "Steakhouses", yelpIdentifier: "steakhouses"))
        categories.append(FoodCategory(displayName: "Thai", yelpIdentifier: "thai"))
        categories.append(FoodCategory(displayName: "Korean",  yelpIdentifier: "korean"))
        categories.append(FoodCategory(displayName: "Asian Fusion",  yelpIdentifier: "asianfusion"))
        categories.append(FoodCategory(displayName: "Indian",  yelpIdentifier: "indian"))
        categories.append(FoodCategory(displayName: "Bakeries",  yelpIdentifier: "bakeries"))
        categories.append(FoodCategory(displayName: "Coffee & Tea",  yelpIdentifier: "coffee"))
        categories.append(FoodCategory(displayName: "Desserts",  yelpIdentifier: "desserts"))
        
        let hashMap = categories.reduce([String : FoodCategory]()) { (dict: [String: FoodCategory], cat: FoodCategory) -> [String : FoodCategory] in
            var dict = dict
            let catName = cat.yelpIdentifier
            dict[catName] = cat
            return dict
        }
        
        completion?(hashMap)
    }
}