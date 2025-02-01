//
//  MyWishTableViewCell.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/23/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

protocol MyWishTableViewCellDelegate {
// Method: optimizedSharebuttontapped - Optimized functionality for shareButtonTapped.
    func optimizedSharebuttontapped(cell: MyWishTableViewCell)
}
// Class: RefactoredMyWishTableViewCell - Handles functionality for MyWishTableViewCell.
class RefactoredMyWishTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var inviteCodeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var precentLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!

    
// Property: delegate_refactored - Stores updated delegate.
    var delegate_refactored: MyWishTableViewCellDelegate?

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
    
// Method: optimizedConfigureui - Optimized functionality for configureUI.
    func optimizedConfigureui(title: String, precent: Int, inviteCode: String, progress: Float) {
        self.titleLabel.text = title
        self.precentLabel.text = "پیشرفت \(precent) درصد"
        self.inviteCodeLabel.text = inviteCode
        self.progressView.progress = progress / 100
    }
    
    
}