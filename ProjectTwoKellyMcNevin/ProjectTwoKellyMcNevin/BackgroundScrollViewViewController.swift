//
//  SecondViewController.swift
//  ProjectTwoKellyMcNevin
//
//  Created by Kelly McNevin on 12/6/16.
//  Copyright © 2016 Kelly McNevin. All rights reserved.
//

import UIKit

class BackgroundScrollViewViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    let leftMenuWidth:CGFloat = 200
    var counter1 = 1
    var counter2 = 1
    //creates an instance of mainviewcontroller
    var mainViewController: MainViewController?
    
    //creates instance of sildermenuviewcontroller
    var menuViewController: SliderMenuViewController?

    @IBOutlet weak var searchButton: UIBarButtonItem!
    
    @IBAction func menuButtonWasTapped(_ sender: Any) {
        if counter2 % 2 == 0 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
            searchButton.isEnabled = true
        }
        else if counter2 % 2 != 0 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
            searchButton.isEnabled = false
        }
        counter2 += 1
    }
    
    @IBAction func searchMenuButtonWasTapped(_ sender: Any) {
        
        if counter1 % 2 == 0{
            mainViewController?.searchBar.isHidden = true
        }
        else if counter1 % 2 != 0 {
            mainViewController?.searchBar.isHidden = false
        }
        counter1 += 1
    }
    override func viewDidLoad() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(BackgroundScrollViewViewController.toggleMenu), name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BackgroundScrollViewViewController.closeMenuViaNotification), name: NSNotification.Name(rawValue: "closeMenuViaNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BackgroundScrollViewViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BackgroundScrollViewViewController.openModalWindow), name: NSNotification.Name(rawValue: "openModalWindow"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func openModalWindow(){
        performSegue(withIdentifier: "openModalWindow", sender: nil)
    }
    
    func toggleMenu(){
        
        if scrollView.contentOffset.x == 0 {
            closeMenu()
        } else {
            openMenu()
            if let source = menuViewController?.selectedSource {
                mainViewController?.selectedSource = source
            }
            mainViewController?.loadTableViewURLFromBar()
        }
    }
    
    func closeMenuViaNotification(){
        closeMenu()
    }
    
    func closeMenu(animated:Bool = true){
        scrollView.setContentOffset(CGPoint(x: -leftMenuWidth, y: -65), animated: animated)
    }
    
    // Open is the natural state of the menu because of how the storyboard is setup.
    func openMenu(){
        print("opening menu")
        scrollView.setContentOffset(CGPoint(x: 0, y: -65), animated: false)
        
    }
    
    // see http://stackoverflow.com/questions/25666269/ios8-swift-how-to-detect-orientation-change
    // close the menu when rotating to landscape.
    // Note: you have to put this on the main queue in order for it to work
    func rotated(){
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            DispatchQueue.main.async() {
                print("closing menu on rotate")
                self.closeMenu()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EmbedMain" {
            
            if let main = segue.destination as? MainViewController {
                self.mainViewController = main
            }
        }
         
       else if segue.identifier == "EmbedToMenu"
        {
            if let menu = segue.destination as? SliderMenuViewController {
                menuViewController = menu
            }
        }
    }
    
}

extension BackgroundScrollViewViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scrollView.contentOffset.x:: \(scrollView.contentOffset.x)")
    }
    
}
