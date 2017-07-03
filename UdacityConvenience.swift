//
//  UdacityConvenience.swift
//  On The Map
//
//  Created by Pinak Jalan on 7/2/17.
//  Copyright © 2017 Pinak Jalan. All rights reserved.
//

import Foundation
import UIKit

extension UdacityClient{
    func authenticateWithViewController(_ hostViewController: UIViewController,userCreds:[String:[String:AnyObject]], completionHandlerForAuth: @escaping (_ success: Bool, _ errorString: String?) -> Void) {
        getsessionID(userCreds: userCreds){(success, sessionID,errorString) in
            
            if success
            {
                self.sessionID = sessionID
                completionHandlerForAuth(success, nil)
            }
            else
            {
                completionHandlerForAuth(success, errorString)

            }
        }
    }
    
    func getsessionID(userCreds:[String:[String:AnyObject]],completionhandlerforSession: @escaping (_ success: Bool,_ sessionID: String?, _ errorString: String?) -> Void)
    {
        //TO DO:Construct the JSON body and pass in the method. The result method should have the result
        
        let jsonBody:String = "{\"udacity\": {\"username\": \"\(String(describing: UdacityClient.Constants.username))\", \"password\": \"\(String(describing: UdacityClient.Constants.password))\"}}"

        self.taskforPOSTMethod(userCreds,UdacityClient.Methods.newSessionWithAPI, jsonBody: jsonBody){(result, error) in
            
            if error != nil
            {
                completionhandlerforSession(false,nil,"Error while trying to execute the post method")
            }
            
            else
            {
                let session = result?["session"] as! [String:AnyObject]
                self.sessionID = session["id"] as? String
                print(self.sessionID!)
                completionhandlerforSession(true,self.sessionID,nil)
            }
        }
    }
    
}
