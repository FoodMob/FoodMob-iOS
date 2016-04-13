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
    
    /// Shared location manager for use in the application.
    public var locationManager: CLLocationManager!

     /**
     Prevents another instantiation of this object, as it is a singleton.
     */
    private init() {}
}