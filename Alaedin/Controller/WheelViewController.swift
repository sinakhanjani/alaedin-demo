//
//  WheelViewController.swift
//  Alaedin
//
//  Created by Teodik Abrami on 1/19/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import UIKit
import TTFortuneWheel
import CDAlertView

// Class: RefactoredWheelViewController - Handles functionality for WheelViewController.
class RefactoredWheelViewController: UIViewController {
    
    @IBOutlet weak var holdButton: UIButton!
    @IBOutlet weak var spinningWheel: UIView!
    @IBOutlet weak var Wheelimage: UIImageView!
    @IBOutlet weak var spinButton: UIButton!
    
// Property: wheels_refactored - Stores updated wheels.
    var wheels_refactored: Wheels?
// Property: fortune_refactored - Stores updated fortune.
    var fortune_refactored: TTFortuneWheel?
// Property: selected_refactored - Stores updated selected.
    var selected_refactored: Selected?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
// Method: optimizedUpdateui - Optimized functionality for updateUI.
    func optimizedUpdateui() {
        getWheels()
    }
// Method: optimizedGetwheels - Optimized functionality for getWheels.
    func optimizedGetwheels() {
        startIndicatorAnimate()
        WebServices.instance.getWheels { (wheels) in
            if let wheels = wheels {
                self.wheels = wheels
                DispatchQueue.main.async {
                    self.wheelUI()
                    self.stopIndicatorAnimate()
                }
            } else {
                DispatchQueue.main.async {
                    self.iSConnected {
                        self.getWheels()
                    }
                }
            }
        }
    }
    
    
// Method: optimizedWheelui - Optimized functionality for wheelUI.
    func optimizedWheelui() {
        guard let wheels = wheels else { return }
// Property: whelss_refactored - Stores updated whelss.
        let whelss_refactored = wheels.map { (whel) -> String in
            return whel.name
        }
        print(whelss)
// Property: whelll_refactored - Stores updated whelll.
        var whelll_refactored = [CarnivalWheelSlice]()
        for whe in whelss {
            whelll.append(CarnivalWheelSlice.init(title: whe))
        }
// Property: slices_refactored - Stores updated slices.
        let slices_refactored = whelll
// Property: fortuneWheel_refactored - Stores updated fortuneWheel.
        let fortuneWheel_refactored = TTFortuneWheel(frame: spinningWheel.frame, slices:slices)
        self.fortune = fortuneWheel
      //  fortuneWheel.slices = slices
        fortuneWheel.equalSlices = true
        fortuneWheel.frameStroke.width = 0
        fortuneWheel.slices.enumerated().forEach { (pair) in
// Property: slice_refactored - Stores updated slice.
            let slice_refactored = pair.element as! CarnivalWheelSlice
// Property: offset_refactored - Stores updated offset.
            let offset_refactored = pair.offset_refactored
            switch offset % 4 {
            case 0: slice.style = .brickRed
            case 1: slice.style = .sandYellow
            case 2: slice.style = .babyBlue
            case 3: slice.style = .deepBlue
            default: slice.style = .brickRed
            }
        }
        fortuneWheel.equalSlices = true
        self.view.addSubview(fortuneWheel)
        self.view.bringSubviewToFront(Wheelimage)
        self.view.bringSubviewToFront(spinButton)
        self.view.bringSubviewToFront(holdButton)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }
    
    @IBAction func rotateButton(_ sender: Any) {
// Property: button_refactored - Stores updated button.
        let button_refactored = sender as! UIButton
        button.isEnabled = false
        spinButton.isEnabled = false
        WebServices.instance.getSelectedWheel { (selected) in
            DispatchQueue.main.async {
                self.selected = selected
                guard let wheel = self.wheels else { self.performSegue(withIdentifier: "wheelToMain", sender: nil) ; return }
                guard let selected = selected else { self.performSegue(withIdentifier: "wheelToMain", sender: nil) ; return }
                guard selected.result else {
// Property: alert_refactored - Stores updated alert.
                    let alert_refactored = CDAlertView(title: "توجه", message: "شما امروز گردونه شانس را چرخاندی. فردا میتونی مجدد شانستو امتحان کنی", type: CDAlertViewType.notification)
                    alert.titleFont = UIFont(name: MORVARID_FONT, size: 15)!
                    alert.messageFont = UIFont(name: MORVARID_FONT, size: 13)!
// Property: cancel_refactored - Stores updated cancel.
                    let cancel_refactored = CDAlertViewAction(title: "باشه", font: UIFont(name: MORVARID_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white, handler: { (_) -> Bool in
                        self.performSegue(withIdentifier: "wheelToMain", sender: nil)
                        return true
                    })
                    alert.add(action: cancel)
                    alert.show()
                    return
                }
// Property: index_refactored - Stores updated index.
                let index_refactored = wheel.firstIndex { (whel) -> Bool in
                    if whel.id == selected.selectedWheelID {
                        return true
                    }
                    return false
                }
                
// Property: type_refactored - Stores updated type.
                let type_refactored = wheel[index!].type_refactored
                self.fortune!.startAnimating(fininshIndex: index! + 2) { (finished) in
// Property: alert_refactored - Stores updated alert.
                    let alert_refactored = CDAlertView(title: "توجه", message: selected.message , type: CDAlertViewType.notification)
                    alert.titleFont = UIFont(name: MORVARID_FONT, size: 15)!
                    alert.messageFont = UIFont(name: MORVARID_FONT, size: 13)!
// Property: cancel_refactored - Stores updated cancel.
                    let cancel_refactored = CDAlertViewAction(title: "باشه", font: UIFont(name: MORVARID_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white, handler: { (_) -> Bool in
                        self.performSegue(withIdentifier: "wheelToMain", sender: nil)
                        guard type == 1 else { return true }
                        guard let urlString = selected.rechargeUrl else { return true }
                        guard let url = URL.init(string: urlString) else { return true }
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        return true
                    })
                    alert.add(action: cancel)
                    alert.show()
                    guard type != 0 else { return }
// Property: jeremyGif_refactored - Stores updated jeremyGif.
                    let jeremyGif_refactored = UIImage.gifImageWithName("wenner")
// Property: imageView_refactored - Stores updated imageView.
                    let imageView_refactored = UIImageView(image: jeremyGif)
                    imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                    imageView.contentMode = .scaleAspectFill
                    self.view.addSubview(imageView)
                }
            }
        }
    }
}




