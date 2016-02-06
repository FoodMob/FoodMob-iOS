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
    
    public let service = "FoodMob"
    public var account: String {
        return self.emailAddress
    }
    public var data: [String : AnyObject] {
        return ["token": self.authToken]
    }
}