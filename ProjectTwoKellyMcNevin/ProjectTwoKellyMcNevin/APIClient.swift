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
        DispatchQueue.global(qos: .background).async{
            
            
            let endpoint = "https://newsapi.org/v1/articles?source=\(newsSource)&category=\(category.rawValue)&sortBy=top&apiKey=a78a442fe8ef42c29c6cc71e25ba5d6c"
            print(newsSource)
            print(category.rawValue)
            print(endpoint)
            let url = URLRequest(url: URL(string: endpoint)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: url) { data, _, _ in
                let json = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                let articles = self.getArticles(json)
                
                DispatchQueue.main.async {
                    completion(articles)
                }
                
            }
            
            task.resume()
        }
    }
    
    func getArticles(_ json: [String: Any]) -> [Article] {
        
        let listOfArticles = json["articles"] as! [[String: Any]]
        
        var articles = [Article]()
        
        for jsonArticle in listOfArticles {
            let author = jsonArticle["author"] as? String ?? ""
            let title = jsonArticle["title"] as? String ?? ""
            let description = jsonArticle["description"] as? String ?? ""
            let urlToImage = jsonArticle["urlToImage"] as? String ?? ""
            let urlToArticle = jsonArticle["url"] as? String ?? ""
            let article = Article(title: title, author: author, description: description,urlToImage: urlToImage, urlToArticle: urlToArticle)
            articles.append(article)
        }
        return articles
        
    }
    var sourcesArray = ["the-wall-street-journal", "business-insider", "the-economist", "cnn", "usa-today", "bloomberg-news", "financial-times"]
    
    
    func searchAll(completion: ([Article])->()) {
        
        var articles = [Article]()
        var allArticles = [Article]()
        let articleSemaphore = DispatchSemaphore(value: 134523)
        
        for sourceOfArticle in self.sourcesArray {
            
            let articleFetchCompletion: ([Article]?) -> () = { (responseArticles: [Article]?) in
                
                if let art = responseArticles {
                    articles = art
                    allArticles.append(contentsOf: articles)
                }
                articleSemaphore.signal()
            }
        
            self.getData(newsSource: sourceOfArticle, category: .general, completion: articleFetchCompletion)
            print(sourceOfArticle)
          //  allSearchedArticles.append(contentsOf: articles)
         //   allArticles.append(contentsOf: articles)
            articleSemaphore.wait()
        }
        print(articles.count)
        completion(articles)
    }

}

