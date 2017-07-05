//
// LoginViewController.swift
//  On The Map
//
//  Created by Pinak Jalan on 7/1/17.
//  Copyright © 2017 Pinak Jalan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var appDelegate:AppDelegate!
    @IBOutlet var password:UITextField!
    @IBOutlet var username:UITextField!
    var activeTextField:UITextField!
    var keyboardOnScreen = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.password.delegate = self
        self.username.delegate = self
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.handleTap(_:)))
        self.view.addGestureRecognizer(gestureRecognizer)
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToNotification(.UIKeyboardWillShow, #selector(keyboardWillShow))
        subscribeToNotification(.UIKeyboardDidShow, #selector(keyboardDidShow))
        subscribeToNotification(.UIKeyboardDidHide, #selector(keyboardDidHide))
        subscribeToNotification(.UIKeyboardWillHide, #selector(keyboardWillHide))

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromAllNotifications()
    }
    
    @IBAction func isSignUpPressed()
    {
        let url = URL(string : "https://www.udacity.com/account/auth#!/signup")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        
    }
    
    private func completeLogin()
    {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func isSignInPressed()
    {
        //Authentciate with view controller etc
        if((username.text?.characters.count)! > 0 && (password.text?.characters.count)! > 0 )
        {
            
            
            let parameters: [String: [String: AnyObject]] = [UdacityClient.Constants.udacity : [
                UdacityClient.Constants.username: username.text as AnyObject,
                UdacityClient.Constants.password: password.text as AnyObject
                ]]
            UdacityClient.sharedInstance().authenticateWithViewController(LoginViewController(), userCreds: parameters){ (success,errorString) in
                
                performUIUpdatesOnMain {
                
                if success
                {
                    self.completeLogin()
                }
                else
                {
                    print("Error cannot go through!")
                }
                }
            }
        }
        
    }
}

extension LoginViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func handleTap(_ gestureRecognizer: UITapGestureRecognizer)
    {
        if(keyboardOnScreen)
        {
            //print("Screen tapped while keyboard on screen")
            self.resignIfFirstResponder()
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
    
    func resignIfFirstResponder()
    {
        activeTextField.resignFirstResponder()
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.activeTextField = textField
    }
    
    func keyboardWillShow(_ notification: Notification)
    {
        if(!keyboardOnScreen)
        {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardDidShow(_ notification: Notification)
    {
        keyboardOnScreen = true
    }
    
    func keyboardDidHide(_ notification:Notification)
    {
        keyboardOnScreen = false
    }
    
    func keyboardWillHide(_ notification:Notification)
    {
        if keyboardOnScreen
        {
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat
    {
        let userInfo = notification.userInfo!
        let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardHeight.cgRectValue.height
    }
}
private extension LoginViewController{
    
    func subscribeToNotification(_ notification:Notification.Name , _ selector: Selector)
    {
        NotificationCenter.default.addObserver(self, selector:selector, name:notification, object:nil)
    }
    
    func unsubscribeFromAllNotifications()
    {
        NotificationCenter.default.removeObserver(self)
    }
}

