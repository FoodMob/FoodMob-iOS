//
//  User.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/5/16.
//  Copyright © 2016 Jonathan Jemson. All rights reserved.
//

import Foundation
import Locksmith

/**
 Represents a FoodMob user.
 */
public class User: CreateableSecureStorable, ReadableSecureStorable, DeleteableSecureStorable, GenericPasswordSecureStorable, Hashable {
    
    // MARK: - Properties
    /**
     The user's first name (or given name)
     */
    private(set) public var firstName: String
    
    /**
     The user's last name (or family name)
     */
    private(set) public var lastName: String
    
    /**
     The user's email address (used as their unique identifier).
     */
    private(set) public var emailAddress: String
    
    /**
     The user's authentication token for the current login.
     */
    private(set) internal var authToken: String
    
    /**
     Stores the user's likes, dislikes, and restrictions.
     */
    public var categories = [FoodCategory: Preference]()
    
    /**
     Get the user's full name, localized by region.
     */
    public var fullName: String {
        let nameFormatter = NSPersonNameComponentsFormatter()
        let nameComponents = NSPersonNameComponents()
        nameComponents.givenName = firstName
        nameComponents.familyName = lastName
        return nameFormatter.stringFromPersonNameComponents(nameComponents)
    }

    /// Conformance to Hashable protocol
    public var hashValue: Int {
        return emailAddress.hashValue
    }
    
    
    // MARK: - Initializers
    /**
     Initializes a new user, typically when they register.
     
     - Parameters:
        - firstName: User's first name/given name.
        - lastName: User's last name/family name.
        - emailAddress: User's email address
        - authToken: Authorization token for use with the API
        - saveToKeychain: Whether or not the credentials should be stored in the keychain.
     */
    public init(firstName: String, lastName: String, emailAddress: String, authToken: String, saveToKeychain: Bool = true) {
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.authToken = authToken
        if saveToKeychain {
            NSUserDefaults.standardUserDefaults().setObject(emailAddress, forKey: UserField.emailAddress)
            do {
                try Locksmith.saveData([UserField.emailAddress: emailAddress], forUserAccount: "FDMB-FoodMob")
            } catch {
                print(error)
            }

            do {
                try self.deleteFromSecureStore()
            } catch {
                print(error)
            }

            do {
                try self.createInSecureStore()
            } catch {
                print(error)
            }

        }

    }

    /**
     Convenience initializer, used for initializing friends.
     
     This object is NOT eligible for communicating with the server as an authenticated user.

     - parameter firstName:    User's given name/first name.
     - parameter lastName:     User's last name/family name
     - parameter emailAddress: User's email address
     */
    public convenience init(firstName: String, lastName: String, emailAddress: String) {
        self.init(firstName: firstName, lastName: lastName, emailAddress: emailAddress, authToken: "FRIEND\(emailAddress.md5())", saveToKeychain: false)
    }
    
    /**
     Initialize a user from their email address.
     
     This intializer requires that the user has attempted to log in at least once before,
     and that the `eraseUser` method has not been called.
     */
    public init?(emailAddress: String?) {
        
        // Blah blah compiler complained.
        self.firstName = ""
        self.lastName = ""
        self.emailAddress = emailAddress ?? Locksmith.loadDataForUserAccount("FDMB-FoodMob")?[UserField.emailAddress] as? String ?? ""
        self.authToken = ""
        if let storeData = self.readFromSecureStore(), data = storeData.data,
            firstName = data[UserField.firstName] as? String, lastName = data[UserField.lastName] as? String,
            authToken = data[UserField.authToken] as? String
        {
            self.firstName = firstName
            self.lastName = lastName
            self.authToken = authToken
            return
        }
        return nil
    }
    
    // MARK: - Instance Methods
    
    /**
     Removes the user from the device's keychain.
     */
    public func eraseUser() {
        do {
            try self.deleteFromSecureStore()
            try Locksmith.deleteDataForUserAccount("FDMB-FoodMob")
        } catch {
            print(error)
        }
    }
    
    /**
     Returns a user's preference for a food category.
     
     - parameter category: The category of interest
     
     - returns: Their preference level.
     */
    public func preferenceForCategory(category: FoodCategory) -> Preference {
        return categories[category] ?? Preference.None
    }

    public func categoriesForPreference(preference: Preference) -> [FoodCategory] {
        return categories.filter({ (tuple) -> Bool in
            return tuple.1 == preference
        }).map { $0.0 }
    }
    
    /**
     Returns a human-readable string of a user's food categories for a given preference.
     
     - parameter preference: Preference to stringify.
     
     - returns: Human-readable string of food categories.
     */
    @warn_unused_result
    func stringForPreference(preference: Preference) -> String {
        var str = ""
        for (cat, pref) in categories {
            if pref == preference {
                str += cat.displayName + ", "
            }
        }
        if (str.length < 2) {
            return str
        }
        return str.substringToIndex(str.endIndex.advancedBy(-2))
    }
    
    /**
     Sets preference for a category.
     
     - parameter preference: A preference to set on a category
     - parameter category:   The category that is being manipulated
     */
    public func setPreference(preference: Preference, forCategory category: FoodCategory) {
        if preference == .None {
            categories.removeValueForKey(category)
        } else {
            categories[category] = preference
        }
    }
    
    // MARK: - Locksmith: Keychain services.
    public let service = "FoodMob"
    public var account: String {
        return self.emailAddress
    }
    public var data: [String : AnyObject] {
        return [
            UserField.firstName: firstName,
            UserField.lastName: lastName,
            UserField.authToken: self.authToken
        ]
    }
}

/**
 Conformance to Equatable for the User class

 - parameter user1: User on LHS of expression
 - parameter user2: User on RHS of expression

 - returns: Whether the email addresses are the same for the user.
 */
public func ==(user1: User, user2: User) -> Bool {
    return user1.emailAddress == user2.emailAddress
}

// MARK: - JSON Serialization

/**
 User Fields used in JSON responses
 */
internal struct UserField {
    static let emailAddress = "email"
    static let friendEmail = "friend_email"
    static let password = "password"
    static let firstName = "first_name"
    static let lastName = "last_name"
    static let profile = "profile"
    static let foodProfile = "food_profile"
    static let authToken = "auth_token"
    static let friends = "friends"
    struct FoodProfile {
        static let restrictions = "allergies"
        static let likes = "likes"
        static let dislikes = "dislikes"
    }
}