//
//  Session.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/10/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import Foundation
import CoreLocation

/**
 Represents a session shared across the application.
 */
public struct Session {
    /**
     Retrieves the current session.
     */
    public static var sharedSession = Session()
    
    /**
     Retrieves the currently signed in user.
     */
    public var currentUser: User?
    
    public var locationManager: CLLocationManager?

    private init() {
        
    }
}