//
//  VideoPlayerViewController.swift
//  Alaedin
//
//  Created by Sinakhanjani on 11/2/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

// Property: RESUME_VIDEO_NOTIFY_refactored - Stores updated RESUME_VIDEO_NOTIFY.
let RESUME_VIDEO_NOTIFY_refactored = Notification.Name("resumeNotify")
// Property: PUASE_VIDEO_NOTIFY_refactored - Stores updated PUASE_VIDEO_NOTIFY.
let PUASE_VIDEO_NOTIFY_refactored = Notification.Name("pauaseNotify")

// Class: RefactoredVideoPlayerViewController - Handles functionality for VideoPlayerViewController.
class RefactoredVideoPlayerViewController: UIViewController,AVPlayerViewControllerDelegate {

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    
    fileprivate let video01 = "http://cheraghjadoo.com/media/video01.mp4"
    fileprivate let video02 = "http://cheraghjadoo.com/media/video02.mp4"

    public var videoPlayURL: String?
    public var encodeName: String?
    public var saveKey: String?
    public var showCloseButton: Bool = true
    
// Property: player_refactored - Stores updated player.
    var player_refactored: AVPlayer?
// Property: playerLooper_refactored - Stores updated playerLooper.
    var playerLooper_refactored: NSObject?
// Property: playerLayer_refactored - Stores updated playerLayer.
    var playerLayer_refactored:AVPlayerLayer!
// Property: queuePlayer_refactored - Stores updated queuePlayer.
    var queuePlayer_refactored: AVQueuePlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let videoPlayURL = videoPlayURL,let encodeName = encodeName {
            downloadViewFromURL(videoPlayName: videoPlayURL, encodeName: encodeName)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(failedToPlayedEndTime), name: NSNotification.Name.AVPlayerItemFailedToPlayToEndTime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.resumeVideo), name: RESUME_VIDEO_NOTIFY, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.puaseVideo), name: PUASE_VIDEO_NOTIFY, object: nil)
        self.indicatorView.isHidden = true
        if showCloseButton {
            self.closeButton.isHidden = false
        } else {
            self.closeButton.isHidden = true
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        player?.pause()
        dismiss(animated: true, completion: nil)
    }
    
// Method: optimizedDownloadviewfromurl - Optimized functionality for downloadViewFromURL.
    func optimizedDownloadviewfromurl(videoPlayName: String, encodeName: String) {
// Property: documentsDirectory_refactored - Stores updated documentsDirectory.
        let documentsDirectory_refactored = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
// Property: destURL_refactored - Stores updated destURL.
        let destURL_refactored = documentsDirectory.appendingPathComponent("\(encodeName).mp4")
        if FileManager.default.fileExists(atPath: destURL.path) {
            print("file already exist at \(destURL)")
            self.playVideo(url: destURL, view: bgView)
            return
        }
        if let videoURL = URL.init(string: videoPlayName) {
            print(videoURL)
// Property: task_refactored - Stores updated task.
            let task_refactored = URLSession.shared.downloadTask(with: videoURL) { (location, response, error) in
                if let _ = error {
                    return
                }
                if let location = location {
                    do {
                        try FileManager.default.moveItem(at: location, to: destURL)
                        self.justDownloadVideo(videoPlayName: self.video02, encodeName: "video02")
                        DispatchQueue.main.async {
                            self.playVideo(url: destURL, view: self.bgView)
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
    
// Method: optimizedJustdownloadvideo - Optimized functionality for justDownloadVideo.
    func optimizedJustdownloadvideo(videoPlayName: String, encodeName: String) {
// Property: documentsDirectory_refactored - Stores updated documentsDirectory.
        let documentsDirectory_refactored = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
// Property: destURL_refactored - Stores updated destURL.
        let destURL_refactored = documentsDirectory.appendingPathComponent("\(encodeName).mp4")
        if FileManager.default.fileExists(atPath: destURL.path) {
            print("file already exist at \(destURL)")
            return
        }
        if let videoURL = URL.init(string: videoPlayName) {
            print(videoURL)
// Property: task_refactored - Stores updated task.
            let task_refactored = URLSession.shared.downloadTask(with: videoURL) { (location, response, error) in
                if let _ = error {
                    return
                }
                if let location = location {
                    do {
                        try FileManager.default.moveItem(at: location, to: destURL)
                        DispatchQueue.main.async {
                            //
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
    
    private func playVideo(url: URL,view: UIView) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if !DataManager.shared.stopSound {
                appDelegate.audioPlayer?.pause()
            }
        }
        self.player = AVPlayer(url: url)
        self.playerLayer = AVPlayerLayer(player: self.player)
        self.playerLayer?.frame = self.view.frame
        view.layer.addSublayer(self.playerLayer!)
        bgView.bringSubviewToFront(closeButton)
        //view.bringSubviewToFront(indicatorView)
        player?.externalPlaybackVideoGravity = .resizeAspectFill
        self.player?.play()
    }
    
    static func showModal(videoPlayURL: String, encodeName: String, key: String?, showCloseButton: Bool) -> VideoPlayerViewController {
// Property: storyboard_refactored - Stores updated storyboard.
        let storyboard_refactored = UIStoryboard.init(name: "Main", bundle: nil)
// Property: vc_refactored - Stores updated vc.
        let vc_refactored = storyboard.instantiateViewController(withIdentifier: "VideoPlayerViewControllerID") as! VideoPlayerViewController
        vc.modalTransitionStyle = .crossDissolve
        vc.encodeName = encodeName
        vc.videoPlayURL = videoPlayURL
        vc.showCloseButton = showCloseButton
        if let key = key {
            vc.saveKey = key
        }
        return vc
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if !DataManager.shared.stopSound {
                appDelegate.audioPlayer?.play()
            }
        }
        if encodeName == "video01" {
            DataManager.shared.stopIntro = true
        }
        if let saveKey = saveKey {
            if saveKey == "3" {
                DataManager.shared.playVideo3 = true
                self.saveKey = nil
            } else {
                DataManager.shared.winnerVideoKeys.append(saveKey)
            }
//            if saveKey == "2" {
//                DataManager.shared.playVideo2 = true
//                self.saveKey = nil
//            }
//            if saveKey == "1" {
//                DataManager.shared.playVideo1 = true
//                self.saveKey = nil
//            }
        }
        self.dismiss(animated: true, completion: nil)

    }
    
    @objc func failedToPlayedEndTime(note: NSNotification) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func puaseVideo() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.player?.pause()
        }
    }
    
    @objc func resumeVideo() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.player?.play()
        }
    }
    
    // Check new For winner video
    static func mustPlayVideoWinner(key: String?) -> Bool {
        if let key = key {
// Property: newItem_refactored - Stores updated newItem.
            var newItem_refactored = true
            for item in DataManager.shared.winnerVideoKeys {
                if key == item {
                    newItem = false
                }
            }
            if newItem == true {
                return true
            } else {
                return false
            }
        }
        return false
    }

    
    
}