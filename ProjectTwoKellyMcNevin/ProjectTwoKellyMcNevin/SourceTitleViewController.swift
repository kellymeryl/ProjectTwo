//
//  SourceTitleViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/8/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit

class SourceTitleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var newsTitleTableView: UITableView!

    var selectedCell: SourceTitleTableViewCell?
    var selectedListIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        newsTitleTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print(arrayOfTitles.count)
        return arrayOfTitles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SourceTitleTableViewCell", for: indexPath) as! SourceTitleTableViewCell
        let titleName = arrayOfTitles[indexPath.row]
        cell.sourceTitleLabel.text = titleName.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! SourceTitleTableViewCell
        
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
        let MainViewController = segue.destination as! MainViewController
        MainViewController.selectedIndex = newsTitleTableView.indexPathForSelectedRow?.row
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
