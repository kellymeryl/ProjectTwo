//
//  MainViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/5/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit

var articles = [Article]()

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    

    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var userInputTextField: UITextField!
    
    
    var selectedCell: DataTableViewCell?
    var selectedListIndex: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = WallStreetJournalAPIClient()
        
        let articleFetchCompletion: ([Article]?) -> () = { (responseArticles: [Article]?) in
            print("Articles delivered to View Controller")
            if let art = responseArticles {
                articles = art
                self.dataTableView.reloadData()
            }
            
        }
        DispatchQueue.global(qos: .background).async {
            client.getData(completion: articleFetchCompletion)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataTableViewCell", for: indexPath) as! DataTableViewCell
        let article = articles[indexPath.row]
        cell.articleTitleLabel.text = article.title
        cell.articleDescriptionLabel.text = article.description
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
            selectedCell?.backgroundColor = UIColor.white
            selectedCell = cell
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DetailedViewController = segue.destination as! DetailedViewController
        DetailedViewController.selectedIndex = dataTableView.indexPathForSelectedRow?.row
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
