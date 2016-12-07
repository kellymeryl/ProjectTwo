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
    var filteredResults: [Article]?
    
    
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    @IBOutlet weak var dataTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBAction func browseButtonWasTapped(_ sender: Any) {
        categoryPickerView.isHidden = false
        print("hello")
    }
    
    var pickerData = ["Business", "Entertainment", "Gaming", "General", "Music", "Science and Nature", "Sport", "Technology"]
    
    var selectedCell: DataTableViewCell?
    var selectedListIndex: Int?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryPickerView.dataSource = self
        self.categoryPickerView.delegate = self
        
        categoryPickerView.isHidden = true
        
        let client = WallStreetJournalAPIClient()
        
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
        client.getData(completion: articleFetchCompletion)
    }
    
    
    
    
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
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if row == 0{
            categoryPicked = "business"
            print("Business")
        }
        else if row == 1{
            categoryPicked = "entertainment"
            print("Entertainment")
        }
        else if row == 2{
            categoryPicked = "gaming"
            print("Gaming")
        }
        else if row == 3{
            categoryPicked = "general"
            print("General")
        }
        else if row == 4{
            categoryPicked = "music"
            print("Music")
        }
        else if row == 5{
            categoryPicked = "science-and-nature"
            print("Science and Nature")
        }
        else if row == 6{
            categoryPicked = "sport"
            print("Sport")
        }
        else if row == 7{
            categoryPicked = "technology"
            print("Technology")
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

