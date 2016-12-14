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
    var selectedSource: String?
    

    var sourcesArray = [String?]()


    override func viewDidLoad() {
        super.viewDidLoad()
        newsTitleTableView.reloadData()
    }
    
    //Search All Function
    @IBAction func searchButtonWasTapped(_ sender: Any) {
        selectedSource = "search all"
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
    
    }

    
//CREATE TABLE VIEW---------------------------------------------
    
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
    }

}
