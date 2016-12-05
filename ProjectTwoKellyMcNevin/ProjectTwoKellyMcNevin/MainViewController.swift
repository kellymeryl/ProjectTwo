//
//  MainViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/5/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    

    @IBOutlet weak var dataTableView: UITableView!
    
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = WallStreetJournalAPIClient()
        
        let articleFetchCompletion: ([Article]?) -> () = { (responseArticles: [Article]?) in
            print("Articles delivered to View Controller")
            if let art = responseArticles {
                self.articles = art
                self.dataTableView.reloadData()
            }
            
        }
        client.getData(completion: articleFetchCompletion) //executed first
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return articles.count
        // return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
        let article = articles[indexPath.row]
        cell.articleTitleLabel.text = article.title
        cell.articleDescriptionLabel.text = article.description
      //  cell.articleImageView?.image = UIImage(named: article.urlToImage)
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
