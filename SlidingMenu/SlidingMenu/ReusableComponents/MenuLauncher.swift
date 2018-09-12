//
//  MenuLauncher.swift
//  DecisionPointMobile
//
//  Created by Subin Revi on 31/08/18.
//  Copyright © 2018 Subin Revi. All rights reserved.
//

import Foundation
import UIKit

class MenuLauncher: NSObject {
    
    var menuViewCenter: CGPoint!
    var menuViewCenterOpen:CGPoint!
    var menuViewWidth:CGFloat!
    /*
     Transparent black Background view
     */
    let menuView = HamburgerMenu()
    let backgroundView:UIView = {
        let bg = UIView()
        bg.backgroundColor = UIColor(white: 0, alpha: 0.5)
        return bg
    }()
    
    var menuViewLeadingConstraint:NSLayoutConstraint?
    var menuViewWidthConstraint:NSLayoutConstraint?
    var topConstraintMenuView:NSLayoutConstraint?
    var bottomConstraintMenuView:NSLayoutConstraint?
    
    override init() {
        super.init()
    }
    
    public func addHamburgerView() {
        
        if let window = UIApplication.shared.keyWindow {
            
            window.addSubview(backgroundView)
            window.addSubview(menuView)
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            menuView.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.alpha = 0
            menuView.alpha = 0
            backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissHamburgerView)))
            
            //Swipe Gesture for removing Menu View (Gesture added to menu view)
            let swipeFromRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft))
            swipeFromRight.direction = UISwipeGestureRecognizerDirection.left
            menuView.addGestureRecognizer(swipeFromRight)
            
            //Swipe Gesture for removing Menu View (Gesture added to background view)
            let swipeFromRightBgView = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeLeft))
            swipeFromRightBgView.direction = UISwipeGestureRecognizerDirection.left
            backgroundView.addGestureRecognizer(swipeFromRightBgView)
            
           //Pan Gesture for dragging the Menu View
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(pan:)))
            menuView.addGestureRecognizer(panGestureRecognizer)
            
            //Constraints for Background view
            let bgLeadingConstraint = NSLayoutConstraint(item: backgroundView, attribute: .leading, relatedBy: .equal, toItem: window, attribute: .leading, multiplier: 1.0, constant: 0)
            let bgTrailingConstraint = NSLayoutConstraint(item: backgroundView, attribute: .trailing, relatedBy: .equal, toItem: window, attribute: .trailing, multiplier: 1, constant: 0)
            let topConstraintBgView = NSLayoutConstraint(item: backgroundView, attribute: .top, relatedBy: .equal, toItem: window, attribute: .top, multiplier: 1.0, constant: 0)
            let bottomConstraintBgView = NSLayoutConstraint(item: backgroundView, attribute: .bottom, relatedBy: .equal, toItem: window, attribute: .bottom, multiplier:1, constant: 0)
            window.addConstraints([bgLeadingConstraint,bgTrailingConstraint,topConstraintBgView,bottomConstraintBgView])
            
            // Constraints for Hamburger Menu View
             menuViewLeadingConstraint = NSLayoutConstraint(item: self.menuView, attribute: .leading, relatedBy: .equal, toItem: window, attribute: .leading, multiplier: 1.0, constant: 0)
             menuViewWidthConstraint = NSLayoutConstraint(item: self.menuView, attribute: .width, relatedBy: .equal, toItem: window, attribute: .width, multiplier: 0, constant: 0)
             topConstraintMenuView = NSLayoutConstraint(item: self.menuView, attribute: .top, relatedBy: .equal, toItem: window, attribute: .top, multiplier: 1.0, constant: 0)
             bottomConstraintMenuView = NSLayoutConstraint(item: self.menuView, attribute: .bottom, relatedBy: .equal, toItem: window, attribute: .bottom, multiplier:1, constant: 0)
            window.addConstraints([menuViewLeadingConstraint!,menuViewWidthConstraint!,topConstraintMenuView!,bottomConstraintMenuView!])
            
             window.layoutIfNeeded()
             
            
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.backgroundView.alpha = 1
                self.menuView.alpha = 1
                self.menuViewWidthConstraint?.isActive = false
                // Constraints for Hamburger Menu View. Width is given as 0.65 of the superview. Change this value as per the requirement.
                self.menuViewLeadingConstraint = NSLayoutConstraint(item: self.menuView, attribute: .leading, relatedBy: .equal, toItem: window, attribute: .leading, multiplier: 1.0, constant: 0)
                self.menuViewWidthConstraint = NSLayoutConstraint(item: self.menuView, attribute: .width, relatedBy: .equal, toItem: window, attribute: .width, multiplier: 0.65, constant: 0)
                self.topConstraintMenuView = NSLayoutConstraint(item: self.menuView, attribute: .top, relatedBy: .equal, toItem: window, attribute: .top, multiplier: 1.0, constant: 0)
                self.bottomConstraintMenuView = NSLayoutConstraint(item: self.menuView, attribute: .bottom, relatedBy: .equal, toItem: window, attribute: .bottom, multiplier:1, constant: 0)
            window.addConstraints([self.menuViewLeadingConstraint!,self.menuViewWidthConstraint!,self.topConstraintMenuView!,self.bottomConstraintMenuView!])
                window.layoutIfNeeded()
                
            }, completion: nil)
            
            //Setting the intital values of the hamburger view to variables
            menuViewCenterOpen = menuView.center
            menuViewWidth = menuView.frame.width
        }
        
    }
    
    @objc func dismissHamburgerView() {
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundView.alpha = 0
            self.menuView.alpha = 0
            self.menuView.removeFromSuperview()

        }
        
    }
    
    func removeHamburgerMenuOnSelection() {
        UIView.animate(withDuration: 0.3) {
            self.menuPositionOnInitialState()
        }
    }
    
    /*
     Pan Gesture action for handling slider movement.
     */
   
    @objc func handlePan(pan:UIPanGestureRecognizer) {

        let translation = pan.translation(in: menuView.superview)
       
        if pan.state == .began {
            menuViewCenter = menuView.center
        } else if pan.state == .changed {
          
          let velocity = pan.velocity(in: menuView)
            if velocity.x > 0  {
            
              if(translation.x < 0) {
                 menuView.center = CGPoint(x: menuViewCenter.x + translation.x, y   : menuViewCenter.y)
                
                }
                
            }else if velocity.x < 0 && translation.x < 0 {
                  menuView.center = CGPoint(x: menuViewCenter.x + translation.x, y: menuViewCenter.y)
            }

        } else if pan.state == .ended {
            if (menuView.center.x < 0){
                    UIView.animate(withDuration: 0.3) {
                       self.menuPositionOnInitialState()
                    }
                
            }else {
                   UIView.animate(withDuration: 0.3) {
                        self.menuPositionOnFinalState()
                    }
                }
        }

    }
    
    
    @objc func didSwipeLeft() {
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            if let window = UIApplication.shared.keyWindow {
                
            NSLayoutConstraint.deactivate([self.menuViewLeadingConstraint!,self.menuViewWidthConstraint!,self.topConstraintMenuView!,self.bottomConstraintMenuView!])
                self.menuViewWidthConstraint?.isActive = false
                // Constraints for Hamburger Menu View after swipe close
                self.menuViewLeadingConstraint = NSLayoutConstraint(item: self.menuView, attribute: .leading, relatedBy: .equal, toItem: window, attribute: .leading, multiplier: 1.0, constant: 0)
                self.menuViewWidthConstraint = NSLayoutConstraint(item: self.menuView, attribute: .width, relatedBy: .equal, toItem: window, attribute: .width, multiplier: 0, constant: 0)
                self.topConstraintMenuView = NSLayoutConstraint(item: self.menuView, attribute: .top, relatedBy: .equal, toItem: window, attribute: .top, multiplier: 1.0, constant: 0)
                self.bottomConstraintMenuView = NSLayoutConstraint(item: self.menuView, attribute: .bottom, relatedBy: .equal, toItem: window, attribute: .bottom, multiplier:1, constant: 0)
            window.addConstraints([self.menuViewLeadingConstraint!,self.menuViewWidthConstraint!,self.topConstraintMenuView!,self.bottomConstraintMenuView!])
                
                window.layoutIfNeeded()
                self.backgroundView.alpha = 0
                self.menuView.removeFromSuperview()
                
            }
            
        }, completion: nil)
    }
    
    func menuPositionOnInitialState() {
        
        if let window = UIApplication.shared.keyWindow {

        NSLayoutConstraint.deactivate([self.menuViewLeadingConstraint!,self.menuViewWidthConstraint!,self.topConstraintMenuView!,self.bottomConstraintMenuView!])
            // Constraints for Hamburger Menu View after swipe close
            self.menuViewLeadingConstraint = NSLayoutConstraint(item: self.menuView, attribute: .leading, relatedBy: .equal, toItem: window, attribute: .leading, multiplier: 1.0, constant: 0)
            self.menuViewWidthConstraint = NSLayoutConstraint(item: self.menuView, attribute: .width, relatedBy: .equal, toItem: window, attribute: .width, multiplier: 0.0, constant: 0)
            self.topConstraintMenuView = NSLayoutConstraint(item: self.menuView, attribute: .top, relatedBy: .equal, toItem: window, attribute: .top, multiplier: 1.0, constant: 0)
            self.bottomConstraintMenuView = NSLayoutConstraint(item: self.menuView, attribute: .bottom, relatedBy: .equal, toItem: window, attribute: .bottom, multiplier:1, constant: 0)
            window.addConstraints([self.menuViewLeadingConstraint!,self.menuViewWidthConstraint!,self.topConstraintMenuView!,self.bottomConstraintMenuView!])

            window.layoutIfNeeded()
            self.backgroundView.alpha = 0
            menuView.removeFromSuperview()


        }
    }
    
    func menuPositionOnFinalState() {
        
        menuView.center = CGPoint(x: menuViewCenterOpen.x, y: menuViewCenter.y)
        
    }
}








