//
//  deleteRowFromTableView.swift
//  ShoppingList
//
//  Created by Joao Gabriel Dourado Cervo on 06/03/21.
//

import UIKit

func deleteRowFrom(_ tableView: UITableView, at indexPath: IndexPath) {
    tableView.beginUpdates()
    tableView.deleteRows(at: [indexPath], with: .fade)
    tableView.endUpdates()
}
