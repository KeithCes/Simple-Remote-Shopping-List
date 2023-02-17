//
//  ShoppingList.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/8/23.
//

import Foundation

struct ShoppingList: Codable {
    var title: String
    var items: [ShoppingListItem]
    var ID: String
}
