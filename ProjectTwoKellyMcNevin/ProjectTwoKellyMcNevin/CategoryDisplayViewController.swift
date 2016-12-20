//
//  CategoryDisplayViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/15/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit
import Foundation
import SafariServices

class CategoryDisplayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var categoryArticleTableView: UITableView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    var selectedIndex: Int?
    var articles = [Article]()
   // var selectedSource: CategoryViewTableViewCell?
    var client = APIClient()
    var selectedCell: CategoryViewTableViewCell?
    
    func loadTableViewURLFromCategories() {
        
        let articleFetchCompletion: ([Article]?) -> () = { (responseArticles: [Article]?) in
            print("Articles delivered to View Controller")
            
            if let art = responseArticles {
                self.articles = art
                DispatchQueue.main.async {
                    self.categoryArticleTableView.reloadData()
                }
            }
        }
        let category = Category.asArray()[selectedIndex!]
        client.getData(category: category, completion: articleFetchCompletion)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTitleLabel.text = Category.asArray()[selectedIndex!].rawValue
        loadTableViewURLFromCategories()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryViewTableViewCell", for: indexPath) as! CategoryViewTableViewCell
            
            let article = articles[indexPath.row]
            cell.categoryArticleTitle.text = article.title
            cell.categoryArticleDescription.text = article.description
            cell.categoryArticleImageViewURL = article.urlToImage
            return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! CategoryViewTableViewCell
        
        if cell === selectedCell {
            cell.backgroundColor = UIColor.white
            selectedCell = nil
        }
        else {
            cell.backgroundColor = UIColor.lightGray
            
                let article = articles[indexPath.row]
                let svc = SFSafariViewController(url: URL(string: article.urlToArticle)!)
                print(article.urlToArticle)
                self.navigationController?.pushViewController(svc, animated: true)
            selectedCell?.backgroundColor = UIColor.white
            selectedCell = cell
    }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

