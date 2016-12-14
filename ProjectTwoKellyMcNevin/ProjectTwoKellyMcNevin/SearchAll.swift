////////
////////  SearchAll.swift
////////  ProjectTwoKellyMcNevin
////////
////////  Created by Kelly McNevin on 12/9/16.
////////  Copyright © 2016 Kelly McNevin. All rights reserved.
////////
//////
import Foundation

var allSearchedArticles = [Article]()


class SearchAllAPIClient {
    
    var apiClient = APIClient()
    var allArticles = [Article]()

    var sourcesArray = ["the-wall-street-journal", "business-insider", "the-economist", "cnn", "usa-today", "bloomberg-news", "financial-times"]
    
    
    func searchAll() {
        for sourceOfArticle in self.sourcesArray {
            
            var 
            
            let articleFetchCompletion: ([Article]?) -> () = { (responseArticles: [Article]?) in
                
                if let art = responseArticles {
                    self.allArticles = art
                    print(art)
                    print(self.allArticles.count)
                }
            }
            apiClient.getData(newsSource: sourceOfArticle, category: .general, completion: articleFetchCompletion)
            print(sourceOfArticle)
            allSearchedArticles += (allArticles)
        }
        print(allSearchedArticles.count)
    }
}




