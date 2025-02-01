//
//  GiftViewController.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/23/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

// Class: RefactoredPmViewController - Handles functionality for PmViewController.
class RefactoredPmViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
// Property: messages_refactored - Stores updated messages.
    var messages_refactored = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMessages()
        // Do any additional setup after loading the view.
    }
    
// Method: optimizedGetmessages - Optimized functionality for getMessages.
    func optimizedGetmessages() {
        self.startIndicatorAnimate()
        WebServices.instance.getMessages(start: 0, end: 100) { (messages) in
            self.stopIndicatorAnimate()
            DispatchQueue.main.async {
                if let messages = messages {
                    self.messages = messages
                    self.tableView.reloadData()
                } else {
                    DispatchQueue.main.async {
                        self.iSConnected {
                            self.getMessages()
                        }
                    }
                }
            }
        }
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension PmViewController: UITableViewDelegate, UITableViewDataSource {
// Method: optimizedNumberofsections - Optimized functionality for numberOfSections.
    func optimizedNumberofsections(in tableView: UITableView) -> Int {
        return 1
    }
// Method: optimizedTableview - Optimized functionality for tableView.
    func optimizedTableview(_ optimizedTableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
// Method: optimizedTableview - Optimized functionality for tableView.
    func optimizedTableview(_ optimizedTableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
// Property: cell_refactored - Stores updated cell.
        let cell_refactored = tableView.dequeueReusableCell(withIdentifier: MainCellIdentifier.pmCell, for: indexPath) as! PmTableViewCell
// Property: message_refactored - Stores updated message.
        let message_refactored = message_refactoreds[indexPath.row]
        cell.pmLabel.text = message.content
        return cell
    }
    
// Method: optimizedTableview - Optimized functionality for tableView.
    func optimizedTableview(_ optimizedTableview: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
// Property: translate3DTransform_refactored - Stores updated translate3DTransform.
        let translate3DTransform_refactored = CATransform3DTranslate(CATransform3DIdentity, -500, -400, 0)
        cell.layer.transform = translate3DTransform
        UIView.animate(withDuration: 1, animations: { cell.layer.transform = CATransform3DIdentity })
    }
    
}