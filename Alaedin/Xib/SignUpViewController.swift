//
//  SignupViewController.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/22/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var bckView: UIView!
    
    @IBOutlet weak var phoneTextField: InsetTextField!
    
    @IBOutlet weak var inView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideShowAnimate(view: inView)
        let touch = UITapGestureRecognizer(target: self, action: #selector(keyboardout))
        bckView.addGestureRecognizer(touch)
        inView.dismissedKeyboardByTouch()
        phoneTextField.delegate = self
        phoneTextField.keyboardType = .asciiCapableNumberPad
    }


    @objc private func keyboardout() {
        self.view.endEditing(true)
        self.removeAnimate(boxView: inView)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard self.phoneNumberCondition(phoneNumber: phoneTextField.text!) else {
            return
        }
        self.view.endEditing(true)
        self.startIndicatorAnimate()
        
        WebServices.instance.securityCodeRequest(phoneNumber: phoneTextField.text!, authType: .login) { (status) in
            if status == .success {
                DispatchQueue.main.async {
                    self.stopIndicatorAnimate()
                    self.presentConfirmViewController()
                }
            } else if status == .register {
                DispatchQueue.main.async {
                    WebServices.instance.securityCodeRequest(phoneNumber: self.phoneTextField.text!, authType: .register, completion: { (status) in
                        if status == .success {
                            self.stopIndicatorAnimate()
                            DispatchQueue.main.async {
                                self.presentRegisterUserViewController()
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.stopIndicatorAnimate()
                                self.presentWarningAlert(message: DefaultMessages.invalidInputData)
                            }
                        }
                    })
                }
            } else {
                DispatchQueue.main.async {
                    self.stopIndicatorAnimate()
                    self.presentWarningAlert(message: DefaultMessages.invalidInputData)
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
