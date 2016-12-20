//
//  APIClient.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/8/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import Foundation
import UIKit

//API Client class getsData from API Call & does JSON Parsing.
class APIClient{
    
    
    
    func getData(newsSource:  String = "the-wall-street-journal", category: Category = .general, completion: @escaping ([Article]?) -> ()) {
        
        let endpoint = "https://newsapi.org/v1/articles?source=\(newsSource)&category=\(category.rawValue)&sortBy=top&apiKey=a78a442fe8ef42c29c6cc71e25ba5d6c"
        print(newsSource)
        print(category.rawValue)
        print(endpoint)
        let url = URLRequest(url: URL(string: endpoint)!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { data, _, _ in
            if let json = (try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] {
                
                
                let articles = self.getArticles(json)
                completion(articles)
                
                //                    DispatchQueue.main.async {
                //
                //                    }
            }
        }
        
        task.resume()
    }
    
    func getArticles(_ json: [String: Any]) -> [Article] {
        
        var articles = [Article]()
        if let listOfArticles = json["articles"] as? [[String: Any]] {
            
            for jsonArticle in listOfArticles {
                let author = jsonArticle["author"] as? String ?? ""
                let title = jsonArticle["title"] as? String ?? ""
                let description = jsonArticle["description"] as? String ?? ""
                let urlToImage = jsonArticle["urlToImage"] as? String ?? ""
                let urlToArticle = jsonArticle["url"] as? String ?? ""
                let article = Article(title: title, author: author, description: description,urlToImage: urlToImage, urlToArticle: urlToArticle)
                articles.append(article)
            }
        }
        return articles
    }
    var sourcesArray = ["the-wall-street-journal", "business-insider", "the-economist", "cnn", "usa-today", "bloomberg-news", "financial-times"]
    
    
    func searchAll(completion: @escaping ([Article])->()) {
        
        var articles = [Article]()
        
        let articleSemaphore = DispatchSemaphore(value: 134523)
        
        for (index, sourceOfArticle) in self.sourcesArray.enumerated() {
            
        self.getData(newsSource: sourceOfArticle, category: .general) { responseArticles in
                
            if let art = responseArticles {
                articles.append(contentsOf: art)
                print(articles.count)
                    
                if index == (self.sourcesArray.count - 1) {
                    completion(articles)
                }
            }
            articleSemaphore.signal()
            }
        articleSemaphore.wait()
        }
    }
    
}

