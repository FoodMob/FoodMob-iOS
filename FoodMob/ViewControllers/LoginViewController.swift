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

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - UI Elements
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    private var tapRecognizer = UITapGestureRecognizer()
    
    private var keyboardShowing = false
    
    
    @IBOutlet var controls: [UIControl]!
    
    private var dispatchToken: dispatch_once_t = 0
    
    // MARK: - Model Elements
    private var currentUser: User?
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        emailAddressField.delegate = self
        passwordField.delegate = self
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        tapRecognizer.addTarget(self, action: #selector(LoginViewController.hideKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func hideKeyboard() {
        self.emailAddressField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        keyboardShowing = false
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        dispatch_once(&dispatchToken) { [weak self] in
            self?.currentUser = User(emailAddress: nil)
            if self?.currentUser != nil {
                self?.performSegueWithIdentifier(LoginViewControllerSegue.ToMainSegue.rawValue, sender: nil)
                Session.sharedSession.currentUser = self?.currentUser
            }
        }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Text Field and Keyboard Management
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case emailAddressField:
            passwordField.becomeFirstResponder()
        default:
            loginButtonPressed(UIButton())
            textField.resignFirstResponder()
        }
        return true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        guard keyboardShowing == false else { return }
        if let userInfo = notification.userInfo, keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            bottomLayoutConstraint.constant = keyboardSize.height + CGFloat(20)
            self.view.layoutIfNeeded()
            keyboardShowing = true
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        bottomLayoutConstraint.constant = 0
        keyboardShowing = false
        self.view.layoutIfNeeded()
    }


    
    // MARK: - Navigation
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return true
    }
    
    @IBAction func loginButtonPressed(sender: UIButton) {
        controls.forEach { (control) in
            control.enabled = false
        }
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        FoodMob.currentDataProvider.login(emailAddressField.safeText, password: passwordField.safeText) { [unowned self] (user) -> () in
            if let user = user {
                self.currentUser = user
                Session.sharedSession.currentUser = user
                self.performSegueWithIdentifier(LoginViewControllerSegue.ToMainSegue.rawValue, sender: nil)
            } else {
                self.alert("Log In Failed", message: "Check your email address and password, and try again.")
            }
            self.controls.forEach({ (control) in
                control.enabled = true
            })
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
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
