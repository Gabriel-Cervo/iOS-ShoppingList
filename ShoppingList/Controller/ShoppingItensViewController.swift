//
//  ShoppingItensViewController.swift
//  ShoppingList
//
//  Created by Joao Gabriel Dourado Cervo on 04/03/21.
//

import UIKit

class ShoppingItensViewController: UITableViewController {
    var shoppingListOfThisItens: ShoppingList?
    var shoppingItens: [ShoppingItem]? {
        didSet {
            shoppingListOfThisItens?.itens = shoppingItens!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItemInShoppingList))
        
        shoppingItens = shoppingListOfThisItens?.itens
    }
    
    //MARK: TableView Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItens!.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let actualItem = shoppingItens![indexPath.row]
        let itemCell = tableView.dequeueReusableCell(withIdentifier: "ShoppingItemCell", for: indexPath)
        itemCell.textLabel?.text = actualItem.name
        itemCell.imageView?.image = UIImage(systemName: actualItem.icon)
        itemCell.accessoryType = actualItem.wasAlreadyPicked ? .checkmark : .none
        
        return itemCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        shoppingItens![indexPath.row].wasAlreadyPicked.toggle()
                
        tableView.cellForRow(at: indexPath)?.accessoryType = shoppingItens![indexPath.row].wasAlreadyPicked ? .checkmark : .none
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteFromShoppingList(at: indexPath)
            deleteRowFrom(tableView, at: indexPath)
        }
    }
    
    //MARK: ShoppingItens Methods
    @objc func addNewItemInShoppingList() {
        let alertVC = UIAlertController(title: "Digite o nome do novo item:", message: nil, preferredStyle: .alert)
        alertVC.addTextField()
        alertVC.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alertVC.addAction(UIAlertAction(title: "Confirmar", style: .default, handler: { [weak self, weak alertVC] (UIAlertAction) in
            guard let textFieldText = alertVC?.textFields?[0].text else { return }
            
            self?.insertIntoShoppingLists(textFieldText)
            updateNewInsertIn((self?.tableView)!)
            
            alertVC?.dismiss(animated: true)
        }))
        
        present(alertVC, animated: true)
    }
    
    func insertIntoShoppingLists(_ itemText: String) {
        let newItem = ShoppingItem(name: itemText, icon: "record.circle", wasAlreadyPicked: false)
        
        shoppingItens!.insert(newItem, at: 0)
    }
    
    func deleteFromShoppingList(at indexPath: IndexPath) {
        shoppingItens?.remove(at: indexPath.row)
    }
}
