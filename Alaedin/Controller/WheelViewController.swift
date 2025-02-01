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

class WheelViewController: UIViewController {
    
    @IBOutlet weak var holdButton: UIButton!
    @IBOutlet weak var spinningWheel: UIView!
    @IBOutlet weak var Wheelimage: UIImageView!
    @IBOutlet weak var spinButton: UIButton!
    
    var wheels: Wheels?
    var fortune: TTFortuneWheel?
    var selected: Selected?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    func updateUI() {
        getWheels()
    }
    
    func getWheels() {
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
    
    
    func wheelUI() {
        guard let wheels = wheels else { return }
        let whelss = wheels.map { (whel) -> String in
            return whel.name
        }
        print(whelss)
        var whelll = [CarnivalWheelSlice]()
        for whe in whelss {
            whelll.append(CarnivalWheelSlice.init(title: whe))
        }
        let slices = whelll
        let fortuneWheel = TTFortuneWheel(frame: spinningWheel.frame, slices:slices)
        self.fortune = fortuneWheel
      //  fortuneWheel.slices = slices
        fortuneWheel.equalSlices = true
        fortuneWheel.frameStroke.width = 0
        fortuneWheel.slices.enumerated().forEach { (pair) in
            let slice = pair.element as! CarnivalWheelSlice
            let offset = pair.offset
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
        let button = sender as! UIButton
        button.isEnabled = false
        spinButton.isEnabled = false
        WebServices.instance.getSelectedWheel { (selected) in
            DispatchQueue.main.async {
                self.selected = selected
                guard let wheel = self.wheels else { self.performSegue(withIdentifier: "wheelToMain", sender: nil) ; return }
                guard let selected = selected else { self.performSegue(withIdentifier: "wheelToMain", sender: nil) ; return }
                guard selected.result else {
                    let alert = CDAlertView(title: "توجه", message: "شما امروز گردونه شانس را چرخاندی. فردا میتونی مجدد شانستو امتحان کنی", type: CDAlertViewType.notification)
                    alert.titleFont = UIFont(name: MORVARID_FONT, size: 15)!
                    alert.messageFont = UIFont(name: MORVARID_FONT, size: 13)!
                    let cancel = CDAlertViewAction(title: "باشه", font: UIFont(name: MORVARID_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white, handler: { (_) -> Bool in
                        self.performSegue(withIdentifier: "wheelToMain", sender: nil)
                        return true
                    })
                    alert.add(action: cancel)
                    alert.show()
                    return
                }
                let index = wheel.firstIndex { (whel) -> Bool in
                    if whel.id == selected.selectedWheelID {
                        return true
                    }
                    return false
                }
                
                let type = wheel[index!].type
                self.fortune!.startAnimating(fininshIndex: index! + 2) { (finished) in
                    let alert = CDAlertView(title: "توجه", message: selected.message , type: CDAlertViewType.notification)
                    alert.titleFont = UIFont(name: MORVARID_FONT, size: 15)!
                    alert.messageFont = UIFont(name: MORVARID_FONT, size: 13)!
                    let cancel = CDAlertViewAction(title: "باشه", font: UIFont(name: MORVARID_FONT, size: 13)!, textColor: UIColor.darkGray, backgroundColor: .white, handler: { (_) -> Bool in
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
                    let jeremyGif = UIImage.gifImageWithName("wenner")
                    let imageView = UIImageView(image: jeremyGif)
                    imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                    imageView.contentMode = .scaleAspectFill
                    self.view.addSubview(imageView)
                }
            }
        }
    }
}





