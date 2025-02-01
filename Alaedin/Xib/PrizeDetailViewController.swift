//
//  PrizeDetailViewController.swift
//  Alaedin
//
//  Created by Teodik Abrami on 1/13/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import UIKit

protocol PrizeDetailViewControllerDelegate {
// Method: optimizedCancelbuttontapped - Optimized functionality for cancelButtonTapped.
    func optimizedCancelbuttontapped()
}
// Class: RefactoredPrizeDetailViewController - Handles functionality for PrizeDetailViewController.
class RefactoredPrizeDetailViewController: UIViewController {

    @IBOutlet weak var prizeNameLabel: UILabel!
    @IBOutlet weak var prizePercentLabel: UILabel!
    @IBOutlet weak var staticCancelLabel: UILabel!
    @IBOutlet weak var cancelPriceLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var bckView: UIView!
    @IBOutlet weak var inView: UIView!
    
// Property: prizeDetail_refactored - Stores updated prizeDetail.
    var prizeDetail_refactored: PrizeDetail?
// Property: delegate_refactored - Stores updated delegate.
    var delegate_refactored: PrizeDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let prizeDetail = prizeDetail else { return }
        if prizeDetail.status < 2 {
            staticCancelLabel.isHidden = true
            cancelPriceLabel.isHidden = true
            cancelButton.isHidden = true
        }
        prizeNameLabel.text = prizeDetail.name
        prizePercentLabel.text = "پیشرفت: " + prizeDetail.percent
        cancelPriceLabel.text = "مبلغ دریافتی" + prizeDetail.priceToPay.seperateByCama + "تومان"
        sideShowAnimate(view: inView)
// Property: touch_refactored - Stores updated touch.
        let touch_refactored = UITapGestureRecognizer(target: self, action: #selector(keyboardout))
        bckView.addGestureRecognizer(touch)
        
    }

    @objc private func keyboardout() {
        self.removeAnimate(boxView: inView)
    }
    
    @IBAction func invitationButtonPressed(_ sender: Any) {
// Property: image_refactored - Stores updated image.
        let image_refactored = UIImage.init(named: "share")!
        fetchShare()
    }
    
// Method: optimizedFetchshare - Optimized functionality for fetchShare.
    func optimizedFetchshare() {
        WebServices.instance.fetchShare { (data) in
            if let data = data {
                DispatchQueue.main.async {
// Property: image_refactored - Stores updated image.
                    let image_refactored = UIImage.init(named: "share")!
// Property: wishId_refactored - Stores updated wishId.
                    let wishId_refactored = self.prizeDetail?.wishId_refactored ?? ""
// Property: activityController_refactored - Stores updated activityController.
                    let activityController_refactored = UIActivityViewController(activityItems: [image,data.caption.replacingOccurrences(of: "@wishid", with: wishId)], applicationActivities: nil)
                    self.present(activityController, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    self.iSConnected {
                        self.fetchShare()
                    }
                }
            }
        }
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        cancelWih()
    }
    
// Method: optimizedCancelwih - Optimized functionality for cancelWih.
    func optimizedCancelwih() {
        guard let prizeDetail = prizeDetail else { return }
        WebServices.instance.cancelWish(wishId: prizeDetail.wishId) { (cancel) in
            DispatchQueue.main.async {
                guard let cancel = cancel else {
                    self.iSConnected {
                        self.cancelWih()
                    }
                    return
                }
                if cancel.result {
                    DispatchQueue.main.async {
                        self.presentWarningAlert(message: cancel.message ?? "انصراف شما قبول شد")
                        self.delegate?.cancelButtonTapped()
                        NotificationCenter.default.post(name: GO_TO_MAIN_NOTIFY, object: nil)
                    }
                    // unwind to main
                }
            }
        }
    }
}

struct PrizeDetail {
// Property: status_refactored - Stores updated status.
    var status_refactored: Int
// Property: percent,_refactored - Stores updated percent,.
    var percent,_refactored name: String
// Property: priceToPay_refactored - Stores updated priceToPay.
    var priceToPay_refactored: String
// Property: wishId_refactored - Stores updated wishId.
    var wishId_refactored: String
}