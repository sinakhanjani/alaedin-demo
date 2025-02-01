//
//  ViewController.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/21/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MaterialShowcase

class MainViewController: UIViewController, AVPlayerViewControllerDelegate, CAAnimationDelegate {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var cloudLeftImageView: UIImageView!
    @IBOutlet weak var cloudRightImageView: UIImageView!
    @IBOutlet weak var ghalichehImageView: UIImageView!
    
    @IBOutlet weak var garduneButton: UIButton!
    @IBOutlet weak var giftButton: UIButton!
    @IBOutlet weak var wishButton: UIButton!
    @IBOutlet weak var winnerButton: UIButton!
    
    @IBOutlet weak var versionLabel: UILabel!
    let playerController = AVPlayerViewController()
    var isPlayVideo = false
    
    fileprivate let videoPlayURL = "http://cheraghjadoo.com/media/video01.mp4"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let leftAnimate = CGAffineTransform.init(translationX: -1000, y: UIScreen.main.bounds.width + 199)
        animateImageView(customView: cloudLeftImageView, transform: leftAnimate)
        let rightAnimate = CGAffineTransform.init(translationX: 1000, y: UIScreen.main.bounds.width + 199)
        self.animateImageView(customView: cloudRightImageView, transform: rightAnimate)
        ghalichehImageView.alpha = 0.0
        NotificationCenter.default.addObserver(self, selector:#selector(checkUpdate), name: UIApplication.willEnterForegroundNotification, object: nil)
        UIView.animate(withDuration: 4.8, animations: {
            self.ghalichehImageView.alpha = 1.0
        }) { (status) in
            //
        }
        logoImageView.transform = CGAffineTransform.init(translationX: 1.1, y: 1.1)
        wishButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        giftButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        winnerButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        if !DataManager.shared.welcomeInApp {
            WebServices.instance.sendDeviceDetailRequest { (status) in
                if status == .success {
                    DataManager.shared.welcomeInApp = true
                }
            }
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateStar()
        checkUpdate()
         self.logoImageView.alpha = 0.4
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [.repeat,.allowUserInteraction,.curveEaseOut,.autoreverse], animations: {
            self.logoImageView.alpha = 1
        }) { (status) in
            self.logoImageView.alpha = 0.4
        }
        if isPlayVideo {
            if !UserDefaults.standard.bool(forKey: "1") {
                showCase(view: winnerButton, header: "برندگان", text: "لیست آخرین کسایی که به آرزوشون رسیدنو اینجا ببین")
                UserDefaults.standard.set(true, forKey: "1")
            }
        }
//        if !DataManager.shared.stopIntro {
//            self.present(VideoPlayerViewController.showModal(videoPlayURL: self.videoPlayURL, encodeName: "video01", key: nil), animated: true, completion: nil)
//        }
        if !DataManager.shared.stopIntro {
            self.justDownloadVideo(videoPlayName: videoPlayURL, encodeName: "video01") {
                self.present(VideoPlayerViewController.showModal(videoPlayURL: self.videoPlayURL, encodeName: "video01", key: nil, showCloseButton: false), animated: true, completion: nil)
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.6) {
                self.playWinnerVideo()
            }
        }
        print(DataManager.shared.winnerVideoKeys)
    }
    
    @IBAction func emailButtonTapped(_ sender: Any) {
        guard Authorization.shared.isLoggedIn else {
            DataManager.shared.openViews = 1
            presentSignUpViewController()
            return
        }
        performSegue(withIdentifier: "mainToMessage", sender: nil)
    }
    
    @IBAction func myWishesButtonTapped(_ sender: Any) {
        DataManager.shared.openViews = 1
        guard Authorization.shared.isLoggedIn else {
            presentSignUpViewController()
            return
        }
        performSegue(withIdentifier: "mainToMyWish", sender: nil)
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        self.presentMenuViewController()
    }
    
    @IBAction func giftButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func winnerButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func unwindToMainViewController( _ segue: UIStoryboardSegue) {
        //
    }
    
    func animateImageView(customView: UIImageView, transform: CGAffineTransform) {
        customView.transform = transform
        UIView.animate(withDuration: 3.4, animations: {
            customView.transform = CGAffineTransform.identity
        }) { (status) in
            //
        }
    }
    
    @objc func checkUpdate() {
        WebServices.instance.getVersion { (version) in
            DispatchQueue.main.async {
                guard let version = version else {
                    DispatchQueue.main.async {
                        self.iSConnected {
                            self.checkUpdate()
                        }
                    }
                    return
                }
                let ver = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
                self.versionLabel.text = "version: " + ver
                guard let bundle = Int(Bundle.main.infoDictionary!["CFBundleVersion"] as! String) else { return }
                guard let appBundle = Int(version) else { return }
                if appBundle > bundle {
                    self.presentCDAlertWarningAlert(message: "آخرین نسخه برنامه را از سیب اپ دریافت کنید", completion: {
                        let url = URL(string: "https://sibapp.com/applications/alaedin")!
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    })
                }
            }
        }
    }
    
    func animateStar() {
        let fullRotation = CABasicAnimation(keyPath: "transform.rotation")
        fullRotation.delegate = self
        fullRotation.fromValue = NSNumber(floatLiteral: 0)
        fullRotation.toValue = NSNumber(floatLiteral: Double(CGFloat.pi * 2))
        fullRotation.duration = 10
        fullRotation.repeatCount = .infinity
        garduneButton.layer.add(fullRotation, forKey: "360")
        let theAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        theAnimation.duration       = 2
        theAnimation.repeatCount    = Float.infinity
        theAnimation.autoreverses   = true
        theAnimation.fromValue      = 1.0
        theAnimation.toValue        = 1.1
        theAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        garduneButton.layer.add(theAnimation, forKey: nil)
    }
    
    private func showCaseDidDismiss(showcase: MaterialShowcase, didTapTarget: Bool) {
        if !UserDefaults.standard.bool(forKey: "3") && UserDefaults.standard.bool(forKey: "2") {
            showCase(view: wishButton, header: "آرزو های من", text: "فهرست آرزوهاتو با درصد پیشرفتش اینجا ببین")
            UserDefaults.standard.set(true, forKey: "3")
        }
        if !UserDefaults.standard.bool(forKey: "2") {
            showCase(view: giftButton, header: "جوایز", text: "تو صفحه جوایز میتونی آرزتو انتخاب کنی")
            UserDefaults.standard.set(true, forKey: "2")
        }

    }
    
    @IBAction func garduneButtonPressed(_ sender: Any) {
        guard Authorization.shared.isLoggedIn else {
            DataManager.shared.openViews = 1
            presentWarningAlert(message: "اول باید ثبت نام کنی")
            presentSignUpViewController()
            return
        }
        performSegue(withIdentifier: "mainToWheel", sender: nil)
    }
    
    
    func justDownloadVideo(videoPlayName: String, encodeName: String, escape: @escaping () -> Void) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destURL = documentsDirectory.appendingPathComponent("\(encodeName).mp4")
        if FileManager.default.fileExists(atPath: destURL.path) {
            print("file already exist at \(destURL)")
            DispatchQueue.main.async {
                DispatchQueue.main.async {
                    escape()
                }
            }
            return
        }
        if let videoURL = URL.init(string: videoPlayName) {
            print(videoURL)
            let task = URLSession.shared.downloadTask(with: videoURL) { (location, response, error) in
                if let _ = error {
                    return
                }
                if let location = location {
                    do {
                        try FileManager.default.moveItem(at: location, to: destURL)
                        DispatchQueue.main.async {
                            escape()
                            print("download video complete")
                        }
                    } catch {
                        print(error as Any)
                    }
                } else {
                    
                }
            }
            task.resume()
        }
    }
    
    func playWinnerVideo() {
        WebServices.instance.getViedeoWinner { (link) in
            if let link = link {
                DispatchQueue.main.async {
                    if VideoPlayerViewController.mustPlayVideoWinner(key: link) {
                        print("link is:\(link)")
                        let randomNo = "\(DataManager.shared.randomNo)"
                        self.justDownloadVideo(videoPlayName: link, encodeName: randomNo, escape: {
                            DispatchQueue.main.async {
                                self.present(VideoPlayerViewController.showModal(videoPlayURL: link, encodeName: randomNo, key: link, showCloseButton: false), animated: true, completion: nil)
                            }
                        })
                    } else {
                        // do nothing : no new video for winner
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.iSConnected {
                        self.playWinnerVideo()
                    }
                }
            }
        }
    }
    
}

