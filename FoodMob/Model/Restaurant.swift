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

    /// Restaurant name
    private(set) public var name: String
    /// Categories string
    private(set) public var categories: String = ""
    /// Stars, out of 5
    private(set) public var stars: Double
    /// Number of reviews
    private(set) public var numReviews: Int
    /// Open hours, deprecated
    private(set) public var hours: String
    /// Restaurant phone number
    private(set) public var phoneNumber: String
    /// Restaurant address
    private(set) public var address: String
    /// Restaurant location, coordinate
    private(set) public var location: CLLocationCoordinate2D?
    /// Image URL for the restaurant's cover photo
    public var imageURL: NSURL?

    /// Deprecated, but used to convert categories to a string.
    public var categoriesString: String {
        return categories
    }

    /**
     Initialize restaurant from a JSON object

     - parameter json: JSON object representing the restaurant
     */
    public init(json: JSON) {
        name = json[RestaurantField.name].stringValue
        stars = json[RestaurantField.stars].doubleValue
        numReviews = json[RestaurantField.reviewCount].intValue
        hours = json[RestaurantField.hoursOpen].stringValue
        phoneNumber = json[RestaurantField.phoneNumber].stringValue
        address = json[RestaurantField.address].stringValue
    }

    /**
     Convenience initializer for a restaurant.

     - parameter name:        Restaurant name
     - parameter categories:  Food categories represented by the restaurant
     - parameter stars:       Number of stars, out of 5
     - parameter numReviews:  Number of reviews
     - parameter hours:       Hours the restaurant is opened
     - parameter phoneNumber: The phone number of the restaurant
     - parameter address:     Restaurant address
     */
    public init(name: String, categories: [FoodCategory], stars: Double, numReviews: Int, hours: String, phoneNumber: String, address: String) {
        self.init(name: name, categories: categories.reduce("", combine: { (str, cat) -> String in return "\(str), \(cat.displayName)" }), stars: stars, numReviews: numReviews, hours: hours, phoneNumber: phoneNumber, address: address)
    }
    /**
     Designated initializer for a restaurant.

     - parameter name:        Restaurant name
     - parameter categories:  Food categories represented by the restaurant, as a string
     - parameter stars:       Number of stars, out of 5
     - parameter numReviews:  Number of reviews
     - parameter hours:       Hours the restaurant is opened
     - parameter phoneNumber: The phone number of the restaurant
     - parameter address:     Restaurant address
     */
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