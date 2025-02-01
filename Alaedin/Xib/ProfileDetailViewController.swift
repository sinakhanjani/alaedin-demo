//
//  ProfileDetailViewController.swift
//  Alaedin
//
//  Created by Teodik Abrami on 1/13/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import UIKit

class ProfileDetailViewController: UIViewController {


    @IBOutlet weak var inviterLabel: UILabel!
    @IBOutlet weak var wishProgressLabel: UILabel!
    @IBOutlet weak var sematLabel: UILabel!
    @IBOutlet weak var cdateLabel: UILabel!
    @IBOutlet weak var wishNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var bckView: UIView!
    @IBOutlet weak var inView: UIView!
    
    var profileDetail: ProfileDetail?
    
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
        let touch = UITapGestureRecognizer(target: self, action: #selector(keyboardout))
        bckView.addGestureRecognizer(touch)
    }
    
    func semat(semat: String) -> String {
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
    
    func fetchShare() {
        WebServices.instance.fetchShare { (data) in
            if let data = data {
                DispatchQueue.main.async {
                    let image = UIImage.init(named: "share")!
                    let wishId = self.profileDetail?.wishId ?? ""
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
    
}

struct ProfileDetail {
    var wishProgress, inviter, semat, cdate, wishName, name, progress, wishId, avatar: String

}
