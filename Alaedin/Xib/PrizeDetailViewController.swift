//
//  PrizeDetailViewController.swift
//  Alaedin
//
//  Created by Teodik Abrami on 1/13/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import UIKit

protocol PrizeDetailViewControllerDelegate {
    func cancelButtonTapped()
}

class PrizeDetailViewController: UIViewController {

    @IBOutlet weak var prizeNameLabel: UILabel!
    @IBOutlet weak var prizePercentLabel: UILabel!
    @IBOutlet weak var staticCancelLabel: UILabel!
    @IBOutlet weak var cancelPriceLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var bckView: UIView!
    @IBOutlet weak var inView: UIView!
    
    var prizeDetail: PrizeDetail?
    var delegate: PrizeDetailViewControllerDelegate?
    
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
        let touch = UITapGestureRecognizer(target: self, action: #selector(keyboardout))
        bckView.addGestureRecognizer(touch)
        
    }

    @objc private func keyboardout() {
        self.removeAnimate(boxView: inView)
    }
    
    @IBAction func invitationButtonPressed(_ sender: Any) {
        let image = UIImage.init(named: "share")!
        fetchShare()
    }
    
    func fetchShare() {
        WebServices.instance.fetchShare { (data) in
            if let data = data {
                DispatchQueue.main.async {
                    let image = UIImage.init(named: "share")!
                    let wishId = self.prizeDetail?.wishId ?? ""
                    let activityController = UIActivityViewController(activityItems: [image,data.caption.replacingOccurrences(of: "@wishid", with: wishId)], applicationActivities: nil)
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
    
    func cancelWih() {
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
    var status: Int
    var percent, name: String
    var priceToPay: String
    var wishId: String
}
