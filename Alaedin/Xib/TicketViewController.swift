//
//  TicketViewController.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/23/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

class TicketViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var signupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.delegate = self
        titleTextField.delegate = self
        contentTextView.font = UIFont.persianFont(size: 17)
        self.signupView.dismissedKeyboardByTouch()
         sideShowAnimate(view: signupView)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    @IBAction func agreeButtonTapped(_ sender: Any) {
        guard titleTextField.text != "عنوان" && !contentTextView.text.isEmpty else {
            let message = "اطلاعات را کامل پر کنید."
            self.presentWarningAlert(message: message)
            return
        }
        self.view.endEditing(true)
        sendTicket()
      }
    
    func sendTicket() {
        self.startIndicatorAnimate()
        WebServices.instance.sentTicketRequest(title: titleTextField.text!, content: contentTextView.text!) { (status) in
            if status == .success {
                DispatchQueue.main.async {
                    self.stopIndicatorAnimate()
                    self.view.superview?.removeFromSuperview()
                }
            } else {
                DispatchQueue.main.async {
                    self.iSConnected {
                        self.sendTicket()
                    }
                }
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        self.view.superview?.removeFromSuperview()
    }
    
}
