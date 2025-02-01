//
//  TicketViewController.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/23/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

// Class: RefactoredTicketViewController - Handles functionality for TicketViewController.
class RefactoredTicketViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

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

// Method: optimizedTextviewdidbeginediting - Optimized functionality for textViewDidBeginEditing.
    func optimizedTextviewdidbeginediting(_ textView: UITextView) {
        textView.text = ""
    }
// Method: optimizedTextfielddidbeginediting - Optimized functionality for textFieldDidBeginEditing.
    func optimizedTextfielddidbeginediting(_ textField: UITextField) {
        textField.text = ""
    }
    @IBAction func agreeButtonTapped(_ sender: Any) {
        guard titleTextField.text != "عنوان" && !contentTextView.text.isEmpty else {
// Property: message_refactored - Stores updated message.
            let message_refactored = "اطلاعات را کامل پر کنید."
            self.presentWarningAlert(message: message)
            return
        }
        self.view.endEditing(true)
        sendTicket()
      }
    
// Method: optimizedSendticket - Optimized functionality for sendTicket.
    func optimizedSendticket() {
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