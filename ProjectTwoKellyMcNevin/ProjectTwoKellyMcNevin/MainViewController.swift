//
//  MainViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/5/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit
import SafariServices

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var articles = [Article]()
    var searchResults = [Article]()
    var searchAllArticles = [Article]()
    var filteredResults: [Article]?
    
    var selectedIndex: Int?
    var articleTypeName: String?
    var resultSearchController = UISearchController()
    var selectedCell: DataTableViewCell?

    var allArticles = [Article]()
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var sourcesArray = ["the-wall-street-journal", "business-insider", "the-economist", "cnn", "usa-today", "bloomberg-news", "financial-times"]
    
    let client = APIClient()

    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBAction func cancelButtonWasTapped(_ sender: Any) {
        toolBar.isHidden = true
        toolBar.isUserInteractionEnabled = false
        categoryPickerView.isHidden = true
    }
    
    func setDateLabel() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let convertedDate = dateFormatter.string(from: date)
        dateLabel.text = convertedDate
    }
    
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    @IBOutlet weak var dataTableView: UITableView!
    
  //  @IBOutlet weak var searchBar: UISearchBar!
    
    var selectedSource: String = "the-wall-street-journal"
    //var sourcesArray = [String?]()
    

    
    var pickerData = ["Business", "Entertainment", "Gaming", "General", "Music", "Science and Nature", "Sport", "Technology"]
    
    var selectedListIndex: Int?
    
    //Filters the search bar
/*    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        if searchText != "" {
            filteredResults = []
            
            for article in articles {
                if article.title.contains(searchBar.text!) {
                    filteredResults?.append(article)
                }
                
                print(article)
            }
        }
        else {
            filteredResults = nil
        }
        
        dataTableView.reloadData()
        
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
    
*/
    //Function that calls API based on selectedSource in slider menu
    func loadTableViewURLFromBar() {
        
        //todo if selectedSource is source all SearchAll and use the same articleFetchCompletion
        
        let articleFetchCompletion: ([Article]?) -> () = { (responseArticles: [Article]?) in
            print("Articles delivered to View Controller")
            
            if self.filteredResults != nil {
                if let filteredArt = responseArticles {
                    self.articles = filteredArt
                    self.dataTableView.reloadData()
                }
            }
            
            if let art = responseArticles {
                self.articles = art
                DispatchQueue.main.async {
                    self.dataTableView.reloadData()
                }
            }
        }
        
    
    if selectedSource == "search all" {
            
        client.searchAll(completion: articleFetchCompletion)
 
    }
    else {
        client.getData(newsSource: selectedSource, category: .general, completion: articleFetchCompletion)
        }
    }

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setDateLabel()
        
        self.categoryPickerView.dataSource = self
        self.categoryPickerView.delegate = self
        categoryPickerView.isHidden = true
        toolBar.isHidden = true
        toolBar.isUserInteractionEnabled = false
        
        loadTableViewURLFromBar()
    }
    
      //Implementing TABLE VIEW ------------------------------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let filteredResults = filteredResults {
            return filteredResults.count
        }
        else {
            return articles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
        
        if let filteredResults = filteredResults {
            
            let filteredArticle = filteredResults[indexPath.row]
            cell.articleTitleLabel.text = filteredArticle.title
            cell.articleDescriptionTextField.text = filteredArticle.description
            cell.articleImageViewURL = filteredArticle.urlToImage
            return cell
        }
        else {
            
            let article = articles[indexPath.row]
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
            
            if let filteredResults = filteredResults {
                let filteredArticle = filteredResults[indexPath.row]
                let svc2 = SFSafariViewController(url: URL(string: filteredArticle.urlToArticle)!)
                print(filteredArticle.urlToArticle)
                self.navigationController?.pushViewController(svc2, animated: true)
            }
            else
            {
                let article = articles[indexPath.row]
                let svc = SFSafariViewController(url: URL(string: article.urlToArticle)!)
                print(article.urlToArticle)
                self.navigationController?.pushViewController(svc, animated: true)
            }
            
            selectedCell?.backgroundColor = UIColor.white
            selectedCell = cell
        }
    }
    
    //IMPLEMENTING PICKER VIEW---------------------------------------------------------------------------
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.asArray().count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Category.asArray()[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let category = Category.asArray()[row]
        
        let articleFetchCompletion: ([Article]?) -> () = { (responseArticles: [Article]?) in
            print("Articles delivered to View Controller")
            
            if let filteredResults = self.filteredResults {
                if let filteredArt = responseArticles {
                    self.articles = filteredArt
                    self.dataTableView.reloadData()
                }
            }
            else {
                if let art = responseArticles {
                    self.articles = art
                    self.dataTableView.reloadData()
                }
            }
            
        }
        client.getData(category: category, completion: articleFetchCompletion)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

