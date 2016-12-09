//
//  EconomistViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/7/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit
import Foundation
import SafariServices

class EconomistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var economistArticles = [Article]()
    var economistFilteredResults: [Article]?

    var selectedCell: EconomistTableViewCell?
    var selectedListIndex: Int?
    
    let economistClient = EconomistAPIClient()

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dataPickerView: UIPickerView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBAction func browseButtonWasTapped(_ sender: Any) {
        dataPickerView.isHidden = false
        toolBar.isHidden = false
        toolBar.isUserInteractionEnabled = true
    }
    @IBAction func cancelButtonWasTapped(_ sender: Any) {
        dataPickerView.isHidden = true
        toolBar.isHidden = true
        toolBar.isUserInteractionEnabled = false
    }
    @IBOutlet weak var spaceButton: UIBarButtonItem!
    @IBAction func doneButtonWasTapped(_ sender: Any) {
        dataPickerView.isHidden = true
        toolBar.isHidden = true
        toolBar.isUserInteractionEnabled = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        if searchText != "" {
            economistFilteredResults = []
            
            for article in economistArticles {
                if article.title.contains(searchBar.text!) {
                    economistFilteredResults?.append(article)
                }
                
                print(article)
            }
        }
        else {
            economistFilteredResults = nil
        }
        
        tableView.reloadData()
        
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
            
            if let economistFilteredResults = self.economistFilteredResults {
                if let filteredArt = responseArticles {
                    self.economistArticles = filteredArt
                    self.tableView.reloadData()
                }
            }
            else {
                if let art = responseArticles {
                    self.economistArticles = art
                    self.tableView.reloadData()
                }
            }
        }
        
        economistClient.getEconomistData(completion: articleFetchCompletion)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let economistFilteredResults = economistFilteredResults {
            return economistFilteredResults.count
        }
        else {
            return economistArticles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EconomistTableViewCell", for: indexPath) as! EconomistTableViewCell
        if let economistFilteredResults = economistFilteredResults {
            
            let filteredArticle = economistFilteredResults[indexPath.row]
            cell.articleTitle.text = filteredArticle.title
            cell.articleDescriptionView.text = filteredArticle.description
            cell.articleImageViewURL = filteredArticle.urlToImage
            return cell
        }
        else {
            
            let economistArticle = economistArticles[indexPath.row]
            cell.articleTitle.text = economistArticle.title
            cell.articleDescriptionView.text = economistArticle.description
            cell.articleImageViewURL = economistArticle.urlToImage
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! EconomistTableViewCell
        
        if cell === selectedCell {
            cell.backgroundColor = UIColor.white
            selectedCell = nil
        }
        else {
            cell.backgroundColor = UIColor.lightGray
            
            if let economistFilteredResults = economistFilteredResults {
                let filteredArticle = economistFilteredResults[indexPath.row]
                let svc2 = SFSafariViewController(url: URL(string: filteredArticle.urlToArticle)!)
                print(filteredArticle.urlToArticle)
                self.navigationController?.pushViewController(svc2, animated: true)
            }
            else
            {
                let article = economistArticles[indexPath.row]
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
            
            if let economistFilteredResults = self.economistFilteredResults {
                if let filteredArt = responseArticles {
                    self.economistArticles = filteredArt
                    self.tableView.reloadData()
                }
            }
            else {
                if let art = responseArticles {
                    self.economistArticles = art
                    self.tableView.reloadData()
                }
            }
        }
        
        economistClient.getEconomistData(category: category, completion: articleFetchCompletion)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}