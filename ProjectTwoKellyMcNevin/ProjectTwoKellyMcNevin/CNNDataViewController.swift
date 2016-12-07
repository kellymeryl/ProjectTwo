//
//  CNNDataViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/7/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit
import SafariServices

class CNNDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var cnnDataTableView: UITableView!
    
    var cnnArticles = [Article]()
    var cnnFilteredResults: [Article]?
    
    var selectedCell: CNNDataTableViewCell?
    var selectedListIndex: Int?
    
    let cnnClient = CNNAPIClient()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let articleFetchCompletion: ([Article]?) -> () = { (responseArticles: [Article]?) in
            print("Articles delivered to View Controller")
        
            if let art = responseArticles {
                self.cnnArticles = art
            }
            self.cnnDataTableView.reloadData()

        }
        cnnClient.getCNNData(completion: articleFetchCompletion)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print(cnnArticles.count)
        return cnnArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CNNDataTableViewCell", for: indexPath) as! CNNDataTableViewCell
        let cnnArticle = cnnArticles[indexPath.row]
        cell.cnnTitleLabel.text = cnnArticle.title
        cell.cnnDescriptionView.text = cnnArticle.description
      //  cell.articleImageViewURL = cnnArticle.urlToImage
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! CNNDataTableViewCell

        if cell === selectedCell {
            cell.backgroundColor = UIColor.white
            selectedCell = nil
        }
        else {
            cell.backgroundColor = UIColor.lightGray
            let article = cnnArticles[indexPath.row]
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
