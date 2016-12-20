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
    
    var selectedCell: ExploreCategoriesTableViewCell?
    
    
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
        cell.exploreCategoriesLabel.text = category
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExploreCategoriesTableViewCell", for: indexPath) as! ExploreCategoriesTableViewCell
        
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
        let CategoryDisplayViewController = segue.destination as! CategoryDisplayViewController
        CategoryDisplayViewController.selectedIndex = exploreTableView.indexPathForSelectedRow?.row
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
