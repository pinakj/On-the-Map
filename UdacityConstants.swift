//
//  UdacityConstants.swift
//  On The Map
//
//  Created by Pinak Jalan on 7/2/17.
//  Copyright © 2017 Pinak Jalan. All rights reserved.
//

import Foundation


extension UdacityClient{
        
    struct Constants
    {
        static let BaseURL = "https://www.udacity.com/api/"
        static var username = "username"
        static var password = "password"
        static var udacity = "udacity"
        static var userID = "user_id"
        
    }
    
    struct Methods
    {
        static let newSessionWithAPI = "session"
        static let getuserID = "users/id"
        static let uniqueKey = "uniqueKey"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let mapString = "mapString"
        static let mediaURL = "mediaURL"
        static let lat = "latitude"
        static let long = "longitude"
        
    }

    
    
    
}
