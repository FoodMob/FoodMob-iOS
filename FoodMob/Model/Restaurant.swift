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
    /// Yelp URL to open in Yelp application.
    public var yelpURL: NSURL? = nil
    /// Restaurant location, coordinate
    private(set) public var location: CLLocationCoordinate2D?
    /// Image URL for the restaurant's cover photo
    public var imageURL: NSURL?

    /// Deprecated, but used to convert categories to a string.
    public var categoriesString: String {
        return categories
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
    public init(name: String, categories: [FoodCategory], stars: Double, numReviews: Int, hours: String, phoneNumber: String, address: String, yelpURL: NSURL? = nil) {
        self.init(name: name, categories: categories.reduce("", combine: { (str, cat) -> String in return "\(str), \(cat.displayName)" }), stars: stars, numReviews: numReviews, hours: hours, phoneNumber: phoneNumber, address: address, yelpURL: yelpURL)
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
     - parameter yelpURL:     URL to Yelp page for restaurant.
     */
    public init(name: String, categories: String, stars: Double, numReviews: Int, hours: String, phoneNumber: String, address: String, yelpURL: NSURL? = nil) {
        self.name = name
        self.categories = categories
        self.stars = stars
        self.numReviews = numReviews
        self.hours = hours
        self.phoneNumber = phoneNumber
        self.address = address
        self.yelpURL = yelpURL
    }
}

/**
 Struct which holds JSON field name constants for Restaurants
 */
internal struct RestaurantField {
    static let root = "businesses"
    static let objectName = "restaurant"
    static let name = "name"
    static let categories = "categories"
    static let stars = "rating"
    static let reviewCount = "review_count"
    static let hoursOpen = "hoursOpen"
    static let phoneNumber = "display_phone"
    static let address = "display_address"
    static let yelpURL = "mobile_url"
    static let imageURL = "image_url"
    static let location = "location"
}