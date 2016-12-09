//
//  CNNViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/7/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit
import SafariServices
class CNNViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var cnnPickerView: UIPickerView!
    @IBOutlet weak var cnnToolBar: UIToolbar!
    @IBOutlet weak var cnnSpaceButton: UIBarButtonItem!
    
    @IBAction func cnnCancelButton(_ sender: Any) {
        
       cnnPickerView.isHidden = true
       cnnToolBar.isHidden = true
       cnnToolBar.isUserInteractionEnabled = false
    }
    
    @IBAction func cnnDoneButton(_ sender: Any) {
        
        cnnPickerView.isHidden = true
        cnnToolBar.isHidden = true
        cnnToolBar.isUserInteractionEnabled = false
    }
    
    
    var cnnArticles = [Article]()
    var cnnFilteredArticles : [Article]?
    
    let cnnClient = CNNAPIClient()

    @IBOutlet weak var cnnSearchBar: UISearchBar!
    @IBOutlet weak var cnnDataTableView: UITableView!
    
    
    @IBAction func cnnBrowseButtonWasTapped(_ sender: Any) {
        
        
    }
    
    var pickerData = ["Business", "Entertainment", "Gaming", "General", "Music", "Science and Nature", "Sport", "Technology"]
    
    var selectedCell: CNNTableViewCell?
    var selectedListIndex: Int?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        if searchText != "" {
            cnnFilteredArticles = []
            
            for article in cnnArticles {
                if article.title.contains(cnnSearchBar.text!) {
                    cnnFilteredArticles?.append(article)
                }
                
                print(article)
            }
        }
        else {
            cnnFilteredArticles = nil
        }
        
        cnnDataTableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cnnPickerView.dataSource = self
        self.cnnPickerView.delegate = self
        cnnToolBar.isHidden = true
        cnnToolBar.isUserInteractionEnabled = false
        cnnPickerView.isHidden = true
        
        let articleFetchCompletion: ([Article]?) -> () = { (responseArticles: [Article]?) in
            print("Articles delivered to View Controller")
            
            if let cnnFilteredArticles = self.cnnFilteredArticles {
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
        cnnClient.getData(completion: articleFetchCompletion)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let cnnFilteredArticles = cnnFilteredArticles {
            return cnnFilteredArticles.count
        }
        else {
            print(cnnArticles.count)

            return cnnArticles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CNNTableViewCell", for: indexPath) as! CNNTableViewCell
        
        if let cnnFilteredArticles = cnnFilteredArticles {
            
            let filteredArticle = cnnFilteredArticles[indexPath.row]
            cell.cnnArticleTitle.text = filteredArticle.title
            cell.cnnDescriptionTextfield.text = filteredArticle.description
            cell.articleImageViewURL = filteredArticle.urlToImage
            return cell
        }
        else {
            
            let article = cnnArticles[indexPath.row]
            cell.cnnArticleTitle.text = article.title
            cell.cnnDescriptionTextfield.text = article.description
            cell.articleImageViewURL = article.urlToImage
            return cell
            print(cell)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! CNNTableViewCell
        
        if cell === selectedCell {
            cell.backgroundColor = UIColor.white
            selectedCell = nil
        }
        else {
            cell.backgroundColor = UIColor.lightGray
            
        /*    if let cnnFilteredArticles = cnnFilteredArticles {
                let filteredArticle = cnnFilteredArticles[indexPath.row]
                let svc2 = SFSafariViewController(url: URL(string: filteredArticle.urlToArticle)!)
                print(filteredArticle.urlToArticle)
                self.navigationController?.pushViewController(svc2, animated: true)
            }
            else
            {*/
                let article = cnnArticles[indexPath.row]
                let svc = SFSafariViewController(url: URL(string: article.urlToArticle)!)
                print(article.urlToArticle)
                self.navigationController?.pushViewController(svc, animated: true)
           // }
            
            selectedCell?.backgroundColor = UIColor.white
            selectedCell = cell
        }
    }

    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.asArray().count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Category.asArray()[row].rawValue
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let category = Category.asArray()[row]
        
        let articleFetchCompletion: ([Article]?) -> () = { (responseArticles: [Article]?) in
            print("Articles delivered to View Controller")
            
            if let cnnFilteredArticles = self.cnnFilteredArticles {
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
        
        cnnClient.getData(category: category, completion: articleFetchCompletion)
    }
    

 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
 

}
