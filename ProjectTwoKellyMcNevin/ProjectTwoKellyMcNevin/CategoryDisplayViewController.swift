//
//  CategoryDisplayViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/15/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit

class CategoryDisplayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var categoryArticleTableView: UITableView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    var selectedIndex: Int?
    var articles = [Article]()
    var selectedSource: CategoryViewTableViewCell?
    var client = APIClient()
    
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
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
