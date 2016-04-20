//
//  RestaurantSearch.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 3/2/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import Foundation
import CoreLocation

/**
 Encapuslates the search for a restaurant.
 */
public struct RestaurantSearch {
    /// Users included in the search.
    public var users: [User] = []
    /// Categories included/excluded in the search.
    public var categories = [FoodCategory: Preference]()
    /// Price range to search for.
    @available(*, deprecated, message="Yelp API doesn't work with dollar signs")
    public var priceRange: PriceRange = .Any
    /// Radius to search near `location`.
    public var radius: CLLocationDistance = 10_000
    /// Location to search around.
    public var location: CLLocationCoordinate2D? = Session.sharedSession.locationManager.location?.coordinate {
        willSet {
            if newValue != nil {
                self.locationString = nil
            }
        }
    }
    public let nearbyLocation = Session.sharedSession.locationManager.location?.coordinate
    /// Location to search around.  When set, the coordinate is ignored.
    public var locationString: String? {
        willSet {
            if newValue != nil && newValue! != "" {
                self.location = nil
            }
        }
    }

    /// Number of stars to include
    public var stars: Int = 0 {
        willSet {
            if newValue > 5 {
                self.stars = 5
            }
            if newValue < 0 {
                self.stars = 0
            }
        }
    }

    /// JSON serialization for use with Alamofire.
    public var jsonDictionary: [String: AnyObject] {
        var parameters: [String: AnyObject] = [
            RestaurantSearchField.nearby: [self.nearbyLocation?.latitude ?? 0, self.nearbyLocation?.longitude ?? 0]
        ]
        if let location = self.locationString where location != "" {
            parameters[RestaurantSearchField.locationField] = location
        } else if let location = self.location {
            parameters[RestaurantSearchField.latLong] = [location.latitude, location.longitude]
        }
        return parameters
    }
    
    public init() {}
}

/**
 Struct that holds restaurant search JSON field names
 */
public struct RestaurantSearchField {
    static let locationField = "location"
    static let latLong = "ll"
    static let nearby = "cll"
}

/**
 A price range to search for
 
 - Any:                       For when you just don't care. 💸🤑
 - One:                       One dollar sign 💰
 - Two:                       Two dollar signs 💰💰
 - Three:                     Three dollar signs 💰💰💰
 - ImSoLoadedItsNotEvenFunny: Four dollar signs 💰💰💰💰
 */
@available(*, deprecated, message="Yelp API doesn't work with dollar signs")
public enum PriceRange: Int {
    /**
     For when you just don't care. 💸🤑
     */
    case Any = 0
    /**
     One dollar sign 💰
     */
    case One = 1
    /**
     Two dollar signs 💰💰
     */
    case Two = 2
    /**
     Three dollar signs 💰💰💰
     */
    case Three = 3
    /**
     Four dollar signs 💰💰💰💰
     */
    case ImSoLoadedItsNotEvenFunny = 4
}