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
import UIKit.UIImage
import AlamofireImage

/**
 The actual FoodMob service data source.   Requires network access in order to function properly.
 */

public struct FoodMobService: FoodMobDataSource {
    
    private struct ServiceEndpoint : Endpoint {
        static var root: String {
            return "https://fm.fluf.me"
        }
    }
    
    public func login(emailAddress: String, password: String, completion: ((User?) -> ())? = nil) {
        guard validateEmailAddress(emailAddress) && validatePassword(password) else {
            completion?(nil)
            return
        }
        Alamofire.request(ServiceEndpoint.loginMethod, ServiceEndpoint.login, parameters: [UserField.emailAddress: emailAddress, UserField.password: password], encoding: .JSON).validate().responseJSON {
            response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json)
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
        Alamofire.request(ServiceEndpoint.registerMethod, ServiceEndpoint.register, parameters: parameters, encoding: .JSON).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    completion?(json["success"].boolValue)
                    print(json)
                }
            case .Failure(let error):
                print(error)
                completion?(false)
            }
        }
    }
    
    public func logout(user: User, completion: ((Bool) -> ())? = nil) {
        Alamofire.request(ServiceEndpoint.logoutMethod, ServiceEndpoint.logout, parameters: [UserField.emailAddress: user.emailAddress, UserField.authToken: user.authToken], encoding: .JSON).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json)
                    completion?(json["success"].boolValue)
                }
            case .Failure(let error):
                print(error)
                completion?(false)
            }
        }
        
        // We should probably log the user out of the local app anyway.
        user.eraseUser()
    }
    
    public func updateCategoriesForUser(user: User) {
        var likes = [String]()
        var dislikes = [String]()
        var restrictions = [String]()
        
        for (cat, pref) in user.categories {
            switch pref {
            case .Like:
                likes += [cat.yelpIdentifier]
            case .Dislike:
                dislikes += [cat.yelpIdentifier]
            case .Restriction:
                restrictions += [cat.yelpIdentifier]
            default:
                print("Ignoring pref \(cat.yelpIdentifier)")
            }
        }
        
        let foodProfile = [UserField.FoodProfile.likes: likes, UserField.FoodProfile.dislikes: dislikes, UserField.FoodProfile.restrictions : restrictions]
        
        Alamofire.request(ServiceEndpoint.updateFoodProfileMethod, ServiceEndpoint.foodProfile(user), parameters: [UserField.authToken: user.authToken, UserField.foodProfile: foodProfile], encoding: .JSON).validate().responseJSON { response in
            
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json)
                }
            case .Failure(let error):
                print(error)
            }
            
        }
    }
    
    public func fetchCategoriesForUser(user: User, completion: ((Bool)->())? = nil) {
        Alamofire.request(ServiceEndpoint.getFoodProfileMethod, ServiceEndpoint.foodProfile(user), parameters: [UserField.authToken: user.authToken], encoding: .URL).validate().responseJSON { response in
            debugPrint(response.request)
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json)
                    let profile = json[UserField.foodProfile].dictionaryValue
                    var categories = [FoodCategory : Preference]()
                    self.fetchCategoryListing({ (catListing) in
                        if let likes = profile[UserField.FoodProfile.likes]?.arrayValue,
                            dislikes = profile[UserField.FoodProfile.dislikes]?.arrayValue,
                            restrictions = profile[UserField.FoodProfile.restrictions]?.arrayValue {
                            for like in likes {
                                if let cat = catListing[like.stringValue] {
                                    categories[cat] = Preference.Like
                                }
                            }
                            for dislike in dislikes {
                                if let cat = catListing[dislike.stringValue] {
                                    categories[cat] = Preference.Dislike
                                }
                            }
                            for restriction in restrictions {
                                if let coolCat = catListing[restriction.stringValue] {
                                    categories[coolCat] = Preference.Restriction
                                }
                            }
                            user.categories = categories
                        }
                        completion?(json["success"].boolValue)
                    })
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    public func fetchRestaurantsForSearch(search: RestaurantSearch, withUser user: User, completion: (([Restaurant]) -> ())?) {
        var parameters: [String: AnyObject] = [
            UserField.authToken: user.authToken,
            UserField.emailAddress: user.emailAddress,
        ]
        search.jsonDictionary.forEach { (tuple) in
            parameters[tuple.0] = tuple.1
        }
        Alamofire.request(ServiceEndpoint.searchMethod, ServiceEndpoint.search, parameters: parameters, encoding: .JSON).validate().responseJSON { response in
            switch response.result {
            case .Success:
                var restaurants = [Restaurant]()
                if let value = response.result.value {
                    let json = JSON(value)
                    for restaurant in json[RestaurantField.root].arrayValue {
                        var cats = restaurant[RestaurantField.categories].arrayValue.reduce("", combine: { (str, json) -> String in
                            return "\(str), \(json.arrayValue[0].stringValue)"
                        })
                        cats = cats.substringFromIndex(cats.startIndex.advancedBy(2))
                        let location = restaurant[RestaurantField.location].dictionaryValue
                        let address = location[RestaurantField.address]?.arrayValue.reduce("", combine: { (s, json) -> String in
                            return "\(s)\(json.stringValue)\n"
                        }).stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                        var rst = Restaurant(name: restaurant[RestaurantField.name].stringValue, categories: cats, stars: restaurant[RestaurantField.stars].doubleValue, numReviews: restaurant[RestaurantField.reviewCount].intValue, hours: "", phoneNumber: restaurant[RestaurantField.phoneNumber].stringValue, address: address ?? "")
                        rst.yelpURL = restaurant[RestaurantField.yelpURL].URL
                        rst.imageURL = restaurant[RestaurantField.imageURL].URL
                        restaurants.append(rst)
                    }
                }
                completion?(restaurants)
            case .Failure(let error):
                print(error)
                completion?([])
            }
            
        }
    }

    public func fetchFriendsListing(forUser user: User, completion: (([User])->())? = nil) {
        let parameters: [String: AnyObject] = [
            UserField.authToken: user.authToken
        ]
        var friendList: [User] = []
        Alamofire.request(ServiceEndpoint.getFriendsMethod, ServiceEndpoint.friends(user), parameters: parameters, encoding: .URL).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json)
                    for friend in json[UserField.friends].arrayValue {
                        if let firstName = friend[UserField.firstName].string, lastName = friend[UserField.lastName].string, email = friend[UserField.emailAddress].string {
                            friendList.append(User(firstName: firstName, lastName: lastName, emailAddress: email))
                        }
                    }
                }
            case .Failure(let error):
                print(response.result.value)
                print(error)
            }
            completion?(friendList)
        }
    }

    public func addFriendWithEmail(emailAddress: String, forUser user: User, completion: ((Bool, String)->())? = nil) {
        let parameters: [String: AnyObject] = [
            UserField.authToken: user.authToken,
            UserField.friendEmail: emailAddress
        ]
        Alamofire.request(ServiceEndpoint.setFriendsMethod, ServiceEndpoint.friends(user), parameters: parameters, encoding: .JSON).validate().responseJSON {
            response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    if json["success"].boolValue {
                        completion?(true, "")
                    } else {
                        completion?(false, json["error"].stringValue)
                    }
                }
            case .Failure(_):
                completion?(false, "Network Error")
            }
        }
    }
    
}