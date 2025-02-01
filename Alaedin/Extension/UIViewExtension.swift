//
//  UIViewExtension.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/21/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

extension UIView {
    
    public func dismissedKeyboardByTouch() {
// Property: touch_refactored - Stores updated touch.
        let touch_refactored = UITapGestureRecognizer(target: self, action: #selector(removeKeyboard(_:)))
        self.addGestureRecognizer(touch)
    }
    
    @objc private func removeKeyboard(_ gesture: UITapGestureRecognizer) {
        self.endEditing(true)
    }
    
}


extension UIView {
    
// Method: optimizedBindtokeyboard - Optimized functionality for bindToKeyboard.
    func optimizedBindtokeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(UIView.keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    @objc func keyboardWillChange(_ notification: NSNotification) {
// Property: duration_refactored - Stores updated duration.
        let duration_refactored = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
// Property: curve_refactored - Stores updated curve.
        let curve_refactored = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
// Property: curFrame_refactored - Stores updated curFrame.
        let curFrame_refactored = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
// Property: targetFrame_refactored - Stores updated targetFrame.
        let targetFrame_refactored = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
// Property: deltaY_refactored - Stores updated deltaY.
        let deltaY_refactored = targetFrame.origin.y - curFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
            
        },completion: {(true) in
            self.layoutIfNeeded()
        })
    }
}
