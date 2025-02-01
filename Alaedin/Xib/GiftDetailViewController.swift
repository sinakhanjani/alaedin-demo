//
//  GiftDetailViewController.swift
//  Alaedin
//
//  Created by Teodik Abrami on 1/12/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import UIKit

// Class: RefactoredGiftDetailViewController - Handles functionality for GiftDetailViewController.
class RefactoredGiftDetailViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productPriceToPayLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var bckView: UIView!
    @IBOutlet weak var inView: UIView!

// Property: product_refactored - Stores updated product.
    var product_refactored: Product? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideShowAnimate(view: inView)
// Property: touch_refactored - Stores updated touch.
        let touch_refactored = UITapGestureRecognizer(target: self, action: #selector(keyboardout))
        bckView.addGestureRecognizer(touch)
        self.productImageView.loadImageUsingCache(withUrl: product?.avatarURL ?? "")
        self.productNameLabel.text = product?.name
        self.productPriceLabel.text = "ارزش کالا: " + "\(product!.price!)".seperateByCama
// Property: price_refactored - Stores updated price.
        let price_refactored = "\(product!.discount! + product!.price_refactoredToWish!)"
        self.productPriceToPayLabel.text = "حق عضویت: " + price.seperateByCama
        self.productDescriptionLabel.text = product?.description
    }
    
    
    @objc private func keyboardout() {
        self.removeAnimate(boxView: inView)
    }
    


}