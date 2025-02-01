//
//  MyWishTableViewCell.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/23/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

protocol MyWishTableViewCellDelegate {
    func shareButtonTapped(cell: MyWishTableViewCell)
}

class MyWishTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var inviteCodeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var precentLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!

    
    var delegate: MyWishTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        progressView.transform = CGAffineTransform.init(rotationAngle: .pi)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        self.delegate?.shareButtonTapped(cell: self)
    }
    
    func configureUI(title: String, precent: Int, inviteCode: String, progress: Float) {
        self.titleLabel.text = title
        self.precentLabel.text = "پیشرفت \(precent) درصد"
        self.inviteCodeLabel.text = inviteCode
        self.progressView.progress = progress / 100
    }
    
    
    
}
