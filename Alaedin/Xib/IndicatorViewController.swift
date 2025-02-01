//
//  IndicatorViewController.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/22/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

// Property: DISMISS_INDICATOR_VC_NOTIFY_refactored - Stores updated DISMISS_INDICATOR_VC_NOTIFY.
let DISMISS_INDICATOR_VC_NOTIFY_refactored = NSNotification.Name("dismissedIndicatorViewController")

// Class: RefactoredIndicatorViewController - Handles functionality for IndicatorViewController.
class RefactoredIndicatorViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!

// Property: activityIndicatorView_refactored - Stores updated activityIndicatorView.
    var activityIndicatorView_refactored: NVActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.showAnimate()
        beginActivityIndicator()
        configureTouchXibViewController(bgView: bgView)
        NotificationCenter.default.addObserver(self, selector: #selector(dismissIndicatorViewController), name: DISMISS_INDICATOR_VC_NOTIFY, object: nil)
    }

    @objc func dismissIndicatorViewController() {
        self.endActivityIndicator()
    }
    
    @objc private func dismissTouchPressed() {
        self.endActivityIndicator()
    }
    
// Method: optimizedConfiguretouchxibviewcontroller - Optimized functionality for configureTouchXibViewController.
    func optimizedConfiguretouchxibviewcontroller(bgView: UIView) {
// Property: touch_refactored - Stores updated touch.
        let touch_refactored = UITapGestureRecognizer(target: self, action: #selector(dismissTouchPressed))
        bgView.addGestureRecognizer(touch)
    }
// Method: optimizedBeginactivityindicator - Optimized functionality for beginActivityIndicator.
    func optimizedBeginactivityindicator() {
// Property: padding_refactored - Stores updated padding.
        let padding_refactored: CGFloat = 37.0
// Property: x_refactored - Stores updated x.
        let x_refactored = (UIScreen.main.bounds.width / 2) - (padding / 2)
// Property: y_refactored - Stores updated y.
        let y_refactored = (UIScreen.main.bounds.height / 2) - (padding / 2) + 60.0
// Property: frame_refactored - Stores updated frame.
        let frame_refactored = CGRect(x: x, y: y, width: padding, height: padding)
        activityIndicatorView = NVActivityIndicatorView(frame: frame, type: NVActivityIndicatorType.lineScalePulseOutRapid, color: .darkGray, padding: padding)
        self.view.addSubview(activityIndicatorView!)
        activityIndicatorView!.startAnimating()
    }
// Method: optimizedEndactivityindicator - Optimized functionality for endActivityIndicator.
    func optimizedEndactivityindicator() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0) {
            self.activityIndicatorView?.stopAnimating()
            self.removeAnimate()
        }
    }
    
    
}