//
//  FoodCategories.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/10/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import Foundation

/**
 Preference indicates whether a user likes, dislikes, or cannot have a certain food category.
 */
public enum Preference: Int {
    /// No preference.  Usuaslly a sign of an error.
    case None = 0
    /// Indicates that a user likes this category.
    case Like = 1
    /// Indicates that a user dislikes this category.
    case Dislike = 2
    /// Indicates that a user cannot have this category.
    case Restriction = 3

    /// A string representation of this enum.
    public var showingTypeString: String {
        switch self {
        case None:
            return "None"
        case Like:
            return "Likes"
        case Dislike:
            return "Dislikes"
        case Restriction:
            return "Restrictions"
        }
    }
}

/*
 Represents a food category, which is the tuple of the human-readable name and the Yelp identifier.
 */
public struct FoodCategory: Hashable, Equatable {
    private(set) public var displayName: String
    private(set) public var yelpIdentifier: String
    
    public var hashValue: Int {
        return yelpIdentifier.hashValue
    }
}

/**
 Equatability for a FoodCategory.  Two food categories are equal iff
 the Yelp identifiers are equal.
 
 - parameter lhs: Left side of the expression.
 - parameter rhs: Right side of the expression.
 
 - returns: Whether two food categories are equal.
 */
public func ==(lhs: FoodCategory, rhs: FoodCategory) -> Bool {
    return lhs.yelpIdentifier == rhs.yelpIdentifier
}