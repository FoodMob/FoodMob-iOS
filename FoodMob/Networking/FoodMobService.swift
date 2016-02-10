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
            return "http://fluf.me:5902"
        }
    }

    public func login(emailAddress: String, password: String, completion: ((User?) -> ())? = nil) {
        Alamofire.request(.POST, ServiceEndpoint.login, parameters: [UserField.emailAddress: emailAddress, UserField.password: password], encoding: .JSON).validate().responseJSON {
            response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    if let firstName = json[UserField.profile][UserField.firstName].string,
                        lastName = json[UserField.profile][UserField.lastName].string,
                        emailAddress = json[UserField.emailAddress].string, authToken = json[UserField.authToken].string {
                            let user = User(firstName: firstName, lastName: lastName, emailAddress: emailAddress, authToken: authToken)
                            completion?(user)
                    } else {
                        completion?(nil)
                    }
                }
            case .Failure(let error):
                print(error)
                completion?(nil)
            }
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
                    completion?(json["success"].boolValue)
                }
            case .Failure(let error):
                print(error)
                completion?(false)
            }
        }
    }
}