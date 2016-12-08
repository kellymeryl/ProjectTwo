//
//  FinancialTimesClientAPI.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/7/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import Foundation
import UIKit

class FinancialTimesAPIClient{
    
    func getFinancialTimesData(category: Category = .general, completion: @escaping ([Article]?) -> ()) {
        DispatchQueue.global(qos: .background).async{
            
            
            let endpoint = "https://newsapi.org/v1/articles?source=financial-times&category=\(category.rawValue)&sortBy=top&apiKey=a78a442fe8ef42c29c6cc71e25ba5d6c"
            let url = URLRequest(url: URL(string: endpoint)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: url) { data, _, _ in
                let json = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                let financialTimesArticles = self.getFinancialTimesArticles(json)
                
                DispatchQueue.main.async {
                    completion(financialTimesArticles)
                }
                
            }
            
            task.resume()
        }
    }
    
    
    func getFinancialTimesArticles(_ json: [String: Any]) -> [Article] {
        let listOfFinancialTimesArticles = json["articles"] as! [[String: Any]]
        
        var financialTimesArticles = [Article]()
        
        for jsonArticle in listOfFinancialTimesArticles {
            let author = jsonArticle["author"] as? String ?? ""
            let title = jsonArticle["title"] as? String ?? ""
            let description = jsonArticle["description"] as? String ?? ""
            let urlToImage = jsonArticle["urlToImage"] as? String ?? ""
            let urlToArticle = jsonArticle["url"] as? String ?? ""
            let article = Article(title: title, author: author, description: description,urlToImage: urlToImage, urlToArticle: urlToArticle)
            financialTimesArticles.append(article)
        }
        return financialTimesArticles
        
    }
}
