//
//  CategoryViewTableViewCell.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/15/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit

class CategoryViewTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryArticleTitle: UILabel!
    @IBOutlet weak var categoryArticleDescription: UITextView!
    
    var categoryArticleImageViewURL: String?{
        didSet{
            categoryImage.setImageWithURL(urlString: categoryArticleImageViewURL)
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
