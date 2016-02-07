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
    case ToMainSegue = "loginToMainSegue"
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
        return true
    }
    
    @IBAction func loginButtonPressed(sender: UIButton) {
        FoodMob.currentDataProvider.login(emailAddressField.safeText, password: passwordField.safeText) { [unowned self] (user) -> () in
            if let user = user {
                self.currentUser = user
                self.performSegueWithIdentifier(LoginViewControllerSegue.ToMainSegue.rawValue, sender: nil)
            } else {
                self.alert("Log In Failed", message: "Check your email address and password, and try again.")
            }
        }
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
        if let registrationController = segue.sourceViewController as? RegistrationViewController {
            self.emailAddressField.text = registrationController.emailAddressField.text
            self.passwordField.text = registrationController.passwordField.text
        }
    }
    

}
