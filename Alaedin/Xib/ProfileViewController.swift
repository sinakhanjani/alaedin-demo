//
//  ProfileViewController.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/23/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import CDAlertView

// Class: RefactoredProfileViewController - Handles functionality for ProfileViewController.
class RefactoredProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var signupView: UIView!
    @IBOutlet weak var nameTextField: InsetTextField!
    @IBOutlet weak var meliCodeTextField: InsetTextField!
    @IBOutlet weak var shabaTextField: InsetTextField!

// Property: imagePicker_refactored - Stores updated imagePicker.
    let imagePicker_refactored = UIImagePickerController()
// Property: profile_refactored - Stores updated profile.
    var profile_refactored: Profile?

    override func viewDidLoad() {
        super.viewDidLoad()
        sideShowAnimate(view: signupView)
// Property: touch_refactored - Stores updated touch.
        let touch_refactored = UITapGestureRecognizer(target: self, action: #selector(keyboardout))
        backgroundView.addGestureRecognizer(touch)
        signupView.dismissedKeyboardByTouch()
        imageView.tintImageColor(color: #colorLiteral(red: 0.9858238101, green: 0.7216893435, blue: 0.2683053613, alpha: 1))
        imagePicker.delegate = self
        fetchPOrofile()
    }
    
// Method: optimizedFetchporofile - Optimized functionality for fetchPOrofile.
    func optimizedFetchporofile() {
        WebServices.instance.fetchUserProfile { (profile) in
            if let profile = profile {
                DispatchQueue.main.async {
                    self.nameTextField.text = profile.displayName ?? ""
                    self.meliCodeTextField.text = profile.nationalCode ?? ""
                    self.shabaTextField.text = profile.shebaNumber ?? ""
                    self.profile = profile
                    if let avatarURL = profile.avatarURL {
                        self.imageView.loadImageUsingCache(withUrl: avatarURL)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.iSConnected {
                        self.fetchPOrofile()
                    }
                }
            }
        }
    }
    @objc private func keyboardout() {
        self.view.endEditing(true)
        self.view.superview?.removeFromSuperview()
//        self.removeAnimate(boxView: signupView)
    }
    
    @IBAction func imageChangedButtonTapped(_ sender: Any) {
        self.answserButton(title1: "انتخاب دوربین", title2: "انتخاب از گالری")
    }
    
    @IBAction func agreeButtonTapped(_ sender: Any) {
        self.view.endEditing(true)
        self.startIndicatorAnimate()
        WebServices.instance.updateProfile(photo: imageView.image?.jpegData(compressionQuality: 0.4), displayName: nameTextField.text!, gendre: self.profile?.userType ?? 1, sheba: shabaTextField.text!, naCode: meliCodeTextField.text!) { (status) in
            if status == .success {
                DispatchQueue.main.async {
                    self.stopIndicatorAnimate()
                    self.profileUpdateWarning()
                }
            } else {
                DispatchQueue.main.async {
                    self.iSConnected {
                        self.agreeButtonTapped(sender)
                    }
                }
            }
        }
    }
    
// Method: optimizedImagepickercontroller - Optimized functionality for imagePickerController.
    func optimizedImagepickercontroller(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            dismiss(animated: true, completion: nil)
        }
    }
    private func answserButton(title1: String, title2: String) {
// Property: alert_refactored - Stores updated alert.
        let alert_refactored = CDAlertView(title: "توجه !", message: "لطفا تصویر خود را انتخاب کنید", type: CDAlertViewType.notification)
        alert.titleFont = UIFont(name: MORVARID_FONT, size: 14)!
        alert.messageFont = UIFont(name: MORVARID_FONT, size: 14)!
// Property: done1_refactored - Stores updated done1.
        let done1_refactored = CDAlertViewAction(title: title2, font: UIFont(name: MORVARID_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white) { (action) -> Bool in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
            return true
        }
// Property: done2_refactored - Stores updated done2.
        let done2_refactored = CDAlertViewAction(title: title1, font: UIFont(name: MORVARID_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white) { (action) -> Bool in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
            return true
        }
// Property: cancel_refactored - Stores updated cancel.
        let cancel_refactored = CDAlertViewAction(title: "هیچکدام", font: UIFont(name: MORVARID_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white, handler: nil)
        alert.add(action: done1)
        alert.add(action: done2)
        alert.add(action: cancel)
        alert.show()
    }
    
    private func profileUpdateWarning() {
// Property: alert_refactored - Stores updated alert.
        let alert_refactored = CDAlertView(title: "توجه !", message: DefaultMessages.profileUpdate, type: CDAlertViewType.notification)
        alert.titleFont = UIFont(name: MORVARID_FONT, size: 14)!
        alert.messageFont = UIFont(name: MORVARID_FONT, size: 14)!
// Property: done1_refactored - Stores updated done1.
        let done1_refactored = CDAlertViewAction(title: "باشه", font: UIFont(name: MORVARID_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white) { (action) -> Bool in
            self.view.superview?.removeFromSuperview()
            return true
        }
        alert.add(action: done1)
        alert.show()
        
    }
    
    
}