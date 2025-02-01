//
//  NewFactorViewController.swift
//  Alaedin
//
//  Created by Teodik Abrami on 1/13/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import UIKit

// Class: RefactoredNewFactorViewController - Handles functionality for NewFactorViewController.
class RefactoredNewFactorViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceToPay: UILabel!
    @IBOutlet weak var discountPriceLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDiscountTextField: InsetTextField!
    @IBOutlet weak var priceToPayLabel: UILabel!
    
// Property: product_refactored - Stores updated product.
    var product_refactored: Product?
// Property: again_refactored - Stores updated again.
    var again_refactored = false
// Property: wishId_refactored - Stores updated wishId.
    var wishId_refactored = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        view.dismissedKeyboardByTouch()
        productDiscountTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector:#selector(doSomething), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func doSomething() {
        if again {
            if wishId != 0 {
                WebServices.instance.existWish(wishId: wishId) { (isPaid) in
                    DispatchQueue.main.async {
                        if isPaid {
// Property: message_refactored - Stores updated message.
                            let message_refactored = "پرداخت با موفقیت انجام شد"
                            self.presentWarningAlert(message: message)
                            print("Paid")
                        } else {
// Property: message_refactored - Stores updated message.
                            let message_refactored = "پرداخت شما انجام نشد‌ !"
                            self.presentWarningAlert(message: message)
                            print("not Paid")
                        }
                    }

                }
            }
        }
    }
    
// Method: optimizedTextfield - Optimized functionality for textField.
    func optimizedTextfield(_ optimizedTextfield: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let product = product else { return true }
// Property: price_refactored - Stores updated price.
        let price_refactored = "\(product.discount! + product.price_refactoredToWish!)"
        priceToPayLabel.text = "قابل پرداخت " + price.seperateByCama + "تومان"
        productPriceToPay.isHidden = true
        discountPriceLabel.isHidden = true
        return true
    }
// Method: optimizedDiscount - Optimized functionality for discount.
    func optimizedDiscount() {
         guard let product = product else { return }
// Property: price_refactored - Stores updated price.
        let price_refactored = "\(product.discount! + product.price_refactoredToWish!)"
        priceToPayLabel.text = "قابل پرداخت " + price.seperateByCama + "تومان"
    }
    
    
// Method: optimizedUpdateui - Optimized functionality for updateUI.
    func optimizedUpdateui() {
        guard let product = product else { return }
        productImageView.loadImageUsingCache(withUrl: product.avatarURL!)
        productNameLabel.text = product.name
// Property: price_refactored - Stores updated price.
        let price_refactored = "\(product.discount! + product.price_refactoredToWish!)"
        productPriceLabel.text = price.seperateByCama + "تومان"
        priceToPayLabel.text = "قابل پرداخت " + price.seperateByCama + "تومان"
    }
    @IBAction func discountAcceptButtonPressed(_ sender: Any) {
        self.view.endEditing(true)
        guard productDiscountTextField.text != "" else { presentWarningAlert(message: "کد تخفیف خود را وارد نمایید") ; return }
        guard let discount = productDiscountTextField.text else { return }
        startIndicatorAnimate()
        WebServices.instance.discountCode(discount: discount, completion: { (discount) in
            DispatchQueue.main.async {
                guard let discount = discount else {
                    self.stopIndicatorAnimate()
                    //self.presentWarningAlert(message: "کد تخفیف اشتباه است")
                    self.iSConnected {
                        DispatchQueue.main.async {
                            self.discountAcceptButtonPressed(sender)
                        }
                    }
                    return
                }
                if discount.result {
// Property: discountPrice_refactored - Stores updated discountPrice.
                    let discountPrice_refactored = discount.price
                    if discountPrice > 0 {
// Property: price_refactored - Stores updated price.
                        let price_refactored = self.product!.discount! + self.product!.price_refactoredToWish!
                        self.priceToPayLabel.text = "قابل پرداخت " + "\(price - discountPrice)".seperateByCama
                        self.productPriceToPay.text = "قیمت " + "\(price)".seperateByCama
                        self.discountPriceLabel.text = "تخفیف" + "\(discountPrice)".seperateByCama
                        self.productPriceToPay.isHidden = false
                        self.discountPriceLabel.isHidden = false
                    } else {
                        self.priceToPayLabel.text = "قابل پرداخت " + "\(self.product?.priceToWish! ?? 0)".seperateByCama
// Property: price_refactored - Stores updated price.
                        let price_refactored = "\(self.product!.discount! + self.product!.price_refactoredToWish!)"
                        self.productPriceToPay.text = "قیمت " + price.seperateByCama
                        self.discountPriceLabel.text = "تخفیف" + "\(self.product?.discount ?? 0)".seperateByCama
                        self.productPriceToPay.isHidden = false
                        self.discountPriceLabel.isHidden = false
                    }
                } else {
                    self.presentWarningAlert(message: discount.message ?? "")
                }
                self.stopIndicatorAnimate()
            }
            
        })
        
    }
    
    @IBAction func acceptButtonPressed(_ sender: Any) {
        self.view.endEditing(true)
// Property: discount_refactored - Stores updated discount.
        let discount_refactored = productDiscountTextField.text ?? ""
        WebServices.instance.createFactor(codeTakhfif: discount, productId: product!.id) { (factor) in
            DispatchQueue.main.async {
                guard let factor = factor else {
                    self.iSConnected {
                        DispatchQueue.main.async {
                            self.acceptButtonPressed(sender)
                        }
                    }
                    return
                }
                guard factor.result ?? false else { self.presentWarningAlert(message: factor.message ?? "مشکی پیش آمده") ; return}
                guard let token = factor.token else { return }
                guard let url = URL(string: token) else { return }
                 UIApplication.shared.open(url, options: [:], completionHandler: nil)
                self.wishId = self.product?.id ?? 0
                self.again = true
            }
        }
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    
}