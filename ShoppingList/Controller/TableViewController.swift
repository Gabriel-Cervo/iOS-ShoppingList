//
//  ViewController.swift
//  ShoppingList
//
//  Created by Joao Gabriel Dourado Cervo on 01/03/21.
//

import UIKit

class TableViewController: UITableViewController {
    var shoppingLists = [ShoppingList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showNewShoppingItemAlert))
        
        // testing
        let testList: [ShoppingList] = [
            ShoppingList(name: "Supermercado", icon: "cart"),
            ShoppingList(name: "Eletrônicos", icon: "bag"),
        ]
        
        for item in testList {
            shoppingLists.append(item)
        }
    }
    
    //MARK: TableView Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath)
        
        let actualItem = shoppingLists[indexPath.row]
        
        cell.textLabel?.text = actualItem.name
        cell.imageView?.image = UIImage(systemName: actualItem.icon)
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedShoppingList = shoppingLists[indexPath.row]
        
        guard let shoppingItensVC = storyboard?.instantiateViewController(identifier: "ShoppingItens") as? ShoppingItensViewController else {
            print("Cannot instantiate view controller as ShoppingItensViewController")
            return
        }
        
        shoppingItensVC.shoppingListOfThisItens = selectedShoppingList
        
        navigationController?.pushViewController(shoppingItensVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteShoppingListAt(at: indexPath)
            deleteRowFrom(tableView, at: indexPath)
        }
    }
    
    //MARK: Custom Methods
    @objc func showNewShoppingItemAlert() {
        let alertViewController = UIAlertController(title: "Digite o nome da sua lista:", message: nil, preferredStyle: .alert)
        alertViewController.addTextField()
        alertViewController.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: { [weak self, weak alertViewController] (UIAlertAction) in
            guard let text = alertViewController?.textFields?[0].text else { return }
            
            let newShoppingList = ShoppingList(name: text, icon: "cart")
            
            self?.addNewShoppingList(newShoppingList)
            updateNewInsertIn((self?.tableView)!)

            alertViewController?.dismiss(animated: true)
        }))
        alertViewController.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        
        present(alertViewController, animated: true)
    }
    
    func addNewShoppingList(_ newShoppingList: ShoppingList) {
        shoppingLists.insert(newShoppingList, at: 0)
    }
    
    func deleteShoppingListAt(at indexPath: IndexPath) {
        shoppingLists.remove(at: indexPath.row)
    }
}

