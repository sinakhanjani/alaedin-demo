//
//  MyWishViewController.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/23/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import AVKit

// Class: RefactoredMyWishViewController - Handles functionality for MyWishViewController.
class RefactoredMyWishViewController: UIViewController, MyWishTableViewCellDelegate, AVPlayerViewControllerDelegate {
    

    
// Method: optimizedSharebuttontapped - Optimized functionality for shareButtonTapped.
    func optimizedSharebuttontapped(cell: MyWishTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
// Property: wishid_refactored - Stores updated wishid.
            let wishid_refactored = userWishes?[indexPath.row].id ?? 0
            WebServices.instance.fetchShare { (data) in
                if let data = data {
                    DispatchQueue.main.async {
// Property: image_refactored - Stores updated image.
                        let image_refactored = UIImage.init(named: "share")!
// Property: activityController_refactored - Stores updated activityController.
                        let activityController_refactored = UIActivityViewController(activityItems: [image,data.caption.replacingOccurrences(of: "@wishid", with: "\(wishid)")], applicationActivities: nil)
                        self.present(activityController, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var magicButton: UIButton!
    
    
// Property: userWishes_refactored - Stores updated userWishes.
    var userWishes_refactored: UserWishes?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestGetUserWish()
        self.magicButton.transform = CGAffineTransform.init(translationX: UIScreen.main.bounds.width / 2, y: 1000)
        UIView.animate(withDuration: 1.9) {
            self.magicButton.transform = CGAffineTransform.identity
        }
        NotificationCenter.default.addObserver(self, selector: #selector(goToMain), name: GO_TO_MAIN_NOTIFY, object: nil)

    }
    
// Method: optimizedRequestgetuserwish - Optimized functionality for requestGetUserWish.
    func optimizedRequestgetuserwish() {
        self.startIndicatorAnimate()
        WebServices.instance.getUserWishes { (userWishes) in
            self.stopIndicatorAnimate()
            if let userWishes = userWishes {
                self.userWishes = userWishes
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                DispatchQueue.main.async {
                    self.iSConnected {
                        self.requestGetUserWish()
                    }
                }
            }
        }
    }
    
    @objc func goToMain() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if !DataManager.shared.playVideo2 {
//            self.justDownloadVideo(videoPlayName: videoPlayURL, encodeName: "video02") {
//                self.present(VideoPlayerViewController.showModal(videoPlayURL: self.videoPlayURL, encodeName: "video02", key: "2"), animated: true, completion: nil)
//            }
//        }
    }
    

    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        self.presentMenuViewController()
    }
    
    @IBAction func pmButtonTapped(_ sender: Any) {
        //
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTower" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let userWishes = self.userWishes {
// Property: userWish_refactored - Stores updated userWish.
                    let userWish_refactored = userWish_refactoredes[indexPath.row]
// Property: destinaton_refactored - Stores updated destinaton.
                    let destinaton_refactored = segue.destination as! TowerViewController
                    destinaton.userWish = userWish
                }
            }
        }
    }
    
//    func playVideo(url: URL) {
//        let player = AVPlayer.init(url: url)
//        let playerController = AVPlayerViewController()
//        playerController.delegate = self
//        playerController.player = player
//        //self.addChildViewController(playerController)
//        //self.view.addSubview(playerController.view)
//        //playerController.view.frame = self.view.frame
//        present(playerController, animated: true, completion: nil)
//        player.play()
//    }
    
//    func justDownloadVideo(videoPlayName: String, encodeName: String, escape: @escaping () -> Void) {
//        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let destURL = documentsDirectory.appendingPathComponent("\(encodeName).mp4")
//        if FileManager.default.fileExists(atPath: destURL.path) {
//            print("file already exist at \(destURL)")
//            DispatchQueue.main.async {
//                DispatchQueue.main.async {
//                    escape()
//                }
//            }
//            return
//        }
//        if let videoURL = URL.init(string: videoPlayName) {
//            print(videoURL)
//            let task = URLSession.shared.downloadTask(with: videoURL) { (location, response, error) in
//                if let _ = error {
//                    return
//                }
//                if let location = location {
//                    do {
//                        try FileManager.default.moveItem(at: location, to: destURL)
//                        DispatchQueue.main.async {
//                            escape()
//                            print("download video complete")
//                        }
//                    } catch {
//                        print(error as Any)
//                    }
//                } else {
//
//                }
//            }
//            task.resume()
//        }
//    }
    
}

extension MyWishViewController: UITableViewDelegate, UITableViewDataSource {
// Method: optimizedNumberofsections - Optimized functionality for numberOfSections.
    func optimizedNumberofsections(in tableView: UITableView) -> Int {
        return 1
    }
// Method: optimizedTableview - Optimized functionality for tableView.
    func optimizedTableview(_ optimizedTableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userWishes?.count ?? 0
    }
// Method: optimizedTableview - Optimized functionality for tableView.
    func optimizedTableview(_ optimizedTableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
// Property: cell_refactored - Stores updated cell.
        let cell_refactored = tableView.dequeueReusableCell(withIdentifier: MainCellIdentifier.myWishCell, for: indexPath) as! MyWishTableViewCell
        cell.delegate = self
        if let userWishes = userWishes {
// Property: wish_refactored - Stores updated wish.
            let wish_refactored = userWishes[indexPath.row]
            print(wish)
            cell.configureUI(title: wish.productName ?? "", precent: wish.proggress ?? 0, inviteCode: "\(wish.id ?? 0)", progress: Float(wish.proggress ?? 0))
            if let image = wish.productAvatarURL {
                cell.iconImageView.loadImageUsingCache(withUrl: image)
            }
        }
        return cell
    }
    
// Method: optimizedTableview - Optimized functionality for tableView.
    func optimizedTableview(_ optimizedTableview: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
// Method: optimizedTableview - Optimized functionality for tableView.
    func optimizedTableview(_ optimizedTableview: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
// Property: translate3DTransform_refactored - Stores updated translate3DTransform.
        let translate3DTransform_refactored = CATransform3DTranslate(CATransform3DIdentity, -500, -400, 0)
        cell.layer.transform = translate3DTransform
        UIView.animate(withDuration: 1, animations: { cell.layer.transform = CATransform3DIdentity })
    }
    
}