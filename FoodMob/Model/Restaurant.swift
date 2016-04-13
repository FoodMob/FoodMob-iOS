//
//  Restaurant.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 3/1/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import UIKit.UIImage
import SwiftyJSON
import CoreLocation

public struct Restaurant {
    private(set) public var name: String
    private(set) public var categories: String = ""
    private(set) public var stars: Double
    private(set) public var numReviews: Int
    private(set) public var hours: String
    private(set) public var phoneNumber: String
    private(set) public var address: String
    private(set) public var location: CLLocationCoordinate2D?
    public var imageURL: NSURL?

    public var categoriesString: String {
        return categories
    }
    
    public init(json: JSON) {
        name = json[RestaurantField.name].stringValue
//        if let cats = json[RestaurantField.categories].array {
//            for cat in cats {
//                if let cat = FoodCategory(rawValue: cat.stringValue) {
//                    categories.append(cat)
//                }
//            }
//        }
        stars = json[RestaurantField.stars].doubleValue
        numReviews = json[RestaurantField.reviewCount].intValue
        hours = json[RestaurantField.hoursOpen].stringValue
        phoneNumber = json[RestaurantField.phoneNumber].stringValue
        address = json[RestaurantField.address].stringValue
    }
    
    public init(name: String, categories: [FoodCategory], stars: Double, numReviews: Int, hours: String, phoneNumber: String, address: String) {
        self.name = name
        self.categories = categories.reduce("", combine: { (str, cat) -> String in
            return "\(str), \(cat.displayName)"
        })
        self.stars = stars
        self.numReviews = numReviews
        self.hours = hours
        self.phoneNumber = phoneNumber
        self.address = address
    }
    public init(name: String, categories: String, stars: Double, numReviews: Int, hours: String, phoneNumber: String, address: String) {
        self.name = name
        self.categories = categories
        self.stars = stars
        self.numReviews = numReviews
        self.hours = hours
        self.phoneNumber = phoneNumber
        self.address = address
    }
}

/**
 Struct which holds JSON field name constants for Restaurants
 */
internal struct RestaurantField {
    static let objectName = "restaurant"
    static let name = "name"
    static let categories = "categories"
    static let stars = "stars"
    static let reviewCount = "reviewCount"
    static let hoursOpen = "hoursOpen"
    static let phoneNumber = "phone"
    static let address = "address"
}