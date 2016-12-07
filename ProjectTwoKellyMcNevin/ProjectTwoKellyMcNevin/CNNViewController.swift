//
//  CNNViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/7/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit

class CNNViewController: UIViewController {
    
    var cnnArticles = [Article]()
    var cnnFilteredArticles : [Article]?
    
    let cnnClient = CNNAPIClient()

    @IBOutlet weak var cnnSearchBar: UISearchBar!
    @IBOutlet weak var cnnDataTableView: UITableView!
    
    
    @IBAction func cnnBrowseButtonWasTapped(_ sender: Any) {
        
        
    }
    
    var pickerData = ["Business", "Entertainment", "Gaming", "General", "Music", "Science and Nature", "Sport", "Technology"]
    
    var selectedCell: CNNTableViewCell?
    var selectedListIndex: Int?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        if searchText != "" {
            cnnFilteredArticles = []
            
            for article in cnnArticles {
                if article.title.contains(cnnSearchBar.text!) {
                    cnnFilteredArticles?.append(article)
                }
                
                print(article)
            }
        }
        else {
            cnnFilteredArticles = nil
        }
        
        cnnDataTableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let articleFetchCompletion: ([Article]?) -> () = { (responseArticles: [Article]?) in
            print("Articles delivered to View Controller")
            
            if let cnnFilteredArticles = self.cnnFilteredArticles {
                if let filteredArt = responseArticles {
                    self.cnnArticles = filteredArt
                    self.cnnDataTableView.reloadData()
                }
            }
            else {
                if let art = responseArticles {
                    self.cnnArticles = art
                    self.cnnDataTableView.reloadData()
                }
            }
            
        }
        cnnClient.getData(completion: articleFetchCompletion)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let cnnFilteredArticles = cnnFilteredArticles {
            return cnnFilteredArticles.count
        }
        else {
            return cnnArticles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
        
        if let cnnFilteredArticles = cnnFilteredArticles {
            
            let filteredArticle = cnnFilteredArticles[indexPath.row]
            cell.cnnArticleTitle.text = filteredArticle.title
            cell.cnnDescriptionTextfield.text = filteredArticle.description
            cell.cnnImageView = filteredArticle.urlToImage
            return cell
        }
        else {
            
            let article = cnnArticles[indexPath.row]
            cell.articleTitleLabel.text = article.title
            cell.articleDescriptionTextField.text = article.description
            cell.articleImageViewURL = article.urlToImage
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! DataTableViewCell
        
        if cell === selectedCell {
            cell.backgroundColor = UIColor.white
            selectedCell = nil
        }
        else {
            cell.backgroundColor = UIColor.lightGray
            
            if let cnnFilteredArticles = cnnFilteredArticles {
                let filteredArticle = cnnFilteredArticles[indexPath.row]
                let svc2 = SFSafariViewController(url: URL(string: filteredArticle.urlToArticle)!)
                print(filteredArticle.urlToArticle)
                self.navigationController?.pushViewController(svc2, animated: true)
            }
            else
            {
                let article = cnnArticles[indexPath.row]
                let svc = SFSafariViewController(url: URL(string: article.urlToArticle)!)
                print(article.urlToArticle)
                self.navigationController?.pushViewController(svc, animated: true)
            }
            
            selectedCell?.backgroundColor = UIColor.white
            selectedCell = cell
        }
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
 

}
