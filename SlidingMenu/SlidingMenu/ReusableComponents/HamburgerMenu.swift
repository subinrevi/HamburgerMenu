//
//  HamburgerMenu.swift
//  DecisionPointMobile
//
//  Created by Subin Revi on 29/08/18.
//  Copyright © 2018 Subin Revi. All rights reserved.
//

import UIKit

/*
 Delegate for Menu Item Selected. Conform to this delegate in your view controller class.
 */
protocol HamburgerMenuDelegate:class {
    func menuItemSelected(indexPath:IndexPath)
}

class HamburgerMenu: UIView {
    
    /*
     Array for storing menu items and menu icon images
     */
    var menuItems:Array = [String]()
    var menuIcons:Array = [String]()
    weak var delegate:HamburgerMenuDelegate?
    
    /*
     Sliding menu top header view. Customize the header view by adding items as subview.
     */
    let headerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.purple
        return view
    }()
    
    /*
     Header label for Sliding Menu
     */
    let mainLabel:UILabel = {
        let label = UILabel()
        label.text = "Hamburger Menu"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Helvetica Neue", size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    //We are using lazy var here since the list view delegate is set to "self". listView can't access "self" (ie HamburgerMenu) until its created. So inorder to access it the lazy keyword mentions it to instantiate the tableview only after creating the class "hamburgerMenu"
    lazy var menuListView:UITableView = {
        
        let listView = UITableView(frame: .zero, style: .plain)
        listView.delegate = self
        listView.dataSource = self
        listView.register(MenuCell.self, forCellReuseIdentifier: "MenuCell")
        return listView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    /*
     Add subviews to hamburger menu programatically.
     */
    func setupViews() {
        addSubview(headerView)
        addSubview(menuListView)
        addSubview(mainLabel)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        menuListView.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints for Top Header View
        let leadingConstraintHeaderView = NSLayoutConstraint(item: headerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
        let trailingConstraintHeaderView = NSLayoutConstraint(item: headerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        let topConstraintHeaderView = NSLayoutConstraint(item: headerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0)
        let heightConstraintHeaderView = NSLayoutConstraint(item: headerView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier:0.2, constant: 0)
       self.addConstraints([leadingConstraintHeaderView,trailingConstraintHeaderView,topConstraintHeaderView,heightConstraintHeaderView])
        
        // Constraints for Main Label using Layout Anchors
        mainLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant:20).isActive = true
        mainLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor,constant:20).isActive = true
        mainLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor,constant:-20).isActive = true

        
        // Constraints for Menu List Table View
        let leadingConstraintMenuView = NSLayoutConstraint(item: menuListView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
        let trailingConstraintMenuView = NSLayoutConstraint(item: menuListView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        let topConstraintMenuView = NSLayoutConstraint(item: menuListView, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1.0, constant: 0)
        let bottomConstraintMenuView = NSLayoutConstraint(item: menuListView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier:1.0, constant: 0)

        self.addConstraints([leadingConstraintMenuView,trailingConstraintMenuView,topConstraintMenuView,bottomConstraintMenuView])
        }
    
    override func layoutSubviews() {
        print("Called on orienttion change")
        
//        if (UIDevice.current.orientation.isLandscape) {
//            print("Landscape")
//            self.leadingAnchor.constraint(equalTo: (self.superview?.leadingAnchor)!, constant: 0).isActive = true
//            self.topAnchor.constraint(equalTo: (self.superview?.topAnchor)!, constant: 0).isActive = true
//            self.bottomAnchor.constraint(equalTo: (self.superview?.bottomAnchor)!, constant: 0).isActive = true
//            self.widthAnchor.constraint(equalTo: (self.superview?.widthAnchor)!, multiplier: 0.3).isActive = true
//        }else{
//            print("Portrait")
//            self.leadingAnchor.constraint(equalTo: (self.superview?.leadingAnchor)!, constant: 0).isActive = true
//            self.topAnchor.constraint(equalTo: (self.superview?.topAnchor)!, constant: 0).isActive = true
//            self.bottomAnchor.constraint(equalTo: (self.superview?.bottomAnchor)!, constant: 0).isActive = true
//            self.widthAnchor.constraint(equalTo: (self.superview?.widthAnchor)!, multiplier: 0.65).isActive = true
//
//
//        }
       

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

//MARK: Table View Data Source
extension HamburgerMenu:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.mainLabel.text = menuItems[indexPath.row]
        cell.iconImageView.image = UIImage(named:menuIcons[indexPath.row])
        cell.countLabel.text = String(indexPath.row)
        return cell
    }
}

//MARK: Table View Delegate

extension HamburgerMenu:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.menuItemSelected(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


/*
 Custom Menu Tableview cell. Customize as per requirements. Uncomment count label constraints and check.
 */
class MenuCell: UITableViewCell {
    
    let iconImageView:UIImageView = {
        let icon = UIImageView()
        icon.backgroundColor = UIColor.white
        icon.contentMode = .scaleAspectFit
       return icon
    }()
    
    let mainLabel:UILabel = {
         let title = UILabel()
         title.font = UIFont(name: "Helvetica Neue", size: 18)
         title.textColor = UIColor.black
         return title
        
    }()
    
    /*
     Count label is not added as subview to slider view. Feel free to uncomment and check it. 
     */
    let countLabel:UILabel = {
        let sub = UILabel()
        sub.font = UIFont(name: "Helvetica Neue", size: 15)
        sub.textColor = UIColor.black
        return sub
        
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(iconImageView)
        addSubview(mainLabel)
        //addSubview(countLabel)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        //countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //Constraints for Icon Image View
        let iconImageLeadingConstraint = NSLayoutConstraint(item: iconImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 20)
        let iconImageTopConstraint = NSLayoutConstraint(item: iconImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10)
        let iconImageBottomConstraint = NSLayoutConstraint(item: iconImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -10)
        let iconImageWidthConstraint = NSLayoutConstraint(item: iconImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50)
       
       self.addConstraints([iconImageLeadingConstraint,iconImageTopConstraint,iconImageBottomConstraint,iconImageWidthConstraint])
        
        //Constraints for Main Title Label
        let mainLabelLeadingConstraint = NSLayoutConstraint(item: mainLabel, attribute: .leading, relatedBy: .equal, toItem: iconImageView, attribute: .trailing, multiplier: 1.0, constant: 30)
        let mainLabelTopConstraint = NSLayoutConstraint(item: mainLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 15)
         let mainLabelBottomConstraint = NSLayoutConstraint(item: mainLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -15)
        let mainLabelTrailingConstraint = NSLayoutConstraint(item: mainLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 20)
       
        
        self.addConstraints([mainLabelLeadingConstraint,mainLabelTopConstraint,mainLabelBottomConstraint,mainLabelTrailingConstraint])
        
        //Constraints for Count Label
        
       /* let countLabelLeadingConstraint = NSLayoutConstraint(item: countLabel, attribute: .leading, relatedBy: .equal, toItem: mainLabel, attribute: .trailing, multiplier: 1.0, constant: 20)
        let countLabelTopConstraint = NSLayoutConstraint(item: countLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 15)
        let countLabelBottomConstraint = NSLayoutConstraint(item: countLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -15)
        let countLabelTrailingConstraint = NSLayoutConstraint(item: countLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 10)
        let countLabelWidthConstraint = NSLayoutConstraint(item: countLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30)
        self.addConstraints([countLabelLeadingConstraint,countLabelTopConstraint,countLabelBottomConstraint,countLabelTrailingConstraint,countLabelWidthConstraint])
        */
     
    }
}




















