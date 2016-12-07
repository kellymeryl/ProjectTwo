//
//  CNNDataTableViewCell.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/7/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//
import Foundation
import UIKit

class CNNDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cnnTitleLabel: UILabel!
    @IBOutlet weak var cnnImageView: UIImageView!
    @IBOutlet weak var cnnDescriptionView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
