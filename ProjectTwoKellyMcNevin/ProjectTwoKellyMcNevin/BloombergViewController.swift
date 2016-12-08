//
//  BloombergViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/7/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit
import SafariServices

class BloombergViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var bloombergArticles = [Article]()
    var bloombergFilteredResults: [Article]?
    var selectedCell: BloombergTableViewCell?
    var selectedListIndex: Int?
    let bloombergClient = BloombergAPIClient()
    
    @IBAction func browseButtonWasTapped(_ sender: Any) {
        dataPickerView.isHidden = false
        toolBar.isHidden = false
        toolBar.isUserInteractionEnabled = true
    }
    
    @IBOutlet weak var dataPickerView: UIPickerView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBAction func cancelBarWasTapped(_ sender: Any) {
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
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        if searchText != "" {
            bloombergFilteredResults = []
            
            for article in bloombergArticles {
                if article.title.contains(searchBar.text!) {
                    bloombergFilteredResults?.append(article)
                }
                
                print(article)
            }
        }
        else {
            bloombergFilteredResults = nil
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
            
            if let bloombergFilteredResults = self.bloombergFilteredResults {
                if let filteredArt = responseArticles {
                    self.bloombergArticles = filteredArt
                    self.tableView.reloadData()
                }
            }
            else {
                if let art = responseArticles {
                    self.bloombergArticles = art
                    self.tableView.reloadData()
                }
            }
        }
        
        bloombergClient.getBloombergData(completion: articleFetchCompletion)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let bloombergFilteredResults = bloombergFilteredResults {
            return bloombergFilteredResults.count
        }
        else {
            return bloombergArticles.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BloombergTableViewCell", for: indexPath) as! BloombergTableViewCell
        if let bloombergFilteredResults = bloombergFilteredResults {
            
            let filteredArticle = bloombergFilteredResults[indexPath.row]
            cell.titleLabel.text = filteredArticle.title
            cell.articleDescriptionView.text = filteredArticle.description
            cell.articleImageViewURL = filteredArticle.urlToImage
            return cell
        }
        else {
            
            let bloombergArticle = bloombergArticles[indexPath.row]
            cell.titleLabel.text = bloombergArticle.title
            cell.articleDescriptionView.text = bloombergArticle.description
            cell.articleImageViewURL = bloombergArticle.urlToImage
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! BloombergTableViewCell
        
        if cell === selectedCell {
            cell.backgroundColor = UIColor.white
            selectedCell = nil
        }
        else {
            cell.backgroundColor = UIColor.lightGray
            
            if let bloombergFilteredResults = bloombergFilteredResults {
                let filteredArticle = bloombergFilteredResults[indexPath.row]
                let svc2 = SFSafariViewController(url: URL(string: filteredArticle.urlToArticle)!)
                print(filteredArticle.urlToArticle)
                self.navigationController?.pushViewController(svc2, animated: true)
            }
            else
            {
                let article = bloombergArticles[indexPath.row]
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
            
            if let bloombergFilteredResults = self.bloombergFilteredResults {
                if let filteredArt = responseArticles {
                    self.bloombergArticles = filteredArt
                    self.tableView.reloadData()
                }
            }
            else {
                if let art = responseArticles {
                    self.bloombergArticles = art
                    self.tableView.reloadData()
                }
            }
        }
        
        bloombergClient.getBloombergData(category: category, completion: articleFetchCompletion)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
