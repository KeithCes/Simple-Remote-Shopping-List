//
//  ShoppingListItem.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/8/23.
//

import Foundation

// name and isChecked for each item in shopping list
struct ShoppingListItem: Codable {
    var name: String
    var isChecked: Bool
    var ID: String
}
