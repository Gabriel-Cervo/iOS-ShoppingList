//
//  updateNewInsertInTableView.swift
//  ShoppingList
//
//  Created by Joao Gabriel Dourado Cervo on 04/03/21.
//

import UIKit

func updateNewInsertIn(_ tableView: UITableView) {
    tableView.beginUpdates()
    tableView.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
    tableView.endUpdates()
}
