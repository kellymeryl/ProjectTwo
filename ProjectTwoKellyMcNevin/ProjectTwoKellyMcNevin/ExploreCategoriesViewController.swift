//
//  ExploreCategoriesViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/15/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit

class ExploreCategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var exploreTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //IMPLEMENTING TABLE VIEW

    // The number of rows of data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Category.asArray().count
    }
    
    // The data to return for the row and component (column) that's being passed in
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreCategoriesTableViewCell", for: indexPath) as! ExploreCategoriesTableViewCell
        let category = Category.asArray()[indexPath.row].rawValue
        cell.exploreCategoriesLabel = category
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let category = Category.asArray()[indexPath.row]
        
        let articleFetchCompletion: ([Article]?) -> () = { (responseArticles: [Article]?) in
            print("Articles delivered to View Controller")
            
            if let filteredResults = self.filteredResults {
                if let filteredArt = responseArticles {
                    self.articles = filteredArt
                    self.dataTableView.reloadData()
                }
            }
            else {
                if let art = responseArticles {
                    self.articles = art
                    self.dataTableView.reloadData()
                }
            }
            
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
