//
//  DetailedViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/5/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {
    
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var selectedIndex: Int?
    var selectedCellIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
