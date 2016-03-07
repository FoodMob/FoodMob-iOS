//
//  RestaurantSearch.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 3/2/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import Foundation
import CoreLocation

public struct RestaurantSearch {
    public var users: [User]
    public var priceRange: PriceRange
    public var radius: CLLocationDistance
    public var location: CLLocationCoordinate2D
}

public enum PriceRange: Int {
    /**
     One dollar sign
     */
    case One = 1
    /**
     Two dollar signs
     */
    case Two = 2
    /**
     Three dollar signs
     */
    case Three = 3
    /**
     Four dollar signs
     */
    case ImSoLoadedItsNotEvenFunny = 4
}