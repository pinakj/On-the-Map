//
//  ParseConvenience.swift
//  On The Map
//
//  Created by Pinak Jalan on 7/3/17.
//  Copyright © 2017 Pinak Jalan. All rights reserved.
//

import Foundation
import UIKit


extension ParseClient{
    

    func getstudentLocations(completionhandlerforSession: @escaping (_ success: Bool, _ errorString: String?, _ studentData:[StudentLocation]?) -> Void)
    {
        
        ParseClient.sharedInstance().taskforGETMethod(ParseClient.Methods.studentLocation){(studentData, error, success) in
            
            if success!
            {
                self.studentInfo = studentData
                print("Success")
                completionhandlerforSession(true,nil, studentData)
            }
    }

    
}
}
