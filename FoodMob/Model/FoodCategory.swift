//
//  FoodCategories.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/10/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import Foundation

public enum Preference: Int {
    case None = 0
    case Like = 1
    case Dislike = 2
    case Restriction = 3

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

public enum FoodCategory: String, Hashable {

    public var hashValue: Int {
        return self.rawValue.hashValue
    }

    static let values = [
        AmericanNew,
        AmericanTraditional,
        AsianFusion,
        Barbeque,
        Bars,
        BreakfastAndBrunch,
        Burgers,
        ChickenWings,
        Chinese,
        Diners,
        Food,
        Indian,
        Italian,
        Japanese,
        Korean,
        Mexican,
        Nightlife,
        Pizza,
        Sandwiches,
        Seafood,
        Southern,
        SportsBars,
        Steakhouses,
        SushiBars,
        TexMex,
        Thai
    ]

    case Sandwiches = "Sandwiches"
    case Pizza = "Pizza"
    case Mexican = "Mexican"
    case AmericanTraditional = "American (Traditional)"
    case Nightlife = "Nightlife"
    case Burgers = "Burgers"
    case Bars = "Bars"
    case ChickenWings = "Chicken Wings"
    case Chinese = "Chinese"
    case AmericanNew = "American (New)"
    case Food = "Food"
    case BreakfastAndBrunch = "Breakfast & Brunch"
    case Italian = "Italian"
    case Seafood = "Seafood"
    case Barbeque = "Barbeque"
    case Japanese = "Japanese"
    case SushiBars = "Sushi Bars"
    case Diners = "Diners"
    case Southern = "Southern"
    case SportsBars = "Sports Bars"
    case TexMex = "Tex-Mex"
    case Steakhouses = "Steakhouses"
    case Thai = "Thai"
    case Korean = "Korean"
    case AsianFusion = "Asian Fusion"
    case Indian = "Indian"
}