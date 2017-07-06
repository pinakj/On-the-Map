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
        getsessionID(userCreds: userCreds){(success, sessionID,userID,errorString) in
            
            if success
            {
                self.userID = userID
                self.sessionID = sessionID
                print("User ID", userID)
                completionHandlerForAuth(success, nil)
            }
            else
            {
                completionHandlerForAuth(success, errorString)

            }
        }
    }
    
    func getsessionID(userCreds:[String:[String:AnyObject]],completionhandlerforSession: @escaping (_ success: Bool,_ sessionID: String?,_ userID:String, _ errorString: String?) -> Void)
    {

        self.taskforPOSTMethod(userCreds,UdacityClient.Methods.newSessionWithAPI){(result, error) in
            
            if error != nil
            {
                completionhandlerforSession(false, "", "", "Error while trying to execute the post method")
            }
            
            else
            {
                let session = result?["session"] as! [String:AnyObject]
                self.sessionID = session["id"] as? String
                
                let account = result?["account"] as! [String:AnyObject]
                self.userID = (account["key"] as? String)!
                
                completionhandlerforSession(true,self.sessionID,self.userID,nil)
            }
        }
    }
    
    func getuserData()
    {
        let updatedMethod = UdacityClient.Methods.getuserID.replacingOccurrences(of: "id", with: "\(self.userID)")
        taskforGETMethod(updatedMethod){ (success, error) in
            if success!
            {
                print("Success in getting user name and last name")
            }
            else
            {
                print("Error in getting user name and last name")
            }
    }
    }
    
}
