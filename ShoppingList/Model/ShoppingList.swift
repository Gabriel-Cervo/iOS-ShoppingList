//
//  ShoppingList.swift
//  ShoppingList
//
//  Created by Joao Gabriel Dourado Cervo on 01/03/21.
//

import Foundation

class ShoppingList {
    var name: String
    var icon: String
    var itens = [ShoppingItem]()
    
    init(name: String, icon: String) {
        self.name = name
        self.icon = icon
    }
}
