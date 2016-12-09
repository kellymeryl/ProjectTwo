//
//  CNNTableViewCell.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/7/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit
import Foundation

class CNNTableViewCell: UITableViewCell {

    @IBOutlet weak var cnnArticleTitle: UILabel!
    @IBOutlet weak var cnnImageView: UIImageView!
    @IBOutlet weak var cnnDescriptionTextfield: UITextView!
    
    var articleImageViewURL: String?{
        didSet{
            cnnImageView.setImageWithURL(urlString: articleImageViewURL)
        }
    }

   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cnnImageView.image = nil
        cnnArticleTitle.text = ""
        cnnDescriptionTextfield.text = ""
    }

}
