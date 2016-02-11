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

    /**
     Count of the number of categories in this enum.

     Must be manually updated, because enums don't have a count :/
     */

    public var hashValue: Int {
        return self.rawValue.hashValue
    }

    static let values = [
        Afghan,
        African,
        AmericanNew,
        AmericanTraditional,
        Arabian,
        Argentine,
        Armenian,
        AsianFusion,
        Australian,
        Austrian,
        Bangladeshi,
        Barbeque,
        Basque,
        Belgian,
        Brasseries,
        Brazilian,
        BreakfastAndBrunch,
        British,
        Buffets,
        Burgers,
        Burmese,
        Cafes,
        Cafeteria,
        CajunAndCreole,
        Cambodian,
        Caribbean,
        Catalan,
        Cheesesteaks,
        ChickenWings,
        Chinese,
        ComfortFood,
        Creperies,
        Cuban,
        Czech,
        Delis,
        Diners,
        Ethiopian,
        FastFood,
        Filipino,
        FishAndChips,
        Fondue,
        FoodCourt,
        FoodStands,
        French,
        Gastropubs,
        German,
        GlutenFree,
        Greek,
        Halal,
        Hawaiian,
        HimalayanAndNepalese,
        HotDogs,
        HotPot,
        Hungarian,
        Iberian,
        Indian,
        Indonesian,
        Irish,
        Italian,
        Japanese,
        Korean,
        Kosher,
        Laotian,
        LatinAmerican,
        LiveAndRawFood,
        Malaysian,
        Mediterranean,
        Mexican,
        MiddleEastern,
        ModernEuropean,
        Mongolian,
        Pakistani,
        PersianAndIranian,
        Peruvian,
        Pizza,
        Polish,
        Portuguese,
        Russian,
        Salad,
        Sandwiches,
        Scandinavian,
        Scottish,
        Seafood,
        Singaporean,
        Slovakian,
        SoulFood,
        Soup,
        Southern,
        Spanish,
        Steakhouses,
        SushiBars,
        Taiwanese,
        TapasAndSmallPlates,
        TapasBars,
        TexMex,
        Thai,
        Turkish,
        Ukrainian,
    ]

    case Polish = "Polish"
    case Portuguese = "Portuguese"
    case Russian = "Russian"
    case Salad = "Salad"
    case Sandwiches = "Sandwiches"
    case Scandinavian = "Scandinavian"
    case Scottish = "Scottish"
    case Seafood = "Seafood"
    case Singaporean = "Singaporean"
    case Slovakian = "Slovakian"
    case SoulFood = "Soul Food"
    case Soup = "Soup"
    case Southern = "Southern"
    case Spanish = "Spanish"
    case Steakhouses = "Steakhouses"
    case SushiBars = "Sushi Bars"
    case Taiwanese = "Taiwanese"
    case TapasBars = "Tapas Bars"
    case TapasAndSmallPlates = "Tapas/Small Plates"
    case TexMex = "Tex-Mex"
    case Thai = "Thai"
    case Turkish = "Turkish"
    case Ukrainian = "Ukrainian"
    case Afghan = "Afghan"
    case Caribbean = "Caribbean"
    case HotDogs = "Hot Dogs"
    case African = "African"
    case Catalan = "Catalan"
    case HotPot = "Hot Pot"
    case AmericanNew = "American (New)"
    case Cheesesteaks = "Cheesesteaks"
    case Hungarian = "Hungarian"
    case AmericanTraditional = "American (Traditional)"
    case ChickenWings = "Chicken Wings"
    case Iberian = "Iberian"
    case Arabian = "Arabian"
    case Chinese = "Chinese"
    case Indian = "Indian"
    case Argentine = "Argentine"
    case ComfortFood = "Comfort Food"
    case Indonesian = "Indonesian"
    case Armenian = "Armenian"
    case Creperies = "Creperies"
    case Irish = "Irish"
    case AsianFusion = "Asian Fusion"
    case Cuban = "Cuban"
    case Italian = "Italian"
    case Australian = "Australian"
    case Czech = "Czech"
    case Japanese = "Japanese"
    case Austrian = "Austrian"
    case Delis = "Delis"
    case Korean = "Korean"
    case Bangladeshi = "Bangladeshi"
    case Diners = "Diners"
    case Kosher = "Kosher"
    case Barbeque = "Barbeque"
    case Ethiopian = "Ethiopian"
    case Laotian = "Laotian"
    case Basque = "Basque"
    case FastFood = "Fast Food"
    case LatinAmerican = "Latin American"
    case Belgian = "Belgian"
    case Filipino = "Filipino"
    case LiveAndRawFood = "Live/Raw Food"
    case Brasseries = "Brasseries"
    case FishAndChips = "Fish & Chips"
    case Malaysian = "Malaysian"
    case Brazilian = "Brazilian"
    case Fondue = "Fondue"
    case Mediterranean = "Mediterranean"
    case BreakfastAndBrunch = "Breakfast & Brunch"
    case FoodCourt = "Food Court"
    case Mexican = "Mexican"
    case British = "British"
    case FoodStands = "Food Stands"
    case MiddleEastern = "Middle Eastern"
    case Buffets = "Buffets"
    case French = "French"
    case ModernEuropean = "Modern European"
    case Burgers = "Burgers"
    case Gastropubs = "Gastropubs"
    case Mongolian = "Mongolian"
    case Burmese = "Burmese"
    case German = "German"
    case Pakistani = "Pakistani"
    case Cafes = "Cafes"
    case GlutenFree = "Gluten-Free"
    case PersianAndIranian = "Persian/Iranian"
    case Cafeteria = "Cafeteria"
    case Greek = "Greek"
    case Peruvian = "Peruvian"
    case CajunAndCreole = "Cajun/Creole"
    case Halal = "Halal"
    case Pizza = "Pizza"
    case Cambodian = "Cambodian"
    case Hawaiian = "Hawaiian"
    case HimalayanAndNepalese = "Himalayan/Nepalese"
}