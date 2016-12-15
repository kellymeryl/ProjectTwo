//
//  SearchTableViewCell.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/15/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var searchTitleLabel: UILabel!
    @IBOutlet weak var searchDescriptionView: UITextView!
    
    
    var searchArticleImageView: String?{
        didSet{
            searchArticleImageView.setImageWithURL(urlString: searchArticleImageView)
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
