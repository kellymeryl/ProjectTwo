//
//  BusinessInsiderViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/7/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit
import SafariServices

class BusinessInsiderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var businessInsiderArticles = [Article]()
    var businessInsiderFilteredResults: [Article]?
    let businessInsiderClient = BusinessInsiderAPIClient()
    
    var selectedCell: BusinessDataTableViewCell?
    var selectedListIndex: Int?
    
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBAction func cancelButtonWasTapped(_ sender: Any) {
        
        dataPickerView.isHidden = true
        toolBar.isHidden = true
        toolBar.isUserInteractionEnabled = false
        
    }
    @IBOutlet weak var spaceButtonWasTapped: UIBarButtonItem!
    
    @IBAction func doneButtonWasTapped(_ sender: Any) {
        dataPickerView.isHidden = true
        toolBar.isHidden = true
        toolBar.isUserInteractionEnabled = false
    }
    @IBOutlet weak var dataPickerView: UIPickerView!
    
    @IBAction func browseButtonWasTapped(_ sender: Any) {
        dataPickerView.isHidden = false
        toolBar.isHidden = false
        toolBar.isUserInteractionEnabled = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        if searchText != "" {
            businessInsiderFilteredResults = []
            
            for article in businessInsiderArticles {
                if article.title.contains(searchBar.text!) {
                    businessInsiderFilteredResults?.append(article)
                }
                
                print(article)
            }
        }
        else {
            businessInsiderFilteredResults = nil
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
            
            if let businessInsiderFilteredResults = self.businessInsiderFilteredResults {
                if let filteredArt = responseArticles {
                    self.businessInsiderArticles = filteredArt
                    self.dataTableView.reloadData()
                }
            }
            else {
                if let art = responseArticles {
                    self.businessInsiderArticles = art
                    self.dataTableView.reloadData()
                }
            }
        }
        
        businessInsiderClient.getBusinessInsiderData(completion: articleFetchCompletion)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let businessInsiderFilteredResults = businessInsiderFilteredResults {
            return businessInsiderFilteredResults.count
        }
        else {
            return businessInsiderArticles.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessDataTableViewCell", for: indexPath) as! BusinessDataTableViewCell
        if let businessInsiderFilteredResults = businessInsiderFilteredResults {
            
            let filteredArticle = businessInsiderFilteredResults[indexPath.row]
            cell.articleTitle.text = filteredArticle.title
            cell.articleDescriptionView.text = filteredArticle.description
            cell.articleImageViewURL = filteredArticle.urlToImage
            return cell
        }
        else {
            
            let businessInsiderArticle = businessInsiderArticles[indexPath.row]
            cell.articleTitle.text = businessInsiderArticle.title
            cell.articleDescriptionView.text = businessInsiderArticle.description
            cell.articleImageViewURL = businessInsiderArticle.urlToImage
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! BusinessDataTableViewCell
        
        if cell === selectedCell {
            cell.backgroundColor = UIColor.white
            selectedCell = nil
        }
        else {
            cell.backgroundColor = UIColor.lightGray
            
            if let businessInsiderFilteredResults = businessInsiderFilteredResults {
                let filteredArticle = businessInsiderFilteredResults[indexPath.row]
                let svc2 = SFSafariViewController(url: URL(string: filteredArticle.urlToArticle)!)
                print(filteredArticle.urlToArticle)
                self.navigationController?.pushViewController(svc2, animated: true)
            }
            else
            {
                let article = businessInsiderArticles[indexPath.row]
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
            
            if let businessInsiderFilteredResults = self.businessInsiderFilteredResults {
                if let filteredArt = responseArticles {
                    self.businessInsiderArticles = filteredArt
                    self.dataTableView.reloadData()
                }
            }
            else {
                if let art = responseArticles {
                    self.businessInsiderArticles = art
                    self.dataTableView.reloadData()
                }
            }
        }
        
       businessInsiderClient.getBusinessInsiderData(category: category, completion: articleFetchCompletion)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
