
//
//  WinnerTableViewCell.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/23/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

// Class: RefactoredWinnerTableViewCell - Handles functionality for WinnerTableViewCell.
class RefactoredWinnerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var winToolLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
// Method: optimizedConfigureui - Optimized functionality for configureUI.
    func optimizedConfigureui(name: String, winTool: String) {
        self.nameLabel.text = name
        self.winToolLabel.text = winTool
    }
}