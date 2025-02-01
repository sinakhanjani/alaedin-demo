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

let RESUME_VIDEO_NOTIFY = Notification.Name("resumeNotify")
let PUASE_VIDEO_NOTIFY = Notification.Name("pauaseNotify")

class VideoPlayerViewController: UIViewController,AVPlayerViewControllerDelegate {

    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    
    fileprivate let video01 = "http://cheraghjadoo.com/media/video01.mp4"
    fileprivate let video02 = "http://cheraghjadoo.com/media/video02.mp4"

    public var videoPlayURL: String?
    public var encodeName: String?
    public var saveKey: String?
    public var showCloseButton: Bool = true
    
    var player: AVPlayer?
    var playerLooper: NSObject?
    var playerLayer:AVPlayerLayer!
    var queuePlayer: AVQueuePlayer?
    
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
    
    func downloadViewFromURL(videoPlayName: String, encodeName: String) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destURL = documentsDirectory.appendingPathComponent("\(encodeName).mp4")
        if FileManager.default.fileExists(atPath: destURL.path) {
            print("file already exist at \(destURL)")
            self.playVideo(url: destURL, view: bgView)
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
    
    func justDownloadVideo(videoPlayName: String, encodeName: String) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destURL = documentsDirectory.appendingPathComponent("\(encodeName).mp4")
        if FileManager.default.fileExists(atPath: destURL.path) {
            print("file already exist at \(destURL)")
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
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "VideoPlayerViewControllerID") as! VideoPlayerViewController
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
            var newItem = true
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
