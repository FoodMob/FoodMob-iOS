//
//  Session.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/10/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import Foundation

public struct Session {
    public static var sharedSession = Session()
    public var currentUser: User?
}