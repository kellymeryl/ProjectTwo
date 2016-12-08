//
//  FinancialTimesViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/7/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit
import SafariServices

class FinancialTimesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var financialTimesArticles = [Article]()
    var financialFilteredResults: [Article]?
    var selectedCell: FinancialTimesTableViewCell?
    var selectedListIndex: Int?
    
    let financialTimesClient = FinancialTimesAPIClient()

    
    @IBOutlet weak var spaceButton: UIBarButtonItem!
    @IBAction func cancelButtonWasTapped(_ sender: Any) {
        dataPickerView.isHidden = true
        toolBar.isHidden = true
        toolBar.isUserInteractionEnabled = false
    }
    @IBAction func doneButtonWasTapped(_ sender: Any) {
        dataPickerView.isHidden = true
        toolBar.isHidden = true
        toolBar.isUserInteractionEnabled = false
    }
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var dataPickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func browseButtonWasTapped(_ sender: Any) {
        dataPickerView.isHidden = false
        toolBar.isHidden = false
        toolBar.isUserInteractionEnabled = true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        if searchText != "" {
            financialFilteredResults = []
            
            for article in financialTimesArticles {
                if article.title.contains(searchBar.text!) {
                    financialFilteredResults?.append(article)
                }
                
                print(article)
            }
        }
        else {
            financialFilteredResults = nil
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
            
            if let financialFilteredResults = self.financialFilteredResults {
                if let filteredArt = responseArticles {
                    self.financialTimesArticles = filteredArt
                    self.tableView.reloadData()
                }
            }
            else {
                if let art = responseArticles {
                    self.financialTimesArticles = art
                    self.tableView.reloadData()
                }
            }
        }
        
        financialTimesClient.getFinancialTimesData(completion: articleFetchCompletion)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let financialFilteredResults = financialFilteredResults {
            return financialFilteredResults.count
        }
        else {
            return financialTimesArticles.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FinancialTimesTableViewCell", for: indexPath) as! FinancialTimesTableViewCell
        if let financialFilteredResults = financialFilteredResults {
            
            let filteredArticle = financialFilteredResults[indexPath.row]
            cell.titleLabel.text = filteredArticle.title
            cell.descriptionView.text = filteredArticle.description
            cell.articleImageViewURL = filteredArticle.urlToImage
            return cell
        }
        else {
            
            let financialTimesArticle = financialTimesArticles[indexPath.row]
            cell.titleLabel.text = financialTimesArticle.title
            cell.descriptionView.text = financialTimesArticle.description
            cell.articleImageViewURL = financialTimesArticle.urlToImage
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FinancialTimesTableViewCell
        
        if cell === selectedCell {
            cell.backgroundColor = UIColor.white
            selectedCell = nil
        }
        else {
            cell.backgroundColor = UIColor.lightGray
            
            if let financialFilteredResults = financialFilteredResults {
                let filteredArticle = financialFilteredResults[indexPath.row]
                let svc2 = SFSafariViewController(url: URL(string: filteredArticle.urlToArticle)!)
                print(filteredArticle.urlToArticle)
                self.navigationController?.pushViewController(svc2, animated: true)
            }
            else
            {
                let article = financialTimesArticles[indexPath.row]
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
            
            if let financialFilteredResults = self.financialFilteredResults {
                if let filteredArt = responseArticles {
                    self.financialTimesArticles = filteredArt
                    self.tableView.reloadData()
                }
            }
            else {
                if let art = responseArticles {
                    self.financialTimesArticles = art
                    self.tableView.reloadData()
                }
            }
        }
        
        financialTimesClient.getFinancialTimesData(category: category, completion: articleFetchCompletion)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
