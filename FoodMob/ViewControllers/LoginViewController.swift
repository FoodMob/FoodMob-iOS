//
//  LoginViewController.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/5/16.
//  Copyright © 2016 Jonathan Jemson. All rights reserved.
//

import UIKit

/**
 Segues from Login View Controller to other controllers
 */
enum LoginViewControllerSegue: String {
    case ToSearchSegue = "loginToSearchSegue"
    case ToRegisterSegue = "loginToRegisterSegue"
}

class LoginViewController: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    // MARK: - Model Elements
    private var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if let segue = LoginViewControllerSegue(rawValue: identifier) {
            if segue == .ToSearchSegue {
                self.currentUser = FoodMob.currentDataProvider.login(emailAddressField.safeText, password: passwordField.safeText)
                if self.currentUser == nil {
                    let alert = UIAlertController(title: "Login Failed", message: "Check your email address and password, and try again.", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    return false;
                }
            }
        }
        return true
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    @IBAction func unwindToLoginViewController(segue: UIStoryboardSegue) {
        
    }

}
