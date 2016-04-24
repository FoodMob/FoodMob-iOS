//
//  RegistrationViewController.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/6/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import UIKit

enum RegistrationViewControllerSegue: String {
    case ToLoginSegueCancelled = "registrationToLoginSegueCancelled"
    case ToLoginSegueSignedUp = "registrationToLoginSegueSignedUp"
}

class RegistrationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet var fields: [UITextField]!
    
    private var keyboardHeight: CGFloat = 0.0
    @IBOutlet weak var textFieldStack: UIStackView!
    private var activeTextField: UITextField?
    private var keyboardShowing = false
    private var tapRecognizer = UITapGestureRecognizer()


    @IBOutlet weak var stackViewToBottomConstraint: NSLayoutConstraint!
    
    internal var userDictionary: [String: String]?

    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fields.forEach { (field) -> () in
            field.delegate = self
        }
        if let userDictionary = userDictionary {
            self.emailAddressField.text = userDictionary["username"]
            self.passwordField.text = userDictionary["password"]
        }
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        tapRecognizer.addTarget(self, action: #selector(RegistrationViewController.hideKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func hideKeyboard() {
        for field in fields {
            field.resignFirstResponder()
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RegistrationViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RegistrationViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.firstNameField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
        self.activeTextField?.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Text Field and Keyboard Management
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.activeTextField = textField
        return true
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch textField {
        case firstNameField:
            lastNameField.becomeFirstResponder()
        case lastNameField:
            emailAddressField.becomeFirstResponder()
        case emailAddressField:
            passwordField.becomeFirstResponder()
        default:
            signUpButtonPressed(UIButton())
            textField.resignFirstResponder()
        }
        return true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        guard keyboardShowing == false else { return }
        if let userInfo = notification.userInfo, keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            keyboardHeight = keyboardSize.height
            if (activeTextField?.tag ?? 0 >= 2) {
                stackViewToBottomConstraint.constant = keyboardSize.height + CGFloat(20)
            }
            self.view.layoutIfNeeded()
            keyboardShowing = true
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        stackViewToBottomConstraint.constant = 0
        keyboardShowing = false
        self.view.layoutIfNeeded()
    }

    // MARK: - Navigation
    
    @IBAction func signUpButtonPressed(sender: UIButton) {
        activeTextField?.resignFirstResponder()
        fields.forEach { (field) in
            field.enabled = false
        }
        sender.enabled = false
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        FoodMob.currentDataProvider.register(
            firstName: firstNameField.safeText,
            lastName: lastNameField.safeText,
            emailAddress: emailAddressField.safeText,
            password: passwordField.safeText,
            completion:  {
                [weak self] (success) -> () in
                if success {
                    self?.performSegueWithIdentifier(RegistrationViewControllerSegue.ToLoginSegueSignedUp.rawValue, sender: nil)
                } else {
                    self?.fields.forEach({ (field) in
                        field.enabled = true
                    })
                    sender.enabled = true
                    self?.alert("Sign Up Failed", message: "Please make sure you entered a valid email address and password.")
                }
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
        )
        
    }
    @IBAction func cancelButtonPressed(sender: UIButton) {
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return true
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
//        if let segueID = segue.identifier, segueName = RegistrationViewControllerSegue(rawValue: segueID) where segueName == .ToLoginSegueSignedUp {
//        }
    }

}
