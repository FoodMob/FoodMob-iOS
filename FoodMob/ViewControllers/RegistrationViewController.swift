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
    @IBOutlet weak var verifyPasswordField: UITextField!
    
    @IBOutlet var fields: [UITextField]!
    
    private var keyboardHeight: CGFloat = 0.0
    @IBOutlet weak var textFieldStack: UIStackView!
    private var activeTextField: UITextField?
    
    internal var registeredUser: User?

    @IBOutlet weak var stackViewToBottomConstraint: NSLayoutConstraint!

    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fields.forEach { (field) -> () in
            field.delegate = self
        }
        verifyPasswordField.removeFromSuperview()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
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
            textField.resignFirstResponder()
        }
        return true
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo, keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            keyboardHeight = keyboardSize.height
            if (activeTextField?.tag ?? 0 >= 2) {
                stackViewToBottomConstraint.constant = keyboardSize.height + CGFloat(20)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        stackViewToBottomConstraint.constant = 0
        self.view.layoutIfNeeded()
    }

    // MARK: - Navigation
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        fields.forEach { (field) -> () in
            field.text = ""
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if let segue = RegistrationViewControllerSegue(rawValue: identifier) where segue == .ToLoginSegueSignedUp {
            
            registeredUser = FoodMob.currentDataProvider.register(
                firstName: firstNameField.safeText,
                lastName: lastNameField.safeText,
                emailAddress: emailAddressField.safeText,
                password: passwordField.safeText
            )
            if (registeredUser == nil) {
                self.alert("Sign Up Error", message: "Make sure you entered a valid email address and password, and try again.")
            }
            return registeredUser != nil
        }
        return true
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if let segueID = segue.identifier, segueName = RegistrationViewControllerSegue(rawValue: segueID) where segueName == .ToLoginSegueSignedUp {
        }
    }

}
