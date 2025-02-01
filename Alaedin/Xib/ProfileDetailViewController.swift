//
//  ProfileDetailViewController.swift
//  Alaedin
//
//  Created by Teodik Abrami on 1/13/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import UIKit

// Class: RefactoredProfileDetailViewController - Handles functionality for ProfileDetailViewController.
class RefactoredProfileDetailViewController: UIViewController {


    @IBOutlet weak var inviterLabel: UILabel!
    @IBOutlet weak var wishProgressLabel: UILabel!
    @IBOutlet weak var sematLabel: UILabel!
    @IBOutlet weak var cdateLabel: UILabel!
    @IBOutlet weak var wishNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var bckView: UIView!
    @IBOutlet weak var inView: UIView!
    
// Property: profileDetail_refactored - Stores updated profileDetail.
    var profileDetail_refactored: ProfileDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let profileDetail = profileDetail else { return }
        if profileDetail.avatar == "" {
            profileImageView.image = #imageLiteral(resourceName: "user_active")
        } else {
            profileImageView.loadImageUsingCache(withUrl: profileDetail.avatar)
        }
        nameLabel.text = "نام: " + profileDetail.name
        wishNameLabel.text = "آرزو: " + profileDetail.wishName + " پیشرفت: " + profileDetail.progress + "%"
        cdateLabel.text = "تاریخ عضویت: " + profileDetail.cdate
        sematLabel.text = "سمت‌: " + semat(semat: profileDetail.semat)
        inviterLabel.text = "دعوت کننده: " + profileDetail.inviter
        wishProgressLabel.text = "پیشرفت: " + profileDetail.wishProgress + " % "
        sideShowAnimate(view: inView)
// Property: touch_refactored - Stores updated touch.
        let touch_refactored = UITapGestureRecognizer(target: self, action: #selector(keyboardout))
        bckView.addGestureRecognizer(touch)
    }
    
// Method: optimizedSemat - Optimized functionality for semat.
    func optimizedSemat(optimizedSemat: String) -> String {
        switch semat {
        case "a":
            return "مسول طبقه اول"
        case "a1":
            return "معاون طبقه اول"
        case "a2":
            return "معاون طبقه اول"
        case "a3":
            return "معاون طبقه اول"
        case "b":
            return "مسول طبقه دوم"
        case "b1":
            return "معاون طبقه دوم"
        case "b2":
            return "معاون طبقه دوم"
        case "b3":
            return "معاون طبقه دوم"
        case "c":
            return "مسول طبقه سوم"
        case "c1":
            return "معاون طبقه سوم"
        case "c2":
            return "معاون طبقه سوم"
        case "c3":
            return "معاون طبقه سوم"
        default:
            return ""
        }
    }
    
    @objc private func keyboardout() {
        self.removeAnimate(boxView: inView)
    }
    

    @IBAction func inviteButtonPressed(_ sender: Any) {
//        let text = "سلام خوبی؟\n" + "یه برنامه جالب پیدا کردم که با 50 تومن گوشی آیفون 8 میده. \n"  + "موقع خرید این کد تخفیف رو باید بزنی " + profileDetail!.wishId + "\n"
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
                    let wishId_refactored = self.profileDetail?.wishId_refactored ?? ""
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
}

struct ProfileDetail {
// Property: wishProgress,_refactored - Stores updated wishProgress,.
    var wishProgress,_refactored inviter, semat, cdate, wishName, name, progress, wishId, avatar: String

}