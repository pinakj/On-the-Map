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
    
    
    init(dict: [String : AnyObject])
    {
        var dictionary = dict
        
        firstName = dictionary[ParseClient.Keys.firstname] != nil ? dictionary[ParseClient.Keys.firstname] as! String: ""
        lastName = dictionary[ParseClient.Keys.lastname] != nil ? dictionary[ParseClient.Keys.lastname] as! String: ""
        latitude = dictionary[ParseClient.Keys.latitude] != nil ? dictionary[ParseClient.Keys.latitude] as! Float: 0.0
        longitude = dictionary[ParseClient.Keys.longitude] != nil ? dictionary[ParseClient.Keys.longitude] as! Float: 0.0
        mapString = dictionary[ParseClient.Keys.mapString] != nil ? dictionary[ParseClient.Keys.mapString] as! String: ""
        mediaURL = dictionary[ParseClient.Keys.mediaURL] != nil ? dictionary[ParseClient.Keys.mediaURL] as! String: ""
        objectID = dictionary[ParseClient.Keys.objectID] != nil ? dictionary[ParseClient.Keys.objectID] as! String: ""
        uniqueKey = dictionary[ParseClient.Keys.uniqueKey] != nil ? dictionary[ParseClient.Keys.uniqueKey] as! String: ""
        updatedAt = dictionary[ParseClient.Keys.updatedAt] != nil ? dictionary[ParseClient.Keys.updatedAt] as! String: ""
    }
    
    static func converttoStudentLocation(results:[[String:AnyObject]]) -> [StudentLocation]
    {
        var studentLocations = [StudentLocation]()
        for result in results
        {
            studentLocations.append(StudentLocation(dict: result))
        }
        return studentLocations
    }
    
}


