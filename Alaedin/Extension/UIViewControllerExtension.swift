//
//  UIViewControllerExtension.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/21/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import AVFoundation
import CDAlertView
import MaterialShowcase
import AVKit

extension UIViewController {
    
    func loginSituation() {
        if Authorization.shared.isLoggedIn {
            //
        } else {
            //
        }
    }
    
}

extension UIViewController {
    
    func backBarButtonAttribute(color: UIColor, name: String) {
        let backButton = UIBarButtonItem(title: name, style: UIBarButtonItem.Style.plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.persianFont(size: 15)], for: .normal)
        backButton.tintColor = color
        navigationItem.backBarButtonItem = backButton
    }
    
}

// MENU ANIMATION
extension UIViewController {
    
    func showAnimate() {
        self.view.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 1.4) {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform.identity
        }
    }
    
    func removeAnimate(boxView: UIView? = nil) {
        if let boxView = boxView {
            self.sideHideAnimate(view: boxView)
        }
        UIView.animate(withDuration: 1.4, animations: {
            self.view.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            self.view.alpha = 0.0
        }) { (finished) in
            if finished {
                self.view.removeFromSuperview()
            }
        }
    }
    
    func sideShowAnimate(view: UIView) {
        view.transform = CGAffineTransform.init(translationX: UIScreen.main.bounds.width, y: 0)
        UIView.animate(withDuration: 1.4) {
            view.transform = CGAffineTransform.identity
        }
    }
    
    func sideHideAnimate(view: UIView) {
        UIView.animate(withDuration: 1.4, animations: {
            view.transform = CGAffineTransform.init(translationX: UIScreen.main.bounds.width, y: 0)
        }) { (finished) in
            if finished {
                //
            }
        }
    }
    
}

extension UIViewController {
    
    func presentMenuViewController() {
        let vc = MenuViewController()
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    func presentSignUpViewController() {
        let vc = SignUpViewController()
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    func presentConfirmViewController() {
        let vc = ConfirmViewController()
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    func presentRegisterUserViewController() {
        let vc = RegisterUserViewController()
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    func presentProfileViewController() {
        let vc = ProfileViewController()
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    func presentTicketViewController() {
        let vc = TicketViewController()
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    func presentWebViewController(url: URL) {
        let vc = WebViewController()
        vc.url = url
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    func presentGiftDetailViewController(product: Product) {
        let vc = GiftDetailViewController()
        vc.product = product
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    func presentProfileDetailViewController(profile: ProfileDetail) {
        let vc = ProfileDetailViewController()
        vc.profileDetail = profile
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    func presentPrizeDetailViewController(prize: PrizeDetail) {
        let vc = PrizeDetailViewController()
        vc.prizeDetail = prize
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    
}

extension UIViewController {
    
    func startIndicatorAnimate() {
        let vc = IndicatorViewController()
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    func stopIndicatorAnimate() {
        NotificationCenter.default.post(name: DISMISS_INDICATOR_VC_NOTIFY, object: nil)
    }
    
}

extension UIViewController {
    
    func presentWarningAlert(message: String) {
        let alert = CDAlertView(title: "توجه", message: message, type: CDAlertViewType.notification)
        alert.titleFont = UIFont(name: MORVARID_FONT, size: 15)!
        alert.messageFont = UIFont(name: MORVARID_FONT, size: 13)!
        let cancel = CDAlertViewAction(title: "باشه", font: UIFont(name: MORVARID_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white, handler: nil)
        alert.add(action: cancel)
        alert.show()
    }
    
    func presentCDAlertWarningAlert(message: String, completion: @escaping () -> Void) {
        let alert = CDAlertView(title: "توجه", message: message, type: CDAlertViewType.notification)
        alert.titleFont = UIFont(name: MORVARID_FONT, size: 15)!
        alert.messageFont = UIFont(name: MORVARID_FONT, size: 13)!
        let done = CDAlertViewAction.init(title: "باشه", font: UIFont(name: MORVARID_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white) { (alert) -> Bool in
            completion()
            return true
        }
        alert.add(action: done)
        alert.show()
    }
    
    func iSConnected(completion: @escaping () -> Void) {
        let alert = CDAlertView(title: "توجه", message: "ارتباط با سرور برقرار نشد !", type: CDAlertViewType.notification)
        alert.titleFont = UIFont(name: MORVARID_FONT, size: 15)!
        alert.messageFont = UIFont(name: MORVARID_FONT, size: 13)!
        let done = CDAlertViewAction.init(title: "تلاش مجدد", font: UIFont(name: MORVARID_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white) { (alert) -> Bool in
            completion()
            return true
        }
        alert.add(action: done)
        alert.show()
    }
    
    func phoneNumberCondition(phoneNumber number: String) -> Bool {
        guard !number.isEmpty else {
            let message = "شماره همراه خالی میباشد !"
            presentWarningAlert(message: message)
            return false
        }
        let startIndex = number.startIndex
        let zero = number[startIndex]
        guard zero == "0" else {
            let message = "شماره همراه خود را با صفر وارد کنید !"
            presentWarningAlert(message: message)
            return false
        }
        guard number.count == 11 else {
            let message = "شماره همراه میبایست یازده رقمی باشد !"
            presentWarningAlert(message: message)
            return false
        }
        
        return true
    }
    
}

extension UIViewController {
    //
}

extension UIViewController: MaterialShowcaseDelegate {
    func showCase(view: UIView, header: String, text: String) {
        let showcase = MaterialShowcase()
        showcase.setTargetView(view: view) // always required to set targetView
        let customColor = UIColor(red: 23/255.0, green: 25/255.0, blue: 112/255.0, alpha: 1.0)
        showcase.primaryTextAlignment = .right
        showcase.secondaryTextAlignment = .right
        showcase.targetHolderRadius = view.frame.height
        showcase.backgroundViewType = .circle
        showcase.backgroundPromptColor = customColor
        showcase.targetHolderColor = .clear
        showcase.primaryText = header
        showcase.secondaryText = text
        showcase.show(completion: {
            // You can save showcase state here
            // Later you can check and do not show it again
        })
        showcase.delegate = self
    }
    
}

