//
//  WinnerViewController.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/23/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import AVKit

// Class: RefactoredWinnerViewController - Handles functionality for WinnerViewController.
class RefactoredWinnerViewController: UIViewController,AVPlayerViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var magicButton: UIButton!
    
//    fileprivate let videoPlayURL = "http://cheraghjadoo.com/media/video02.mp4"
    
// Property: winners_refactored - Stores updated winners.
    var winners_refactored = [Winner]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        magicButton.transform = CGAffineTransform.init(translationX: UIScreen.main.bounds.width / 2, y: 1000)
        UIView.animate(withDuration: 1.9) {
            self.magicButton.transform = CGAffineTransform.identity
        }
        requestFetchWinner()
        NotificationCenter.default.addObserver(self, selector: #selector(goToMain), name: GO_TO_MAIN_NOTIFY, object: nil)
    }
    
// Method: optimizedRequestfetchwinner - Optimized functionality for requestFetchWinner.
    func optimizedRequestfetchwinner() {
        self.startIndicatorAnimate()
        WebServices.instance.fetchWinner { (winners) in
            self.stopIndicatorAnimate()
            DispatchQueue.main.async {
                if let winners = winners {
                    self.winners = winners
                    self.tableView.reloadData()
                } else {
                    DispatchQueue.main.async {
                        self.iSConnected {
                            self.requestFetchWinner()
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        if !DataManager.shared.playVideo1 {
//            self.justDownloadVideo(videoPlayName: videoPlayURL, encodeName: "video02") {
//                self.present(VideoPlayerViewController.showModal(videoPlayURL: self.videoPlayURL, encodeName: "video02", key: "1"), animated: true, completion: nil)
//            }
//        }
    }
    
    @objc func goToMain() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func menuButtonTapped(_ sender: Any) {
        self.presentMenuViewController()
    }
  
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

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
//
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
//
    
}

extension WinnerViewController: UITableViewDelegate, UITableViewDataSource {
// Method: optimizedNumberofsections - Optimized functionality for numberOfSections.
    func optimizedNumberofsections(in tableView: UITableView) -> Int {
        return 1
    }
// Method: optimizedTableview - Optimized functionality for tableView.
    func optimizedTableview(_ optimizedTableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.winners.count
    }
// Method: optimizedTableview - Optimized functionality for tableView.
    func optimizedTableview(_ optimizedTableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
// Property: cell_refactored - Stores updated cell.
        let cell_refactored = tableView.dequeueReusableCell(withIdentifier: MainCellIdentifier.winnerCell, for: indexPath) as! WinnerTableViewCell
// Property: winner_refactored - Stores updated winner.
        let winner_refactored = winner_refactoreds[indexPath.row]
        cell.configureUI(name: winner.userDisplayName ?? "", winTool: winner.productDisplayName ?? "")
        cell.iconImageView.loadImageUsingCache(withUrl: winner.productAvatarURL ?? "")
        cell.profileImageView.loadImageUsingCache(withUrl: winner.userAvatarURL ?? "")
        return cell
    }
    
// Method: optimizedTableview - Optimized functionality for tableView.
    func optimizedTableview(_ optimizedTableview: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
// Property: translate3DTransform_refactored - Stores updated translate3DTransform.
        let translate3DTransform_refactored = CATransform3DTranslate(CATransform3DIdentity, -500, -400, 0)
        cell.layer.transform = translate3DTransform
        UIView.animate(withDuration: 1, animations: { cell.layer.transform = CATransform3DIdentity })
    }
}