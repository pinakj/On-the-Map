//
//  ParseClient.swift
//  On The Map
//
//  Created by Pinak Jalan on 7/3/17.
//  Copyright © 2017 Pinak Jalan. All rights reserved.
//

import Foundation
import UIKit


class ParseClient:NSObject{
    
    let sharedURLSession = URLSession.shared
    
    
    func taskforGETMethod(_ method:String, completionhandlerforGET:@escaping(_ studentData:Data?,_ error:NSError?) -> Void) -> URLSessionTask
    {
        let url = URL(string: (ParseClient.Constants.baseURL + method))
        var request = URLRequest(url: url!)
        request.addValue("\(ParseClient.Constants.APIKey)", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("\(ParseClient.Constants.applicationID)", forHTTPHeaderField: "X-Parse-Application-Id")
        let task = sharedURLSession.dataTask(with: request) {(data, response, error) in
            
            if error != nil { // Handle error...
                return
            }
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
            
        }
        task.resume()
        return task
    }
    
    func taskforPOSTMethod()
    {
        
    }
    
    func taskforPUTMethod()
    {
        
    }
    //Creating a singleton
    class func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }
    
}
