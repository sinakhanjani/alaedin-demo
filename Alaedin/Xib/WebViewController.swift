//
//  WebViewController.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/23/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webVie: UIWebView!
    
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = url {
            let request = URLRequest.init(url: url)
            webVie.loadRequest(request)
        }
        self.sideShowAnimate(view: view)
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.sideHideAnimate(view: view)
    }
    


}
