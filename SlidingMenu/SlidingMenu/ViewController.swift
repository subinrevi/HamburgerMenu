//
//  ViewController.swift
//  SlidingMenu
//
//  Created by Subin Revi on 10/09/18.
//  Copyright © 2018 Subin Revi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,HamburgerMenuDelegate {
   
    /*
     Creates an instance of MenuLauncher class
     */
    let menuLauncher = MenuLauncher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.purple
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        //Pan Gesture for dragging from Left Screen Edge
        let panGestureFromScreenEdge = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(panFromSide(sender:)))
        panGestureFromScreenEdge.edges = .left
        self.view.addGestureRecognizer(panGestureFromScreenEdge)
    }
    
    /*
     Button action for hamburger menu. Add this to your view controller class.
     */

    @IBAction func hamburgerMenuTapped(_ sender: Any) {
       
        menuLauncher.menuView.menuIcons = ["Apple","Google","Instagram","Facebook","Onedrive","Twitter"]
        menuLauncher.menuView.menuItems = ["Apple","Google","Instagram","Facebook","Onedrive","Twitter"]
        menuLauncher.menuView.delegate = self
        menuLauncher.addHamburgerView()
        
    }
    
    @objc func panFromSide(sender:UIScreenEdgePanGestureRecognizer) {
        
        if sender.state == .recognized {
            menuLauncher.addHamburgerView()
        }
    }
    
    /*
     Delegate method to handle hamburger menu item selected case. Add the navigation logic here.
     */
    func menuItemSelected(indexPath: IndexPath) {
        menuLauncher.removeHamburgerMenuOnSelection()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        
        
    }
}

