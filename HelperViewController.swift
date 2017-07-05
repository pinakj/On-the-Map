//
//  HelperViewController.swift
//  On The Map
//
//  Created by Pinak Jalan on 7/4/17.
//  Copyright © 2017 Pinak Jalan. All rights reserved.
//

import UIKit

class HelperViewController: UIViewController {
    
    
    @IBOutlet var webView: UIWebView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func show(_ urlToShow:String)
    {
        print(urlToShow)
        let url = URL(string: urlToShow)
        let request = URLRequest(url: url!)
        webView?.loadRequest(request)
        //webView.loadRequest(URLRequest(url: URL(string: (urlToShow))!))

    }

    //Creating a singleton
    class func sharedInstance() -> HelperViewController {
        struct Singleton {
            static var sharedInstance = HelperViewController()
        }
        return Singleton.sharedInstance
    }

}
