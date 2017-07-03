//
//  StudentLocation.swift
//  On The Map
//
//  Created by Pinak Jalan on 7/3/17.
//  Copyright © 2017 Pinak Jalan. All rights reserved.
//

import Foundation
import UIKit


class StudentLocation{
    
    var objectID:String!
    var uniqueKey:String!
    var firstName:String!
    var lastName:String!
    var mapString:String!
    var mediaURL:String!
    var latitude:Float!
    var longitude:Float!
    var createdAt:String!
    var updatedAt:String!
    
    
    init(_ dictionary:[String:AnyObject])
    {
        var dictionary = dictionary
        dictionary[ParseClient.Keys.objectID] = objectID as AnyObject
        dictionary[ParseClient.Keys.uniqueKey] = uniqueKey as AnyObject
        dictionary[ParseClient.Keys.firstname] = firstName as AnyObject
        dictionary[ParseClient.Keys.lastname] = lastName as AnyObject
        dictionary[ParseClient.Keys.mapString] = mapString as AnyObject
        dictionary[ParseClient.Keys.mediaURL] = mediaURL as AnyObject
        dictionary[ParseClient.Keys.latitude] = latitude as AnyObject
        dictionary[ParseClient.Keys.longitude] = longitude as AnyObject
        dictionary[ParseClient.Keys.createdAt] = createdAt as AnyObject
        dictionary[ParseClient.Keys.updatedAt] = updatedAt as AnyObject
        
    }
    
}


