//
//  ViewController.swift
//  ShoppingList
//
//  Created by Joao Gabriel Dourado Cervo on 01/03/21.
//

import UIKit

class TableViewController: UITableViewController {
    var shoppingList = [ShoppingList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // testing
        let testList: [ShoppingList] = [
            ShoppingList(name: "Supermercado", icon: "cart"),
            ShoppingList(name: "Eletrônicos", icon: "bag"),
        ]
        
        for item in testList {
            shoppingList.append(item)
        }
    }
    
    //MARK: TableView Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath)
        
        let actualItem = shoppingList[indexPath.row]
        
        cell.textLabel?.text = actualItem.name
        cell.imageView?.image = UIImage(systemName: actualItem.icon)
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


}

