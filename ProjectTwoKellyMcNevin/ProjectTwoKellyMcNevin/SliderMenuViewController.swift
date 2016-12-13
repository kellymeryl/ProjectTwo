//
//  SourceTitleViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/8/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit

class SliderMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var newsTitleTableView: UITableView!
        
    var selectedCell: MenuTableViewCell?
    var selectedListIndex: Int?
    
    var source: String?
    var searchAllArticles = [Article]()
    var selectedSource: String?
    var client = SearchAllAPIClient()
   // var source: String?

   // var sourcesArray = ["the-wall-street-journal", "business-insider", "the-economist", "cnn", "usa-today", "bloomberg-news", "financial-times"]
    var sourcesArray = [String?]()


    override func viewDidLoad() {
        super.viewDidLoad()
        newsTitleTableView.reloadData()
    }
    
    @IBAction func searchButtonWasTapped(_ sender: Any) {
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
        
        //Run getall data function
        //run search all function that loops through all sources, makes new array of articles which is new closure
        //self.articles = art --> articles in searchArray = art
        //repopulate table view
        //redefine articles
        
    
        client.searchAll()
        
    }
    


    //CREATE TABLE VIEW
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print(arrayOfTitles.count)
        return arrayOfTitles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        let titleName = arrayOfTitles[indexPath.row]
        cell.menuLabel.text = titleName.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        let titleName = arrayOfTitles[indexPath.row]
        
        source = Source.asArray2()[indexPath.row].rawValue
      //  print(source)
        
        if cell === selectedCell {
            cell.backgroundColor = UIColor.white
            selectedCell = nil
        }
        else {
            cell.backgroundColor = UIColor.lightGray
            selectedCell?.backgroundColor = UIColor.white
            selectedCell = cell
        }
        
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let MainViewController = segue.destination as! MainViewController
            MainViewController.selectedIndex = newsTitleTableView.indexPathForSelectedRow?.row
        }
        
        selectedSource = source
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)

        print(titleName.title)
       
    }
   
 
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
