//
//  ParseConstants.swift
//  On The Map
//
//  Created by Pinak Jalan on 7/3/17.
//  Copyright © 2017 Pinak Jalan. All rights reserved.
//

import Foundation
import UIKit


extension ParseClient{
    
    struct Keys {
        static let objectID = "objectID"
        static let uniqueKey = "uniqueKey"
        static let firstname = "firstName"
        static let lastname = "lastName"
        static let mapString = "mapString"
        static let mediaURL = "mediaURL"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let createdAt = "createdAt"
        static let updatedAt = "updatedAt"
    }
    
    struct Constants {
        static let baseURL = "https://parse.udacity.com/parse/classes/"
        static let APIKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let applicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    }
    
    struct Methods{
        static let studentLocation = "StudentLocation"

    }
    
}
