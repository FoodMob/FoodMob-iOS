//
//  RemoteDataSource.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/5/16.
//  Copyright © 2016 Jonathan Jemson. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

/**
 The actual FoodMob service data source.   Requires network access in order to function properly.
*/
public struct FoodMobService: FoodMobDataSource {
    
    private struct ServiceEndpoint : Endpoint {
        static var root: String {
            return "https://fluf.me/foodmob"
        }
    }

    public func login(emailAddress: String, password: String) -> User? {
        // TODO
        Alamofire.request(.POST, ServiceEndpoint.login, parameters: ["emailAddress": emailAddress, "password": password], encoding: .JSON).responseData {
            response in
            print(response.request)
            print(response.response)
        }
        return nil
    }

    @warn_unused_result
    public func register(firstName firstName: String, lastName: String, emailAddress: String, password: String) -> User? {
        // TODO
        return nil
    }
}