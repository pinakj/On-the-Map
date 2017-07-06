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
    var studentInfo: [StudentLocation]? = []
    
    func taskforGETMethod(_ method:String, completionhandlerforGET:@escaping(_ studentData:[StudentLocation],_ error:String?,_ success: Bool?) -> Void) -> URLSessionTask
    {
        let url = URL(string: (ParseClient.Constants.baseURL + method))
        var request = URLRequest(url: url!)
        request.addValue("\(ParseClient.Constants.APIKey)", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("\(ParseClient.Constants.applicationID)", forHTTPHeaderField: "X-Parse-Application-Id")
        let task = sharedURLSession.dataTask(with: request) {(data, response, error) in
            
            if error != nil { // Handle error...
                return
            }
            var parsedResult: AnyObject!
            do
            {
                try parsedResult = JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
            }
            catch
            {
                completionhandlerforGET( [], "Error received in JSON!", false)
                
            }
            let resultsArray = parsedResult["results"] as! [[String:AnyObject]]
            completionhandlerforGET(StudentLocation.converttoStudentLocation(results: resultsArray),nil, true)
                
        }
        task.resume()
        return task
    }
    
    func taskforPOSTMethod(_ method:String,_ parameters:[String:AnyObject], completionhandlerforPOST:@escaping(_ error:String?,_ success: Bool?) -> Void) -> URLSessionTask
    {
        let url = URL(string: (ParseClient.Constants.baseURL + method))
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue(ParseClient.Constants.APIKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue(ParseClient.Constants.applicationID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        do
        {
            request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }

        let task = sharedURLSession.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
            completionhandlerforPOST(nil, true)
        }
        task.resume()
        return task
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
