//
//  WebViewController.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/23/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import WebKit

// Class: RefactoredWebViewController - Handles functionality for WebViewController.
class RefactoredWebViewController: UIViewController {

    @IBOutlet weak var webVie: UIWebView!
    
// Property: url_refactored - Stores updated url.
    var url_refactored: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = url {
// Property: request_refactored - Stores updated request.
            let request_refactored = URLRequest.init(url: url)
            webVie.loadRequest(request)
        }
        self.sideShowAnimate(view: view)
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        self.sideHideAnimate(view: view)
    }
    


}