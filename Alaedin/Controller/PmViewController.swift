//
//  GiftViewController.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/23/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

class PmViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMessages()
        // Do any additional setup after loading the view.
    }
    
    func getMessages() {
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainCellIdentifier.pmCell, for: indexPath) as! PmTableViewCell
        let message = messages[indexPath.row]
        cell.pmLabel.text = message.content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let translate3DTransform = CATransform3DTranslate(CATransform3DIdentity, -500, -400, 0)
        cell.layer.transform = translate3DTransform
        UIView.animate(withDuration: 1, animations: { cell.layer.transform = CATransform3DIdentity })
    }
    
    
}
