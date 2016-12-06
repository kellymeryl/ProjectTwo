//
//  FirstScreenViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/5/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit

class FirstScreenViewController: UIViewController {

    @IBOutlet weak var userInputTextField: UITextField!
    
    @IBAction func searchButtonWasTapped(_ sender: Any) {
        
        
    }
    
    @IBOutlet weak var browsePopularArticlesWasTapped: UIButton!
    @IBOutlet weak var browseLatestArticlesWasTapped: UIButton!
    @IBOutlet weak var browseTopArticlesWasTapped: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue == browseTopArticlesWasTapped {
            
            
        }
        else if segue == browseLatestArticlesWasTapped {
            
        }
        else if segue == browsePopularArticlesWasTapped{
            
        }
    }

}
