//
//  FoodMobService.swift
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
            return "http://localhost:8080"
        }
    }

    public func login(emailAddress: String, password: String, completion: ((User?) -> ())? = nil) {
        // TODO
        Alamofire.request(.POST, ServiceEndpoint.login, parameters: ["emailAddress": emailAddress, "password": password], encoding: .JSON).responseData {
            response in
            print(response.request)
            print(response.response)
        }
    }

    @warn_unused_result
    public func register(firstName firstName: String, lastName: String, emailAddress: String, password: String, completion: ((Bool) -> ())? = nil) {
        guard validateName(firstName) &&
            validateName(lastName) &&
            validateEmailAddress(emailAddress) &&
            validatePassword(password)
            else {
                completion?(false)
                return
        }
        let parameters = [
            UserField.emailAddress : emailAddress,
            UserField.password : password,
            UserField.firstName : firstName,
            UserField.lastName : lastName
        ]
        Alamofire.request(.POST, ServiceEndpoint.register, parameters: parameters, encoding: .JSON).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("json: \(json)")
                    completion?(json["success"].boolValue)
                }
            case .Failure(let error):
                print(error)
                completion?(false)
            }
        }
    }
}

private struct UserField {
    static let emailAddress = "email"
    static let password = "password"
    static let firstName = "first_name"
    static let lastName = "last_name"
}