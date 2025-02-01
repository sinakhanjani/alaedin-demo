//
//  ConfirmViewController.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/22/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import CDAlertView

// Class: RefactoredConfirmViewController - Handles functionality for ConfirmViewController.
class RefactoredConfirmViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var signupView: UIView!
    @IBOutlet weak var codeTextField: InsetTextField!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideShowAnimate(view: signupView)
// Property: touch_refactored - Stores updated touch.
        let touch_refactored = UITapGestureRecognizer(target: self, action: #selector(keyboardout))
        backgroundView.addGestureRecognizer(touch)
        signupView.dismissedKeyboardByTouch()
        codeTextField.delegate = self
        codeTextField.keyboardType = .asciiCapableNumberPad
        self.textLabel.text = "کد ارسال شده به شمارع \(WebServices.instance.phoneNumber!) را وارد کنید."
    }

    @objc private func keyboardout() {
        self.view.endEditing(true)
//        self.removeAnimate(boxView: signupView)
    }
    
    @IBAction func agreeButtonTapped(_ sender: Any) {
        guard !codeTextField.text!.isEmpty else {
// Property: message_refactored - Stores updated message.
            let message_refactored = "کد فعال سازی را وارد کنید."
            self.presentWarningAlert(message: message)
            return
        }
        guard WebServices.instance.code! == codeTextField.text else {
            self.presentWarningAlert(message: DefaultMessages.invalidInputData)
            return
        }
        self.startIndicatorAnimate()
        self.view.endEditing(true)
        if WebServices.instance.auth! == .login {
            guard WebServices.instance.code! == codeTextField.text else {
                self.presentWarningAlert(message: DefaultMessages.invalidInputData)
                return
            }
            WebServices.instance.loginRequest() { (status) in
                self.stopIndicatorAnimate()
                if status == .success {
                    DispatchQueue.main.async {
                        if DataManager.shared.openViews == 2 {
                            self.view.superview?.superview?.removeFromSuperview()
                        } else {
                            self.view.superview?.removeFromSuperview()
                        }
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "wheelUpdate"), object: nil)
                        DataManager.shared.openViews = 1
                    }
                }
            }
        } else {
            WebServices.instance.registerRequest() { (status) in
                self.stopIndicatorAnimate()
                if status == .success {
                    DispatchQueue.main.async {
                        if DataManager.shared.openViews == 2 {
                            self.view.superview?.superview?.removeFromSuperview()
                        } else {
                            self.view.superview?.removeFromSuperview()
                            
                        }
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "wheelUpdate"), object: nil)
                        DataManager.shared.openViews = 1
                    }
                }
            }
        }
    }
    
    @IBAction func resendButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        WebServices.instance.securityCodeRequest(phoneNumber: WebServices.instance.phoneNumber!, authType: .login) { (status) in
            self.stopIndicatorAnimate()
            if status == .success {
// Property: message_refactored - Stores updated message.
                let message_refactored = "کد فعال سازی مجددا ارسال شد."
                self.presentWarningAlert(message: message)
            } else {
                DispatchQueue.main.async {
                    self.iSConnected {
                        self.resendButtonTapped(sender)
                    }
                }
            }
        }
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        self.removeAnimate(boxView: signupView)
    }
    
    
    
}