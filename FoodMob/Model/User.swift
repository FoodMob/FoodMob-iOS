//
//  User.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/5/16.
//  Copyright © 2016 Jonathan Jemson. All rights reserved.
//

import Foundation
import Locksmith

public struct User: CreateableSecureStorable, ReadableSecureStorable, DeleteableSecureStorable, GenericPasswordSecureStorable {
    private(set) public var firstName: String
    private(set) public var lastName: String
    private(set) public var emailAddress: String
    private(set) internal var authToken: String
    
    public init(firstName: String, lastName: String, emailAddress: String, authToken: String = "", saveToKeychain: Bool = true) {
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
        }

        do {
            try self.deleteFromSecureStore()
        } catch {
            print(error)
        }
        
        do {
             try self.createInSecureStore()
            print("Saved to keychain")
        } catch {
            print(error)
        }
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
        print("Attempting keychain login")
        if let storeData = self.readFromSecureStore(), data = storeData.data,
            firstName = data[UserField.firstName] as? String, lastName = data[UserField.lastName] as? String,
            authToken = data[UserField.authToken] as? String
        {
            self.firstName = firstName
            self.lastName = lastName
            self.authToken = authToken
            print("Read from Keychain")
            return
        }
        return nil
    }
    
    public func eraseUser() {
        do {
            try self.deleteFromSecureStore()
            try Locksmith.deleteDataForUserAccount("FDMB-FoodMob")
        } catch {
            print(error)
        }
    }
    
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

internal struct UserField {
    static let emailAddress = "email"
    static let password = "password"
    static let firstName = "first_name"
    static let lastName = "last_name"
    static let profile = "profile"
    static let authToken = "token"
}