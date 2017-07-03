//
//  UdacityClient.swift
//  On The Map
//
//  Created by Pinak Jalan on 7/2/17.
//  Copyright © 2017 Pinak Jalan. All rights reserved.
//

import Foundation
import UIKit


class UdacityClient: NSObject {
    
    let sharedURLSession = URLSession.shared
    var sessionID: String? = nil
    
    //What we need for this method: URL, method, JSONBody and completion handler
    func taskforPOSTMethod(_ parameters:[String:[String:AnyObject]], _ method:String, jsonBody:String, completionHandlerForPOST: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask
    {
        let url = URL(string:(UdacityClient.Constants.BaseURL + method))
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }
        //print(jsonBody)
        //print(url)
        let task = sharedURLSession.dataTask(with: request){ (data, response, error) in

            func sendError(_ error:String)
            {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey:error]
            completionHandlerForPOST(nil,NSError(domain: "taskforPOSTMethod", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else
            {
                sendError("There was an error associated with your program!")
                return
            }
            
            let range = Range(5..<data!.count)
            guard let newData = data?.subdata(in: range) else
            {
                sendError("Couldn't find newData.")
                return
            }
            print(newData)
            var parsedResult:AnyObject!
            do
            {
                parsedResult = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as? AnyObject
            }
            catch{
                sendError("Could not parse JSON Data")
            }
            completionHandlerForPOST(parsedResult, nil)
        }
        task.resume()
        return task
    }
    
    func taskforDELETEMethod(_ method:String, completionHandlerForDELETE: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask
    {
        let url = URL(string: (UdacityClient.Constants.BaseURL+method))
        var request = URLRequest(url: url!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let task = sharedURLSession.dataTask(with: request){(data, response,error) in
            
            func sendError(_ error: String)
            {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey:error]
                completionHandlerForDELETE(nil, NSError(domain: "taskforDELETEMethod", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else
            {
                sendError("There was an error associated with your program!")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else
            {
                sendError("HTTP code errror!")
                return
            }
            
            
            let range = Range(5..<data!.count)
            guard let newData = data?.subdata(in: range) else
            {
                sendError("Couldn't find newData.")
                return
            }
            print(newData)
            var parsedResult:AnyObject!
            do
            {
                parsedResult = try JSONSerialization.jsonObject(with: newData, options: .allowFragments) as? AnyObject
            }
            catch{
                sendError("Could not parse JSON Data")
            }
            print(NSString(data: newData, encoding: String.Encoding.utf8.rawValue)!)
        }
        task.resume()
        return task
    }
    
    
    
    //Creating a singleton
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
    
    
    
    
    
    
    
}
