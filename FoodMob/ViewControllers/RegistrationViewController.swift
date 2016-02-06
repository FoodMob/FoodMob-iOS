//
//  RegistrationViewController.swift
//  FoodMob
//
//  Created by Jonathan Jemson on 2/6/16.
//  Copyright © 2016 FoodMob. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var verifyPasswordField: UITextField!
    
    @IBOutlet var fields: [UITextField]!
    
    private var keyboardHeight: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        fields.forEach { (field) -> () in
            field.delegate = self
        }
        verifyPasswordField.removeFromSuperview()
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
            self.animateTextField(true)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.animateTextField(false)
    }
    
    func animateTextField(up: Bool) {
        let delta = (up ? -keyboardHeight : keyboardHeight)
        UIView.animateWithDuration(0.3) { () -> Void in
            self.view.frame = CGRectOffset(self.view.frame, 0, delta)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}
