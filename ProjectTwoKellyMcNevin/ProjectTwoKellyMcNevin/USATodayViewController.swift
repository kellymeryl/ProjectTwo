//
//  USATodayViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/7/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit
import SafariServices


class USATodayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var usaTodayArticles = [Article]()
    var usaTodayFilteredResults: [Article]?

    @IBAction func doneButtonWasTapped(_ sender: Any) {
        dataPickerView.isHidden = true
        toolBar.isHidden = true
        toolBar.isUserInteractionEnabled = false
    }
    @IBOutlet weak var spaceButton: UIBarButtonItem!
    @IBAction func closeButtonWasTapped(_ sender: Any) {
        
        dataPickerView.isHidden = true
        toolBar.isHidden = true
        toolBar.isUserInteractionEnabled = false
    }
    
    var selectedCell: USATodayDataTableViewCell?
    var selectedListIndex: Int?

    let usaTodayClient = USATodayAPIClient()
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var dataPickerView: UIPickerView!
    
    @IBAction func browseButtonWasTapped(_ sender: Any) {
        dataPickerView.isHidden = false
        toolBar.isHidden = false
        toolBar.isUserInteractionEnabled = true
    }
    @IBOutlet weak var dataTableView: UITableView!

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        if searchText != "" {
            usaTodayFilteredResults = []
            
            for article in usaTodayArticles {
                if article.title.contains(searchBar.text!) {
                    usaTodayFilteredResults?.append(article)
                }
                
                print(article)
            }
        }
        else {
            usaTodayFilteredResults = nil
        }
        
        dataTableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.dataPickerView.dataSource = self
        self.dataPickerView.delegate = self
        toolBar.isHidden = true
        toolBar.isUserInteractionEnabled = false
        dataPickerView.isHidden = true
        
        let articleFetchCompletion: ([Article]?) -> () = { (responseArticles: [Article]?) in
            print("Articles delivered to View Controller")
            
            if let usaTodayFilteredResults = self.usaTodayFilteredResults {
                if let filteredArt = responseArticles {
                    self.usaTodayArticles = filteredArt
                    self.dataTableView.reloadData()
                }
            }
            else {
                if let art = responseArticles {
                    self.usaTodayArticles = art
                    self.dataTableView.reloadData()
                }
            }
        }
        
        usaTodayClient.getUSATodayData(completion: articleFetchCompletion)
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let usaTodayFilteredResults = usaTodayFilteredResults {
            return usaTodayFilteredResults.count
        }
        else {
            return usaTodayArticles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "USATodayDataTableViewCell", for: indexPath) as! USATodayDataTableViewCell
        if let usaTodayFilteredResults = usaTodayFilteredResults {
            
            let filteredArticle = usaTodayFilteredResults[indexPath.row]
            cell.articleTitleView.text = filteredArticle.title
            cell.articleDescriptionView.text = filteredArticle.description
            cell.articleImageViewURL = filteredArticle.urlToImage
            return cell
        }
        else {
            
            let usaTodayArticle = usaTodayArticles[indexPath.row]
            cell.articleTitleView.text = usaTodayArticle.title
            cell.articleDescriptionView.text = usaTodayArticle.description
            cell.articleImageViewURL = usaTodayArticle.urlToImage
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! USATodayDataTableViewCell
        
        if cell === selectedCell {
            cell.backgroundColor = UIColor.white
            selectedCell = nil
        }
        else {
            cell.backgroundColor = UIColor.lightGray
            
            if let usaTodayFilteredResults = usaTodayFilteredResults {
                let filteredArticle = usaTodayFilteredResults[indexPath.row]
                let svc2 = SFSafariViewController(url: URL(string: filteredArticle.urlToArticle)!)
                print(filteredArticle.urlToArticle)
                self.navigationController?.pushViewController(svc2, animated: true)
            }
            else
            {
                let article = usaTodayArticles[indexPath.row]
                let svc = SFSafariViewController(url: URL(string: article.urlToArticle)!)
                print(article.urlToArticle)
                self.navigationController?.pushViewController(svc, animated: true)
                
                
                selectedCell?.backgroundColor = UIColor.white
                selectedCell = cell
            }
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
            
            if let usaTodayFilteredResults = self.usaTodayFilteredResults {
                if let filteredArt = responseArticles {
                    self.usaTodayArticles = filteredArt
                    self.dataTableView.reloadData()
                }
            }
            else {
                if let art = responseArticles {
                    self.usaTodayArticles = art
                    self.dataTableView.reloadData()
                }
            }
        }
        
        usaTodayClient.getUSATodayData(category: category, completion: articleFetchCompletion)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
