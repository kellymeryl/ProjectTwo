//
//  DataModel.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/5/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import Foundation
import UIKit

class Article {
    
    var title: String
    var author: String
    var description: String
    var urlToImage: String
    var urlToArticle: String
    
    init(title: String, author: String, description: String, urlToImage: String, urlToArticle: String){
        self.title = title
        self.author = author
        self.description = description
        self.urlToImage = urlToImage
        self.urlToArticle = urlToArticle
    }
    
}
