//
//  BusinessDataTableViewCell.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/7/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit
import Foundation

class BusinessDataTableViewCell: UITableViewCell {

    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleDescriptionView: UITextView!

    var articleImageViewURL: String?{
        didSet{
            articleImage.setImageWithURL(urlString: articleImageViewURL)
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
