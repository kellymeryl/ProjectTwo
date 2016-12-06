//
//  MainViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/5/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit
import SafariServices

var articles = [Article]()
var filteredResults: [Article] = []

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    @IBOutlet weak var dataTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchBarWasTapped = false
    
    @IBAction func browseButtonWasTapped(_ sender: Any) {
        categoryPickerView.isHidden = false
        print("hello")
    }
    
    var pickerData = ["Business", "Entertainment", "Gaming", "General", "Music", "Science and Nature", "Sport", "Technology"]
    
    var selectedCell: DataTableViewCell?
    var selectedListIndex: Int?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        searchBarWasTapped = true
        print("searchText \(searchText)")
        
        for article in articles{
            if article.title.contains(searchBar.text!) {
                filteredResults.append(article)
            }
            
            print(article)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryPickerView.dataSource = self
        self.categoryPickerView.delegate = self
        
        categoryPickerView.isHidden = true
        
        let client = WallStreetJournalAPIClient()
        
        let articleFetchCompletion: ([Article]?) -> () = { (responseArticles: [Article]?) in
            print("Articles delivered to View Controller")
            if let art = responseArticles {
                articles = art
                self.dataTableView.reloadData()
            }
            
        }
        client.getData(completion: articleFetchCompletion)
    }
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
    return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
    let article = articles[indexPath.row]
    cell.articleTitleLabel.text = article.title
    cell.articleDescriptionTextField.text = article.description
    cell.articleImageViewURL = article.urlToImage
    return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let cell = tableView.cellForRow(at: indexPath) as! DataTableViewCell
    
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

