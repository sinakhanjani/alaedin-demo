//
//  GiftDetailViewController.swift
//  Alaedin
//
//  Created by Teodik Abrami on 1/12/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import UIKit

class GiftDetailViewController: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productPriceToPayLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var bckView: UIView!
    @IBOutlet weak var inView: UIView!

    var product: Product? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideShowAnimate(view: inView)
        let touch = UITapGestureRecognizer(target: self, action: #selector(keyboardout))
        bckView.addGestureRecognizer(touch)
        self.productImageView.loadImageUsingCache(withUrl: product?.avatarURL ?? "")
        self.productNameLabel.text = product?.name
        self.productPriceLabel.text = "ارزش کالا: " + "\(product!.price!)".seperateByCama
        let price = "\(product!.discount! + product!.priceToWish!)"
        self.productPriceToPayLabel.text = "حق عضویت: " + price.seperateByCama
        self.productDescriptionLabel.text = product?.description
    }
    
    
    @objc private func keyboardout() {
        self.removeAnimate(boxView: inView)
    }
    


}
