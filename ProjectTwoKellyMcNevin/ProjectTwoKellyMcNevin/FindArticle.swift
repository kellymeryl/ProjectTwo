//
//  FindArticle.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/5/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import Foundation
import UIKit

var userInput = ""
var categoryPicked = ""

class WallStreetJournalAPIClient{
    
    func getData(completion: @escaping ([Article]?) -> ()) {
        DispatchQueue.global(qos: .background).async{
        let endpoint = "https://newsapi.org/v1/articles?source=the-wall-street-journal&sortBy=top&apiKey=a78a442fe8ef42c29c6cc71e25ba5d6c"
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
    
    func getDataFromSearch(completion: @escaping ([Article]?) -> ()) {
        DispatchQueue.global(qos: .background).async{

        let endpoint = "https://newsapi.org/v1/articles?source=the-wall-street-journal&sortBy=top&apiKey=a78a442fe8ef42c29c6cc71e25ba5d6c"
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
    
    func getDataFromCategorySelection(completion: @escaping ([Article]?) -> ()) {
        DispatchQueue.global(qos: .background).async{
        
        let urlPartOne = "https://newsapi.org/v1/articles?source=the-wall-street-journal&category="
        let category = categoryPicked
        let apiKey = "&apiKey=a78a442fe8ef42c29c6cc71e25ba5d6c"
        let endpoint = urlPartOne + "\(category)" + apiKey
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
            let author = jsonArticle["author"] as! String
            let title = jsonArticle["title"] as! String
            let description = jsonArticle["description"] as! String
            let urlToImage = jsonArticle["urlToImage"] as! String
            let urlToArticle = jsonArticle["url"] as! String
            let article = Article(title: title, author: author, description: description,urlToImage: urlToImage, urlToArticle: urlToArticle)
            articles.append(article)
        }
        return articles

    }
    
  //  static func requestArticles(from category : ArticleCategory, with completion: @escaping (_ articles))
}
