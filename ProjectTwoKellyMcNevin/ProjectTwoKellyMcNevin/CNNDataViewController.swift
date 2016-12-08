//
//  CNNDataViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/7/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit
import SafariServices



class CNNDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var cnnDataTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBAction func browseButtonWasTappe(_ sender: Any) {
        
        dataPickerView.isHidden = false
        toolBar.isHidden = false
        toolBar.isUserInteractionEnabled = true
    }
    
    var cnnArticles = [Article]()
    var cnnFilteredResults: [Article]?
    
    @IBOutlet weak var toolBar: UIToolbar!
    
    @IBOutlet weak var dataPickerView: UIPickerView!
    
    @IBAction func cancelButtonWasTapped(_ sender: Any) {
        
        dataPickerView.isHidden = true
        toolBar.isHidden = true
        toolBar.isUserInteractionEnabled = false

        
    }
    @IBOutlet weak var searchButton: UIBarButtonItem!
    
    @IBAction func doneButtonWasTapped(_ sender: Any) {
        
        dataPickerView.isHidden = true
        toolBar.isHidden = true
        toolBar.isUserInteractionEnabled = false
    }
    
    var selectedCell: CNNDataTableViewCell?
    var selectedListIndex: Int?
    
    let cnnClient = CNNAPIClient()
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        if searchText != "" {
            cnnFilteredResults = []
            
            for article in cnnArticles {
                if article.title.contains(searchBar.text!) {
                    cnnFilteredResults?.append(article)
                }
                
                print(article)
            }
        }
        else {
            cnnFilteredResults = nil
        }
        
        cnnDataTableView.reloadData()
        
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
        
            if let cnnFilteredResults = self.cnnFilteredResults {
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
    
        cnnClient.getCNNData(completion: articleFetchCompletion)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let cnnFilteredResults = cnnFilteredResults {
            return cnnFilteredResults.count
        }
        else {
            return cnnArticles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CNNDataTableViewCell", for: indexPath) as! CNNDataTableViewCell
        if let cnnFilteredResults = cnnFilteredResults {
         
            let filteredArticle = cnnFilteredResults[indexPath.row]
            cell.cnnTitleLabel.text = filteredArticle.title
            cell.cnnDescriptionView.text = filteredArticle.description
            cell.articleImageViewURL = filteredArticle.urlToImage
            return cell
        }
        else {
    
            let cnnArticle = cnnArticles[indexPath.row]
            cell.cnnTitleLabel.text = cnnArticle.title
            cell.cnnDescriptionView.text = cnnArticle.description
            cell.articleImageViewURL = cnnArticle.urlToImage
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! CNNDataTableViewCell

        if cell === selectedCell {
            cell.backgroundColor = UIColor.white
            selectedCell = nil
        }
        else {
            cell.backgroundColor = UIColor.lightGray
            
            if let cnnFilteredResults = cnnFilteredResults {
                let filteredArticle = cnnFilteredResults[indexPath.row]
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
                
                if let cnnFilteredResults = self.cnnFilteredResults {
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
            
            cnnClient.getCNNData(category: category, completion: articleFetchCompletion)
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
