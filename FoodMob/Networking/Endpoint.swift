//
//  Endpoint.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/5/16.
//  Copyright © 2016 Jonathan Jemson. All rights reserved.
//

import Alamofire
import Foundation

/**
 Encapsulates an endpoint for a FoodMob service provider.
 A protocol extension provides the rest of the routes.
 */
public protocol Endpoint {
    /**
     The root of the application.  For example: foodmob.me/api
     */
    static var root: String { get }
}


public extension Endpoint {
    
    /// Endpoint to log a user in.
    public static var login: String {
        return "\(self.root)/login"
    }
    
    /// Method to log a user in.
    public static var loginMethod: Alamofire.Method {
        return .POST
    }
    
    /// Endpoint to log a user out.
    public static var logout: String {
        return "\(self.root)/logout"
    }
    
    /// Method to log a user out.
    public static var logoutMethod: Alamofire.Method {
        return .POST
    }
    
    /// Endpoint to register a new user.
    public static var register: String {
        return "\(self.root)/users"
    }
    
    /// Method to register a new user.
    public static var registerMethod: Alamofire.Method {
        return .POST
    }
    
    /// Endpoint for the food profile (category) information
    /// Parameter user: The user whose information we're looking up or updating
    public static func foodProfile(user: User) -> String {
        return "\(self.root)/users/\(user.emailAddress)/food_profile"
    }
    
    /// Method to update food profile for a user.
    public static var updateFoodProfileMethod: Alamofire.Method {
        return .PUT
    }
    
    /// Method to get food profile for a user.
    public static var getFoodProfileMethod: Alamofire.Method {
        return .GET
    }
}