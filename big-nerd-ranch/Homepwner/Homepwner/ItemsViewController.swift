//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Brandon Hancock on 2/1/20.
//  Copyright © 2020 Brandon Hancock. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    @IBAction func addNewItem(_ sender:UIButton) {
        
    }
    
    @IBAction func toogleEditButton(_ sender:UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get the height of the status bar
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        
        //Set the text on the cell with the description of the item
        //that is at the nth index of items, where n = row this cell
        //will appear in on the tableView
        
        let item = itemStore.allItems[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
    }
}
