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
    public var priceRange: PriceRange = .Any
    /// Radius to search near `location`.
    public var radius: CLLocationDistance = 10_000
    /// Location to search around.
    public var location: CLLocationCoordinate2D? = Session.sharedSession.locationManager.location?.coordinate
    /// Location to search around.  When set, the coordinate is ignored.
    public var locationString: String?
    
    public init() {
        
    }
}
public struct RestaurantSearchField {
    static let locationField = "location"
}

/**
 A price range to search for
 
 - Any:                       For when you just don't care. 💸🤑
 - One:                       One dollar sign 💰
 - Two:                       Two dollar signs 💰💰
 - Three:                     Three dollar signs 💰💰💰
 - ImSoLoadedItsNotEvenFunny: Four dollar signs 💰💰💰💰
 */
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