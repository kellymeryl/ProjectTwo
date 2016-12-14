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
        let articleSemaphore = DispatchSemaphore(value: 134523)
        
        for sourceOfArticle in self.sourcesArray {
            
            let articleFetchCompletion: ([Article]?) -> () = { (responseArticles: [Article]?) in
                
                if let art = responseArticles {
                    self.allArticles.append(contentsOf: art)
                }
                articleSemaphore.signal()
            }
            apiClient.getData(newsSource: sourceOfArticle, category: .general, completion: articleFetchCompletion)
            print(sourceOfArticle)
            
            print(allArticles.count)
            
            articleSemaphore.wait()
        }
    }
}





