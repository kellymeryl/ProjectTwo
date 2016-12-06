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

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var categoryPickerView: UIPickerView!

    @IBOutlet weak var dataTableView: UITableView!
    
    @IBAction func browseButtonWasTapped(_ sender: Any) {
        categoryPickerView.isHidden = false
        print("hello")
    }
    
    var pickerData = ["Business", "Entertainment", "Gaming", "General", "Music", "Science and Nature", "Sport", "Technology"]
    
    var selectedCell: DataTableViewCell?
    var selectedListIndex: Int?
    
    
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
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

/*extension MainViewController:UISearchBarDelegate{
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar){
        searchBar.text
        
    }
}*/

