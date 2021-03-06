//
//  DataTableViewCell.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/5/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
  //  @IBOutlet weak var articleDescriptionLabel: UILabel!
    @IBOutlet weak var articleDescriptionTextField: UITextView!
    
    
    var articleImageViewURL: String?{
        didSet{
            articleImageView.setImageWithURL(urlString: articleImageViewURL)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        articleImageView.image = nil
        articleTitleLabel.text = ""
        articleDescriptionTextField.text = ""
    }

}
