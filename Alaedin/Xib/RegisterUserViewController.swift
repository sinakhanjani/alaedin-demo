//
//  RegisterUserViewController.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/22/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

class RegisterUserViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var signupView: UIView!
    @IBOutlet weak var codeTextField: InsetTextField!
    @IBOutlet weak var nameTextField: InsetTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        sideShowAnimate(view: signupView)
        let touch = UITapGestureRecognizer(target: self, action: #selector(keyboardout))
        backgroundView.addGestureRecognizer(touch)
        signupView.dismissedKeyboardByTouch()
        codeTextField.delegate = self
        codeTextField.keyboardType = .asciiCapableNumberPad
        self.titleLabel.text = "کد ارسال شده به \(WebServices.instance.phoneNumber!) را وارد کنید"
    }

    @objc private func keyboardout() {
        self.view.endEditing(true)
        self.removeAnimate(boxView: signupView)
    }

    @IBAction func agreeButtonTapped(_ sender: Any) {
        guard !nameTextField.text!.isEmpty && !codeTextField.text!.isEmpty else {
            let message = "لطفا نام و نام خانوادگی خود را وارد کنید"
            self.presentWarningAlert(message: message)
            return
        }
        WebServices.instance.displayName = nameTextField.text!
        self.view.endEditing(true)
        self.startIndicatorAnimate()
        WebServices.instance.registerRequest { (status) in
            if status == .success {
                DispatchQueue.main.async {
                    self.stopIndicatorAnimate()
                    self.view.superview?.superview?.removeFromSuperview()
                }
            } else {
                DispatchQueue.main.async {
                    self.presentWarningAlert(message: DefaultMessages.invalidRegister)
                }
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        self.removeAnimate(boxView: signupView)
    }
    
    @IBAction func resendButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        WebServices.instance.securityCodeRequest(phoneNumber: WebServices.instance.phoneNumber!, authType: .register) { (status) in
            self.stopIndicatorAnimate()
            DispatchQueue.main.async {
                if status == .success {
                    let message = "کد فعال سازی مجددا ارسال شد."
                    self.presentWarningAlert(message: message)
                } else {
                    self.iSConnected {
                        self.resendButtonTapped(sender)
                    }
                }
            }

        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 11
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        
        return newString.length <= maxLength
    }
    
    
    
}
