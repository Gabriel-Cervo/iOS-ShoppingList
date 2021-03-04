//
//  ShoppingItensViewController.swift
//  ShoppingList
//
//  Created by Joao Gabriel Dourado Cervo on 04/03/21.
//

import UIKit

class ShoppingItensViewController: UITableViewController {
    var shoppingListOfThisItens: ShoppingList?
    var shoppingItens: [ShoppingItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItemInShoppingList))
        
        shoppingItens = shoppingListOfThisItens?.itens
    }
    
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
        let newItem = ShoppingItem(name: itemText, icon: "pencil", wasAlreadyPicked: false)
        
        shoppingListOfThisItens?.itens.insert(newItem, at: 0)
        shoppingItens!.insert(newItem, at: 0)
    }
 
    //MARK: TableViewMethods
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
        
        return itemCell
    }
}
