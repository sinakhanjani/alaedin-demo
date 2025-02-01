//
//  ViewController.swift
//  alladein
//
//  Created by Teodik Abrami on 1/9/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import UIKit
import QuartzCore
import MaterialShowcase


// Property: GO_TO_MAIN_NOTIFY_refactored - Stores updated GO_TO_MAIN_NOTIFY.
let GO_TO_MAIN_NOTIFY_refactored = Notification.Name("gotoMain")

// Class: RefactoredTowerViewController - Handles functionality for TowerViewController.
class RefactoredTowerViewController: UIViewController, CAAnimationDelegate {

    //Tower Outlets
    @IBOutlet weak var firstStageView: UIView!
    @IBOutlet weak var secondStageView: UIView!
    @IBOutlet weak var thirdStageView: UIView!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var prizeImageView: UIImageView!
    @IBOutlet weak var towerStackView: UIStackView!
    
    //First Stage Outlets
    @IBOutlet weak var aProfileImage: UIImageView!
    @IBOutlet weak var aloadingView: UIView!
    @IBOutlet weak var a1ProfileImage: UIImageView!
    @IBOutlet weak var a1loadingView: UIView!
    @IBOutlet weak var a2ProfileImage: UIImageView!
    @IBOutlet weak var a2loadingView: UIView!
    @IBOutlet weak var a3ProfileImage: UIImageView!
    @IBOutlet weak var a3loadingView: UIView!
    
    //Second Stage Outlets
    @IBOutlet weak var bProfileImage: UIImageView!
    @IBOutlet weak var bloadingView: UIView!
    @IBOutlet weak var b1ProfileImage: UIImageView!
    @IBOutlet weak var b1loadingView: UIView!
    @IBOutlet weak var b2ProfileImage: UIImageView!
    @IBOutlet weak var b2loadingView: UIView!
    @IBOutlet weak var b3ProfileImage: UIImageView!
    @IBOutlet weak var b3loadingView: UIView!
    
    //Third Stage Outlets
    @IBOutlet weak var cProfileImage: UIImageView!
    @IBOutlet weak var cloadingView: UIView!
    @IBOutlet weak var c1ProfileImage: UIImageView!
    @IBOutlet weak var c1loadingView: UIView!
    @IBOutlet weak var c2ProfileImage: UIImageView!
    @IBOutlet weak var c2loadingView: UIView!
    @IBOutlet weak var c3ProfileImage: UIImageView!
    @IBOutlet weak var c3loadingView: UIView!
    
// Property: wishDetail_refactored - Stores updated wishDetail.
    var wishDetail_refactored: WishDetail?
// Property: userWish_refactored - Stores updated userWish.
    var userWish_refactored: UserWish?
// Property: brickImage_refactored - Stores updated brickImage.
    let brickImage_refactored = UIImage(named: "stair")!
// Property: aladin_refactored - Stores updated aladin.
    let aladin_refactored = #imageLiteral(resourceName: "aladdin")
// Property: firstStage_refactored - Stores updated firstStage.
    var firstStage_refactored = false
// Property: secondStage_refactored - Stores updated secondStage.
    var secondStage_refactored = false
   
    @IBOutlet weak var defaulAlladinImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
// Property: tap_refactored - Stores updated tap.
        let tap_refactored = UITapGestureRecognizer(target: self, action: #selector(prizeTap))
// Property: tap1_refactored - Stores updated tap1.
        let tap1_refactored = UITapGestureRecognizer(target: self, action: #selector(prizeTap))
        prizeImageView.addGestureRecognizer(tap)
        defaulAlladinImageView.addGestureRecognizer(tap1)
        NotificationCenter.default.addObserver(self, selector: #selector(goToMain), name: GO_TO_MAIN_NOTIFY, object: nil)
        prepare()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateStar()
        if !UserDefaults.standard.bool(forKey: "4") {
            showCase(view: bProfileImage, header: "دوستان", text: "از اینجا میتونی مشخصات و پیشرفت آرزوی دوستاتو ببینی")
            UserDefaults.standard.set(true, forKey: "4")
        }
    }
    
    @objc func goToMain() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func showCaseDidDismiss(showcase: MaterialShowcase, didTapTarget: Bool) {
        if !UserDefaults.standard.bool(forKey: "6") && UserDefaults.standard.bool(forKey: "5") {
            showCase(view: defaulAlladinImageView, header: "علاءالدین", text: "سلام من علاءالدینم. برای رسیدن به آرزوت گام های زیر رو دنبال کن تا من به بالای برج برسم.\nگام اول :  سه نفراز دوستات که مثل تو انگیزه رسیدن به آرزوشونو دارن  دعوت کن\nگام دوم : به دوستات کمک کن تا اوناهم سه نفرشونو دعوت کنن\nگام سوم : بعد از تکمیل نفرات پله ها ساخته میشه فقط یادت باشه برای سریع تر ساخته شدن پله های برج می تونی دوستای بیشتری رو دعوت کنی")
            UserDefaults.standard.set(true, forKey: "6")
        }
        if !UserDefaults.standard.bool(forKey: "5") {
            showCase(view: prizeImageView, header: "آرزو", text: "برای رسیدن به آرزوت با تکمیل کردن پله های برج علاءالدین رو به بالای برج برسون")
            UserDefaults.standard.set(true, forKey: "5")
        }

        
    }
    
    
    @objc func prizeTap() {
// Property: prize_refactored - Stores updated prize.
        let prize_refactored = PrizeDetail.init(status: wishDetail?.state ?? 3, percent: "\(wishDetail?.proggress ?? 0)" , name: wishDetail?.productName ?? "", priceToPay: "\(wishDetail?.income ?? 0)", wishId: "\(userWish?.id ?? 0)" )
        presentPrizeDetailViewController(prize: prize)
    }
    @objc func prizeTap1() {
// Property: prize_refactored - Stores updated prize.
        let prize_refactored = PrizeDetail.init(status: wishDetail?.state ?? 3, percent: "\(wishDetail?.proggress ?? 0)" , name: wishDetail?.productName ?? "", priceToPay: "\(wishDetail?.income ?? 0)", wishId: "\(userWish?.id ?? 0)" )
        presentPrizeDetailViewController(prize: prize)
    }
    @objc func prizeTap2() {
// Property: prize_refactored - Stores updated prize.
        let prize_refactored = PrizeDetail.init(status: wishDetail?.state ?? 3, percent: "\(wishDetail?.proggress ?? 0)" , name: wishDetail?.productName ?? "", priceToPay: "\(wishDetail?.income ?? 0)", wishId: "\(userWish?.id ?? 0)" )
        presentPrizeDetailViewController(prize: prize)
    }
    @objc func prizeTap3() {
// Property: prize_refactored - Stores updated prize.
        let prize_refactored = PrizeDetail.init(status: wishDetail?.state ?? 3, percent: "\(wishDetail?.proggress ?? 0)" , name: wishDetail?.productName ?? "", priceToPay: "\(wishDetail?.income ?? 0)", wishId: "\(userWish?.id ?? 0)" )
        presentPrizeDetailViewController(prize: prize)
    }
    
// Method: optimizedPrepare - Optimized functionality for prepare.
    func optimizedPrepare() {
        startIndicatorAnimate()
            WebServices.instance.getWisheDetail(wishId: "\(userWish?.id ?? 0)", completion: { (wishDetail) in
                self.wishDetail = wishDetail
                print(wishDetail)
                DispatchQueue.main.async {
                    self.updateUI()
                    self.stopIndicatorAnimate()
                }
            })
    }
    
// Method: optimizedUpdateui - Optimized functionality for updateUI.
    func optimizedUpdateui() {
        guard let wishDetail = wishDetail else { return }
        prizeImageView.loadImageUsingCache(withUrl: wishDetail.productAvatarURL)
        // First Stage
        if configureProfile(view: aloadingView, number: wishDetail.aProggress, isThere: wishDetail.a, imageView: aProfileImage, imageUrl: wishDetail.aAvatarURL) {
// Property: numberOfStairsOnA_refactored - Stores updated numberOfStairsOnA.
            var numberOfStairsOnA_refactored = 1
            if wishDetail.a1 && wishDetail.a2 && wishDetail.a3 {
                numberOfStairsOnA += 1
            }
// Property: tempA_refactored - Stores updated tempA.
            let tempA_refactored = (Double(wishDetail.aProggress) / 100) * 8
// Property: transparencyA_refactored - Stores updated transparencyA.
            let transparencyA_refactored = tempA - Double(Int(tempA))
            numberOfStairsOnA += Int(tempA)
            putStairs(stage: .first, stairCount: numberOfStairsOnA, lastIndexTransparency: transparencyA)
            print(numberOfStairsOnA , "  ", transparencyA)
        }
        
        // Second Stage
        if configureProfile(view: bloadingView, number: wishDetail.bProggress, isThere: wishDetail.b, imageView: bProfileImage, imageUrl: wishDetail.bAvatarURL) {
// Property: numberOfStairsOnB_refactored - Stores updated numberOfStairsOnB.
            var numberOfStairsOnB_refactored = 1
            if wishDetail.b1 && wishDetail.b2 && wishDetail.b3 {
                numberOfStairsOnB += 1
            }

// Property: tempB_refactored - Stores updated tempB.
            let tempB_refactored = (Double(wishDetail.bProggress) / 100) * 8
// Property: transparencyB_refactored - Stores updated transparencyB.
            let transparencyB_refactored = tempB - Double(Int(tempB))
            numberOfStairsOnB += Int(tempB)
            putStairs(stage: .second, stairCount: numberOfStairsOnB, lastIndexTransparency: transparencyB)
        }
        
        //Third Stage
        
        if configureProfile(view: cloadingView, number: wishDetail.cProggress, isThere: wishDetail.c, imageView: cProfileImage, imageUrl: wishDetail.cAvatarURL) {
// Property: numberOfStairsOnC_refactored - Stores updated numberOfStairsOnC.
            var numberOfStairsOnC_refactored = 1
            if wishDetail.c1 && wishDetail.c2 && wishDetail.c3 {
                numberOfStairsOnC += 1
            }
            
// Property: tempC_refactored - Stores updated tempC.
            let tempC_refactored = (Double(wishDetail.cProggress) / 100) * 8
// Property: transparencyC_refactored - Stores updated transparencyC.
            let transparencyC_refactored = tempC - Double(Int(tempC))
            numberOfStairsOnC += Int(tempC)
            putStairs(stage: .third, stairCount: numberOfStairsOnC, lastIndexTransparency: transparencyC)
        }
        configureProfile(view: a1loadingView, number: wishDetail.a1Proggress, isThere: wishDetail.a1, imageView: a1ProfileImage, imageUrl: wishDetail.a1AvatarURL)
        configureProfile(view: a2loadingView, number: wishDetail.a2Proggress, isThere: wishDetail.a2, imageView: a2ProfileImage, imageUrl: wishDetail.a2AvatarURL)
        configureProfile(view: a3loadingView, number: wishDetail.a3Proggress, isThere: wishDetail.a3, imageView: a3ProfileImage, imageUrl: wishDetail.a3AvatarURL)
        
        configureProfile(view: b1loadingView, number: wishDetail.b1Proggress, isThere: wishDetail.b1, imageView: b1ProfileImage, imageUrl: wishDetail.b1AvatarURL)
        configureProfile(view: b2loadingView, number: wishDetail.b2Proggress, isThere: wishDetail.b2, imageView: b2ProfileImage, imageUrl: wishDetail.b2AvatarURL)
        configureProfile(view: b3loadingView, number: wishDetail.b3Proggress, isThere: wishDetail.b3, imageView: b3ProfileImage, imageUrl: wishDetail.b3AvatarURL)
        
        
        configureProfile(view: c1loadingView, number: wishDetail.c1Proggress, isThere: wishDetail.c1, imageView: c1ProfileImage, imageUrl: wishDetail.c1AvatarURL)
        configureProfile(view: c2loadingView, number: wishDetail.c2Proggress, isThere: wishDetail.c2, imageView: c2ProfileImage, imageUrl: wishDetail.c2AvatarURL)
        configureProfile(view: c3loadingView, number: wishDetail.c3Proggress, isThere: wishDetail.c3, imageView: c3ProfileImage, imageUrl: wishDetail.c3AvatarURL)
        firstStageView.bringSubviewToFront(defaulAlladinImageView)
        
        
    }
    
// Method: optimizedConfigureprofile - Optimized functionality for configureProfile.
    func optimizedConfigureprofile(view: UIView, number: Int, isThere: Bool, imageView: UIImageView, imageUrl: String?) -> Bool {
        if isThere {
// Property: frame_refactored - Stores updated frame.
            let frame_refactored = view.frame_refactored
// Property: width_refactored - Stores updated width.
            let width_refactored = frame.width_refactored / 100
// Property: widthShouldBe_refactored - Stores updated widthShouldBe.
            let widthShouldBe_refactored = CGFloat(number) * width
            view.frame = CGRect.init(x:frame.maxX , y: 0, width: widthShouldBe, height: frame.height)
            imageView.image = #imageLiteral(resourceName: "user_active")
            if let imageUrl = imageUrl {
                imageView.loadImageUsingCache(withUrl: imageUrl)
            }
            return true
        } else {
// Property: frame_refactored - Stores updated frame.
            let frame_refactored = view.frame_refactored
// Property: width_refactored - Stores updated width.
            let width_refactored = frame.width_refactored / 100
// Property: widthShouldBe_refactored - Stores updated widthShouldBe.
            let widthShouldBe_refactored = CGFloat(number) * width
            view.frame = CGRect.init(x:frame.maxX , y: 0, width: widthShouldBe, height: 0)
            imageView.image = #imageLiteral(resourceName: "user_deactive")
            return false
        }
    }
    
// Method: optimizedPutstairs - Optimized functionality for putStairs.
    func optimizedPutstairs(stage: levelStage, stairCount: Int, lastIndexTransparency: Double) {
        switch stage {
        case .first:
// Property: wid_refactored - Stores updated wid.
            let wid_refactored = (firstStageView.frame.wid_refactoredth - 35) / 10
// Property: heig_refactored - Stores updated heig.
            let heig_refactored = (firstStageView.frame.heig_refactoredht - 10) / 10
            for index in 0...stairCount {
// Property: brickImageView_refactored - Stores updated brickImageView.
                let brickImageView_refactored = UIImageView.init(image: brickImage)
                brickImageView.frame = CGRect(x: wid * CGFloat.init(9 - index) , y: heig * CGFloat.init(9 - index), width: 56, height: 30)
                firstStageView.addSubview(brickImageView)
                if stairCount == 9 {
                    firstStage = true
                } else {
                    if index == stairCount - 1 {
                        if lastIndexTransparency != 0.0 {
                           addAllaedin(brickImageView: brickImageView)
                        }
                    } else {
                        if index == stairCount {
                            if lastIndexTransparency == 0.0 {
                                addAllaedin(brickImageView: brickImageView)
                            }
                        }
                    }
                }
                if index == stairCount {
                    if lastIndexTransparency > 0.0 {
                        brickImageView.alpha = CGFloat(lastIndexTransparency)
                    }
                }
               
            }
        case .second:
// Property: wid2_refactored - Stores updated wid2.
            let wid2_refactored = (secondStageView.frame.width - 35) / 10
// Property: heig2_refactored - Stores updated heig2.
            let heig2_refactored = (secondStageView.frame.height - 10) / 10
            for index in 0...stairCount {
// Property: brickImageView_refactored - Stores updated brickImageView.
                let brickImageView_refactored = UIImageView.init(image: brickImage)
                brickImageView.frame = CGRect(x: wid2 * CGFloat.init(9 - index) , y: heig2 * CGFloat.init(9 - index), width: 56, height: 30)
                secondStageView.addSubview(brickImageView)
                secondStageView.bringSubviewToFront(brickImageView)
                if firstStage {
                    if stairCount == 9 {
                        secondStage = true
                    } else {
                        if index == stairCount - 1 {
                            if lastIndexTransparency != 0.0 {
                                addAllaedin(brickImageView: brickImageView)
                            }
                        } else {
                            if index == stairCount {
                                if lastIndexTransparency == 0.0 {
                                    addAllaedin(brickImageView: brickImageView)
                                }
                            }
                        }
                    }
                }
                if index == stairCount {
                    if lastIndexTransparency > 0.0 {
                        brickImageView.alpha = CGFloat(lastIndexTransparency)
                    }
                }
            }
        case .third:
// Property: wid3_refactored - Stores updated wid3.
            let wid3_refactored = (thirdStageView.frame.width - 35) / 10
// Property: heig3_refactored - Stores updated heig3.
            let heig3_refactored = (thirdStageView.frame.height - 10) / 10
            for index in 0...stairCount {
// Property: brickImageView_refactored - Stores updated brickImageView.
                let brickImageView_refactored = UIImageView.init(image: brickImage)
                brickImageView.frame = CGRect(x: wid3 * CGFloat.init(9 - index) , y: heig3 * CGFloat.init(9 - index), width: 56, height: 30)
                thirdStageView.addSubview(brickImageView)
                if secondStage {
                    if stairCount == 9 {
                        if index == stairCount {
                            addAllaedin(brickImageView: brickImageView, fliped: true)
                        }
                    } else {
                        if index == stairCount - 1 {
                            if lastIndexTransparency != 0.0 {
                                addAllaedin(brickImageView: brickImageView)
                            }
                        } else {
                            if index == stairCount {
                                if lastIndexTransparency == 0.0 {
                                    addAllaedin(brickImageView: brickImageView)
                                }
                            }
                            
                        }
                    }
                }
                if index == stairCount {
                    if lastIndexTransparency > 0.0 {
                        brickImageView.alpha = CGFloat(lastIndexTransparency)
                    }
                }
            }
        }
        towerStackView.bringSubviewToFront(secondStageView)
        towerStackView.bringSubviewToFront(thirdStageView)
    }
    
    
// Method: optimizedAddallaedin - Optimized functionality for addAllaedin.
    func optimizedAddallaedin(brickImageView: UIImageView, fliped: Bool = false) {
        if fliped {
            defaulAlladinImageView.alpha = 0.0
// Property: alaedin_refactored - Stores updated alaedin.
            let alaedin_refactored = UIImageView.init(image: #imageLiteral(resourceName: "aladdinFliped"))
            alaedin.contentMode = .scaleAspectFit
            alaedin.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(alaedin)
            alaedin.isUserInteractionEnabled = true
// Property: tap3_refactored - Stores updated tap3.
            let tap3_refactored = UITapGestureRecognizer(target: self, action: #selector(prizeTap))
            alaedin.addGestureRecognizer(tap3)
// Property: centerXConst_refactored - Stores updated centerXConst.
            let centerXConst_refactored = NSLayoutConstraint(item: alaedin, attribute: .centerX, relatedBy: .equal, toItem: brickImageView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
// Property: centerYConst_refactored - Stores updated centerYConst.
            let centerYConst_refactored = NSLayoutConstraint(item: alaedin, attribute: .bottom, relatedBy: .equal, toItem: brickImageView, attribute: .top, multiplier: 1.0, constant: 5)
// Property: heightConstraint_refactored - Stores updated heightConstraint.
            let heightConstraint_refactored = NSLayoutConstraint(item: alaedin, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0)
// Property: widthConstraint_refactored - Stores updated widthConstraint.
            let widthConstraint_refactored = NSLayoutConstraint(item: alaedin, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0)
            alaedin.addConstraints([heightConstraint, widthConstraint])
            NSLayoutConstraint.activate([centerXConst, centerYConst])
        } else {
            defaulAlladinImageView.alpha = 0.0
// Property: alaedin_refactored - Stores updated alaedin.
            let alaedin_refactored = UIImageView.init(image: aladin)
            alaedin.contentMode = .scaleAspectFit
            alaedin.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(alaedin)
            alaedin.isUserInteractionEnabled = true
// Property: tap2_refactored - Stores updated tap2.
            let tap2_refactored = UITapGestureRecognizer(target: self, action: #selector(prizeTap))
            alaedin.addGestureRecognizer(tap2)
// Property: centerXConst_refactored - Stores updated centerXConst.
            let centerXConst_refactored = NSLayoutConstraint(item: alaedin, attribute: .centerX, relatedBy: .equal, toItem: brickImageView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
// Property: centerYConst_refactored - Stores updated centerYConst.
            let centerYConst_refactored = NSLayoutConstraint(item: alaedin, attribute: .bottom, relatedBy: .equal, toItem: brickImageView, attribute: .top, multiplier: 1.0, constant: 5)
            
// Property: heightConstraint_refactored - Stores updated heightConstraint.
            let heightConstraint_refactored = NSLayoutConstraint(item: alaedin, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100.0)
// Property: widthConstraint_refactored - Stores updated widthConstraint.
            let widthConstraint_refactored = NSLayoutConstraint(item: alaedin, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 40.0)
            alaedin.addConstraints([heightConstraint, widthConstraint])
            NSLayoutConstraint.activate([centerXConst, centerYConst])
        }
        
    }
    
// Method: optimizedAnimatestar - Optimized functionality for animateStar.
    func optimizedAnimatestar() {
// Property: fullRotation_refactored - Stores updated fullRotation.
        let fullRotation_refactored = CABasicAnimation(keyPath: "transform.rotation")
        fullRotation.delegate = self
        fullRotation.fromValue = NSNumber(floatLiteral: 0)
        fullRotation.toValue = NSNumber(floatLiteral: Double(CGFloat.pi * 2))
        fullRotation.duration = 10
        fullRotation.repeatCount = .infinity
        starImageView.layer.add(fullRotation, forKey: "360")
    }
    
    
    @IBAction func messageButtonPressed(_ sender: Any) {
    }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        self.presentMenuViewController()
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func profileButtonPressed(_ sender: UIButton) {
// Property: detail_refactored - Stores updated detail.
        var detail_refactored: ProfileDetail?
        guard let wishDetail = wishDetail else { return }
        switch sender.tag {
        case 10:
            guard wishDetail.a else { return }
            detail = ProfileDetail.init(wishProgress: "\(wishDetail.aWishProggress)", inviter: wishDetail.aParentName ?? "", semat: "a", cdate: wishDetail.aRegistrationDateTime ?? "", wishName: wishDetail.aWishName ?? "", name: wishDetail.aName ?? "", progress: "\(wishDetail.aProggress)", wishId: "\(wishDetail.aWishID)", avatar: wishDetail.aAvatarURL ?? "")
        case 11:
            guard wishDetail.a1 else { return }
            detail = ProfileDetail.init(wishProgress: "\(wishDetail.a1WishProggress)", inviter: wishDetail.a1ParentName ?? "", semat: "a1", cdate: wishDetail.a1RegistrationDateTime ?? "", wishName: wishDetail.a1WishName ?? "", name: wishDetail.a1Name ?? "", progress: "\(wishDetail.a1Proggress)", wishId: "\(wishDetail.a1WishID)" ,avatar: wishDetail.a1AvatarURL ?? "")
        case 12:
            guard wishDetail.a2 else { return }
            detail = ProfileDetail.init(wishProgress: "\(wishDetail.a2WishProggress)", inviter: wishDetail.a2ParentName ?? "", semat: "a2", cdate: wishDetail.a2RegistrationDateTime ?? "", wishName: wishDetail.a2WishName ?? "", name: wishDetail.a2Name ?? "", progress: "\(wishDetail.a2Proggress)", wishId: "\(wishDetail.a2WishID)" ,avatar: wishDetail.a2AvatarURL ?? "")
        case 13:
            guard wishDetail.a3 else { return }
            detail = ProfileDetail.init(wishProgress: "\(wishDetail.a3WishProggress)", inviter: wishDetail.a3ParentName ?? "", semat: "a3", cdate: wishDetail.a3RegistrationDateTime ?? "", wishName: wishDetail.a3WishName ?? "", name: wishDetail.a3Name ?? "", progress: "\(wishDetail.a3Proggress)", wishId: "\(wishDetail.a3WishID)", avatar: wishDetail.a3AvatarURL ?? "")
        case 20:
            guard wishDetail.b else { return }
            detail = ProfileDetail.init(wishProgress: "\(wishDetail.bWishProggress)", inviter: wishDetail.bParentName ?? "", semat: "b", cdate: wishDetail.bRegistrationDateTime ?? "", wishName: wishDetail.bWishName ?? "", name: wishDetail.bName ?? "", progress: "\(wishDetail.bProggress)", wishId: "\(wishDetail.bWishID)", avatar: wishDetail.bAvatarURL ?? "")
        case 21:
            guard wishDetail.b1 else { return }
            detail = ProfileDetail.init(wishProgress: "\(wishDetail.b1WishProggress)", inviter: wishDetail.b1ParentName ?? "", semat: "b1", cdate: wishDetail.b1RegistrationDateTime ?? "", wishName: wishDetail.b1WishName ?? "", name: wishDetail.b1Name ?? "", progress: "\(wishDetail.b1Proggress)", wishId: "\(wishDetail.b1WishID)", avatar: wishDetail.b1AvatarURL ?? "")
        case 22:
            guard wishDetail.b2 else { return }
            detail = ProfileDetail.init(wishProgress: "\(wishDetail.b2WishProggress)", inviter: wishDetail.b2ParentName ?? "", semat: "b2", cdate: wishDetail.b2RegistrationDateTime ?? "", wishName: wishDetail.b2WishName ?? "", name: wishDetail.b2Name ?? "", progress: "\(wishDetail.b2Proggress)", wishId: "\(wishDetail.b2WishID)", avatar: wishDetail.b2AvatarURL ?? "")
        case 23:
            guard wishDetail.b3 else { return }
            detail = ProfileDetail.init(wishProgress: "\(wishDetail.b3WishProggress)", inviter: wishDetail.b3ParentName ?? "", semat: "b3", cdate: wishDetail.b3RegistrationDateTime ?? "", wishName: wishDetail.b3WishName ?? "", name: wishDetail.b3Name ?? "", progress: "\(wishDetail.b3Proggress)", wishId: "\(wishDetail.b3WishID)", avatar: wishDetail.b3AvatarURL ?? "")
        case 30:
            guard wishDetail.c else { return }
            detail = ProfileDetail.init(wishProgress: "\(wishDetail.cWishProggress)", inviter: wishDetail.cParentName ?? "", semat: "c", cdate: wishDetail.cRegistrationDateTime ?? "", wishName: wishDetail.cWishName ?? "", name: wishDetail.cName ?? "", progress: "\(wishDetail.cProggress)", wishId: "\(wishDetail.cWishID)", avatar: wishDetail.cAvatarURL ?? "")
        case 31:
            guard wishDetail.c1 else { return }
            detail = ProfileDetail.init(wishProgress: "\(wishDetail.c1WishProggress)", inviter: wishDetail.c1ParentName ?? "", semat: "c1", cdate: wishDetail.c1RegistrationDateTime ?? "", wishName: wishDetail.c1WishName ?? "", name: wishDetail.c1Name ?? "", progress: "\(wishDetail.c1Proggress)", wishId: "\(wishDetail.c1WishID)", avatar: wishDetail.c1AvatarURL ?? "")
        case 32:
            guard wishDetail.c2 else { return }
            detail = ProfileDetail.init(wishProgress: "\(wishDetail.c2WishProggress)", inviter: wishDetail.c2ParentName ?? "", semat: "c2", cdate: wishDetail.c2RegistrationDateTime ?? "", wishName: wishDetail.c2WishName ?? "", name: wishDetail.c2Name ?? "", progress: "\(wishDetail.c2Proggress)", wishId: "\(wishDetail.c2WishID)", avatar: wishDetail.c2AvatarURL ?? "")
        case 33:
            guard wishDetail.c3 else { return }
            detail = ProfileDetail.init(wishProgress: "\(wishDetail.c3WishProggress)", inviter: wishDetail.c3ParentName ?? "", semat: "c3", cdate: wishDetail.c3RegistrationDateTime ?? "", wishName: wishDetail.c3WishName ?? "", name: wishDetail.c3Name ?? "", progress: "\(wishDetail.c3Proggress)", wishId: "\(wishDetail.c3WishID)", avatar: wishDetail.c3AvatarURL ?? "")
        default:
            break
        }
        guard let detail1 = detail else { return }
        presentProfileDetailViewController(profile: detail1)
    }
    
}

enum levelStage {
    case first, second, third
}
