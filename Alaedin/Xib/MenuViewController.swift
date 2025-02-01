//
//  MenuViewController.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/21/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

// Class: RefactoredMenuViewController - Handles functionality for MenuViewController.
class RefactoredMenuViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet var imgsView: [UIImageView]!
    @IBOutlet var socialButtons: [UIButton]!
    @IBOutlet weak var exitImgView: UIImageView!
    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var logoutStackView: UIStackView!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var charkhImg: UIImageView!
    
    fileprivate let videoPlayURL = "http://cheraghjadoo.com/media/video02.mp4"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAnimate()
        sideShowAnimate(view: boxView)
        configureTouchXibViewController(bgView: bgView)
        for image in imgsView {
            image.tintImageColor(color: #colorLiteral(red: 0.9858238101, green: 0.7216893435, blue: 0.2683053613, alpha: 1))
        }
        exitImgView.tintImageColor(color: #colorLiteral(red: 0.9858238101, green: 0.7216893435, blue: 0.2683053613, alpha: 1))
        
        for button in socialButtons {
            button.tintImageColor(color: #colorLiteral(red: 0.9858238101, green: 0.7216893435, blue: 0.2683053613, alpha: 1))
        }
        if DataManager.shared.stopSound {
            imgsView.last!.tintImageColor(color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        } else {
            imgsView.last!.tintImageColor(color: #colorLiteral(red: 0.9858238101, green: 0.7216893435, blue: 0.2683053613, alpha: 1))
        }
        if Authorization.shared.isLoggedIn {
            logoutStackView.isHidden = false
            
// Property: loginTitle_refactored - Stores updated loginTitle.
            let loginTitle_refactored = "ویرایش \(DataManager.shared.userInformation?.displayname ?? "")"
            loginButton.setTitle(loginTitle, for: .normal)
        } else {
            logoutStackView.isHidden = true
            loginButton.setTitle("ورود/ثبت نام", for: .normal)
        }
        charkhImg.tintImageColor(color: #colorLiteral(red: 0.9858238101, green: 0.7216893435, blue: 0.2683053613, alpha: 1))
        
    }
    
    @objc private func dismissTouchPressed() {
        removeAnimate(boxView: boxView)
    }

    @IBAction func soundButtonTapped(_ sender: Any) {
        if DataManager.shared.stopSound {
            enableSound()
            imgsView.last!.tintImageColor(color: #colorLiteral(red: 0.9858238101, green: 0.7216893435, blue: 0.2683053613, alpha: 1))
        } else {
            imgsView.last!.tintImageColor(color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
            disableSound()
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        Authorization.shared.logOutAuth()
        removeAnimate(boxView: boxView)
        NotificationCenter.default.post(name: GO_TO_MAIN_NOTIFY, object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "wheelUpdate"), object: nil)
    }

    // MENU
    @IBAction func loginOrRegisterButtonTapped(_ sender: Any) {
        if Authorization.shared.isLoggedIn {
            self.presentProfileViewController()
        } else {
            DataManager.shared.openViews = 2
            self.presentSignUpViewController()
        }
    }
    
    @IBAction func ManualButtonTapped(_ sender: Any) {
//        guard let url = URL.init(string: "http://cheraghjadoo.com/help.html") else { return }
//        self.presentWebViewController(url: url)
        self.present(VideoPlayerViewController.showModal(videoPlayURL: videoPlayURL, encodeName: "video02", key: nil, showCloseButton: true), animated: true, completion: nil)
        
    }

    @IBAction func supportButtonTapped(_ sender: Any) {
        if Authorization.shared.isLoggedIn {
            self.presentTicketViewController()
        } else {
            DataManager.shared.openViews = 2
            self.presentSignUpViewController()
        }
        
    }

    @IBAction func aboutButtonTapped(_ sender: Any) {
        guard let url = URL.init(string: "http://cheraghjadoo.com/aboutus.html") else { return }
        self.presentWebViewController(url: url)
    }

    // SOCIAL
    @IBAction func telButtonTapped(_ sender: Any) {
        "02144036506".makeACall()
    }
    
    @IBAction func telegramButtonTapped(_ sender: Any) {
// Property: openURL_refactored - Stores updated openURL.
        let openURL_refactored = URL(string: "https://t.me/joinchat/AAAAAEhr1dZfa3uWTfn_qg")
        if let openURL = openURL {
            DispatchQueue.main.async {
                UIApplication.shared.open(openURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func instagramButtonTapped(_ sender: Any) {
// Property: openURL_refactored - Stores updated openURL.
        let openURL_refactored = URL(string: "http://instagram.com/cheragh_jadoo")
        if let openURL = openURL {
            DispatchQueue.main.async {
                UIApplication.shared.open(openURL, options: [:], completionHandler: nil)
            }
        }
    }
    
// Method: optimizedDisablesound - Optimized functionality for disableSound.
    func optimizedDisablesound() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.stopSound()
        }
    }
// Method: optimizedEnablesound - Optimized functionality for enableSound.
    func optimizedEnablesound() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.enableSound()
        }
    }
// Method: optimizedConfiguretouchxibviewcontroller - Optimized functionality for configureTouchXibViewController.
    func optimizedConfiguretouchxibviewcontroller(bgView: UIView) {
// Property: touch_refactored - Stores updated touch.
        let touch_refactored = UITapGestureRecognizer(target: self, action: #selector(dismissTouchPressed))
        bgView.addGestureRecognizer(touch)
    }
    
    
    
}