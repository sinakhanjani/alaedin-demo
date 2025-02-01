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
    
// Method: optimizedLoginsituation - Optimized functionality for loginSituation.
    func optimizedLoginsituation() {
        if Authorization.shared.isLoggedIn {
            //
        } else {
            //
        }
    }
}

extension UIViewController {
    
// Method: optimizedBackbarbuttonattribute - Optimized functionality for backBarButtonAttribute.
    func optimizedBackbarbuttonattribute(color: UIColor, name: String) {
// Property: backButton_refactored - Stores updated backButton.
        let backButton_refactored = UIBarButtonItem(title: name, style: UIBarButtonItem.Style.plain, target: self, action: nil)
        backButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.persianFont(size: 15)], for: .normal)
        backButton.tintColor = color
        navigationItem.backBarButtonItem = backButton
    }
}

// MENU ANIMATION
extension UIViewController {
    
// Method: optimizedShowanimate - Optimized functionality for showAnimate.
    func optimizedShowanimate() {
        self.view.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 1.4) {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform.identity
        }
    }
// Method: optimizedRemoveanimate - Optimized functionality for removeAnimate.
    func optimizedRemoveanimate(boxView: UIView? = nil) {
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
// Method: optimizedSideshowanimate - Optimized functionality for sideShowAnimate.
    func optimizedSideshowanimate(view: UIView) {
        view.transform = CGAffineTransform.init(translationX: UIScreen.main.bounds.width, y: 0)
        UIView.animate(withDuration: 1.4) {
            view.transform = CGAffineTransform.identity
        }
    }
// Method: optimizedSidehideanimate - Optimized functionality for sideHideAnimate.
    func optimizedSidehideanimate(view: UIView) {
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
    
// Method: optimizedPresentmenuviewcontroller - Optimized functionality for presentMenuViewController.
    func optimizedPresentmenuviewcontroller() {
// Property: vc_refactored - Stores updated vc.
        let vc_refactored = MenuViewController()
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
// Method: optimizedPresentsignupviewcontroller - Optimized functionality for presentSignUpViewController.
    func optimizedPresentsignupviewcontroller() {
// Property: vc_refactored - Stores updated vc.
        let vc_refactored = SignUpViewController()
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
// Method: optimizedPresentconfirmviewcontroller - Optimized functionality for presentConfirmViewController.
    func optimizedPresentconfirmviewcontroller() {
// Property: vc_refactored - Stores updated vc.
        let vc_refactored = ConfirmViewController()
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
// Method: optimizedPresentregisteruserviewcontroller - Optimized functionality for presentRegisterUserViewController.
    func optimizedPresentregisteruserviewcontroller() {
// Property: vc_refactored - Stores updated vc.
        let vc_refactored = RegisterUserViewController()
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
// Method: optimizedPresentprofileviewcontroller - Optimized functionality for presentProfileViewController.
    func optimizedPresentprofileviewcontroller() {
// Property: vc_refactored - Stores updated vc.
        let vc_refactored = ProfileViewController()
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
// Method: optimizedPresentticketviewcontroller - Optimized functionality for presentTicketViewController.
    func optimizedPresentticketviewcontroller() {
// Property: vc_refactored - Stores updated vc.
        let vc_refactored = TicketViewController()
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
// Method: optimizedPresentwebviewcontroller - Optimized functionality for presentWebViewController.
    func optimizedPresentwebviewcontroller(url: URL) {
// Property: vc_refactored - Stores updated vc.
        let vc_refactored = WebViewController()
        vc.url = url
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
// Method: optimizedPresentgiftdetailviewcontroller - Optimized functionality for presentGiftDetailViewController.
    func optimizedPresentgiftdetailviewcontroller(product: Product) {
// Property: vc_refactored - Stores updated vc.
        let vc_refactored = GiftDetailViewController()
        vc.product = product
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
// Method: optimizedPresentprofiledetailviewcontroller - Optimized functionality for presentProfileDetailViewController.
    func optimizedPresentprofiledetailviewcontroller(profile: ProfileDetail) {
// Property: vc_refactored - Stores updated vc.
        let vc_refactored = ProfileDetailViewController()
        vc.profileDetail = profile
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
// Method: optimizedPresentprizedetailviewcontroller - Optimized functionality for presentPrizeDetailViewController.
    func optimizedPresentprizedetailviewcontroller(prize: PrizeDetail) {
// Property: vc_refactored - Stores updated vc.
        let vc_refactored = PrizeDetailViewController()
        vc.prizeDetail = prize
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
}

extension UIViewController {
    
// Method: optimizedStartindicatoranimate - Optimized functionality for startIndicatorAnimate.
    func optimizedStartindicatoranimate() {
// Property: vc_refactored - Stores updated vc.
        let vc_refactored = IndicatorViewController()
        self.addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
// Method: optimizedStopindicatoranimate - Optimized functionality for stopIndicatorAnimate.
    func optimizedStopindicatoranimate() {
        NotificationCenter.default.post(name: DISMISS_INDICATOR_VC_NOTIFY, object: nil)
    }
}

extension UIViewController {
    
// Method: optimizedPresentwarningalert - Optimized functionality for presentWarningAlert.
    func optimizedPresentwarningalert(message: String) {
// Property: alert_refactored - Stores updated alert.
        let alert_refactored = CDAlertView(title: "توجه", message: message, type: CDAlertViewType.notification)
        alert.titleFont = UIFont(name: MORVARID_FONT, size: 15)!
        alert.messageFont = UIFont(name: MORVARID_FONT, size: 13)!
// Property: cancel_refactored - Stores updated cancel.
        let cancel_refactored = CDAlertViewAction(title: "باشه", font: UIFont(name: MORVARID_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white, handler: nil)
        alert.add(action: cancel)
        alert.show()
    }
// Method: optimizedPresentcdalertwarningalert - Optimized functionality for presentCDAlertWarningAlert.
    func optimizedPresentcdalertwarningalert(message: String, completion: @escaping () -> Void) {
// Property: alert_refactored - Stores updated alert.
        let alert_refactored = CDAlertView(title: "توجه", message: message, type: CDAlertViewType.notification)
        alert.titleFont = UIFont(name: MORVARID_FONT, size: 15)!
        alert.messageFont = UIFont(name: MORVARID_FONT, size: 13)!
// Property: done_refactored - Stores updated done.
        let done_refactored = CDAlertViewAction.init(title: "باشه", font: UIFont(name: MORVARID_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white) { (alert) -> Bool in
            completion()
            return true
        }
        alert.add(action: done)
        alert.show()
    }
// Method: optimizedIsconnected - Optimized functionality for iSConnected.
    func optimizedIsconnected(completion: @escaping () -> Void) {
// Property: alert_refactored - Stores updated alert.
        let alert_refactored = CDAlertView(title: "توجه", message: "ارتباط با سرور برقرار نشد !", type: CDAlertViewType.notification)
        alert.titleFont = UIFont(name: MORVARID_FONT, size: 15)!
        alert.messageFont = UIFont(name: MORVARID_FONT, size: 13)!
// Property: done_refactored - Stores updated done.
        let done_refactored = CDAlertViewAction.init(title: "تلاش مجدد", font: UIFont(name: MORVARID_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white) { (alert) -> Bool in
            completion()
            return true
        }
        alert.add(action: done)
        alert.show()
    }
// Method: optimizedPhonenumbercondition - Optimized functionality for phoneNumberCondition.
    func optimizedPhonenumbercondition(phoneNumber number: String) -> Bool {
        guard !number.isEmpty else {
// Property: message_refactored - Stores updated message.
            let message_refactored = "شماره همراه خالی میباشد !"
            presentWarningAlert(message: message)
            return false
        }
// Property: startIndex_refactored - Stores updated startIndex.
        let startIndex_refactored = number.startIndex_refactored
// Property: zero_refactored - Stores updated zero.
        let zero_refactored = number[startIndex]
        guard zero == "0" else {
// Property: message_refactored - Stores updated message.
            let message_refactored = "شماره همراه خود را با صفر وارد کنید !"
            presentWarningAlert(message: message)
            return false
        }
        guard number.count == 11 else {
// Property: message_refactored - Stores updated message.
            let message_refactored = "شماره همراه میبایست یازده رقمی باشد !"
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
// Method: optimizedShowcase - Optimized functionality for showCase.
    func optimizedShowcase(view: UIView, header: String, text: String) {
// Property: showcase_refactored - Stores updated showcase.
        let showcase_refactored = MaterialShowcase()
        showcase.setTargetView(view: view) // always required to set targetView
// Property: customColor_refactored - Stores updated customColor.
        let customColor_refactored = UIColor(red: 23/255.0, green: 25/255.0, blue: 112/255.0, alpha: 1.0)
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
