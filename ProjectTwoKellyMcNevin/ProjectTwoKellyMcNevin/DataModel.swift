//
//  DataModel.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/5/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import Foundation
import UIKit


//creates Article class
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

//Creates News Source Class
class NewsSourceTitle {
    var title: String
    
    init(title: String){
        self.title = title
    }
}

//Creates array of titles for slider menu

var arrayOfTitles: [NewsSourceTitle] = [
    NewsSourceTitle(title: "Financial Times"),
    NewsSourceTitle(title: "Bloomberg News"),
    NewsSourceTitle(title: "The Economist"),
    NewsSourceTitle(title: "Business Insider"),
    NewsSourceTitle(title: "USA Today"),
    NewsSourceTitle(title: "CNN"),
    NewsSourceTitle(title: "The Wall Street Journal"),
]

