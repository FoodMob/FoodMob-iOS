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
    public static var login: String {
        return "\(self.root)/login"
    }
    public static var loginMethod: Alamofire.Method {
        return .POST
    }
    public static var logout: String {
        return "\(self.root)/logout"
    }
    public static var logoutMethod: Alamofire.Method {
        return .POST
    }
    public static var register: String {
        return "\(self.root)/users"
    }
    public static var registerMethod: Alamofire.Method {
        return .POST
    }
    public static func foodProfile(user: User) -> String {
        return "\(self.root)/users/\(user.emailAddress)/food_profile"
    }
    public static var updateFoodProfileMethod: Alamofire.Method {
        return .PUT
    }
    public static var getFoodProfileMethod: Alamofire.Method {
        return .GET
    }
}