//
//  SearchViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/15/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit
import SafariServices

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var searchDataTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchArticles = [Article]()
    var filteredSearchResults: [Article]?
    var selectedCell: SearchTableViewCell?


    let client = APIClient()

    //Filters the search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        if searchText != "" {
            filteredSearchResults = []
            
            for article in searchArticles {
                if article.title.contains(searchBar.text!) {
                    filteredSearchResults?.append(article)
                }
                
                print(article)
            }
        }
        else {
            filteredSearchResults = nil
        }
        
        searchDataTableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        self.searchBar.showsCancelButton = true
        self.searchBar.becomeFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    
    //Function that calls API based on selectedSource in slider menu
    func loadSearchTableViewURLFromBar() {
        
        let articleFetchCompletion: ([Article]?) -> () = { (responseArticles: [Article]?) in
            print("Articles delivered to View Controller")
            
            if self.filteredSearchResults != nil {
                if let filteredArt = responseArticles {
                    self.searchArticles = filteredArt
                    self.searchDataTableView.reloadData()
                }
            }
            
            if let art = responseArticles {
                self.searchArticles = art
                DispatchQueue.main.async {
                    self.searchDataTableView.reloadData()
                }
            }
        }
            client.searchAll(completion: articleFetchCompletion)
            
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSearchTableViewURLFromBar()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let filteredResults = filteredSearchResults {
            return filteredResults.count
        }
        else {
            return searchArticles.count
        }
    }
    
    //IMPLEMENTING TABLE VIEW
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        if let filteredResults = filteredSearchResults {
            
            let filteredArticle = filteredResults[indexPath.row]
            cell.searchTitleLabel.text = filteredArticle.title
            cell.searchDescriptionView.text = filteredArticle.description
            cell.searchArticleImageViewURL = filteredArticle.urlToImage
            return cell
        }
        else {
            
            let article = searchArticles[indexPath.row]
            cell.searchTitleLabel.text = article.title
            cell.searchDescriptionView.text = article.description
            cell.searchArticleImageViewURL = article.urlToImage
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! SearchTableViewCell
        
        if cell === selectedCell {
            cell.backgroundColor = UIColor.white
            selectedCell = nil
        }
        else {
            cell.backgroundColor = UIColor.lightGray
            
            if let filteredResults = filteredSearchResults {
                let filteredArticle = filteredResults[indexPath.row]
                let svc2 = SFSafariViewController(url: URL(string: filteredArticle.urlToArticle)!)
                print(filteredArticle.urlToArticle)
                self.navigationController?.pushViewController(svc2, animated: true)
            }
            else
            {
                let article = searchArticles[indexPath.row]
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
