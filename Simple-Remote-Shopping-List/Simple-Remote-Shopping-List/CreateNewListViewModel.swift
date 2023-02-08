//
//  CreateNewListViewModel.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/6/23.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

final class CreateNewListViewModel: ObservableObject {
    
    @Published var items: [String] = []
    @Published var selectedItem: String = ""
    @Published var newItem: String = ""
    @Published var isEditing = false
    @Published var listTitle: String = ""
    @Published var listID: String = UUID().uuidString

    
    func delete(at offsets: IndexSet) {
        self.items.remove(atOffsets: offsets)
    }
    
    func addItem() {
        guard !self.newItem.isEmpty else { return }
        self.items.insert(self.newItem, at: 0)
        self.newItem = ""
    }
    
    func sendShoppingListFirebase() {
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser!.uid
        
        ref.child("users").child(userID).child("shoppingLists").child(self.listID).child("listTitle").setValue(self.listTitle)
        ref.child("users").child(userID).child("shoppingLists").child(self.listID).child("listItems").setValue(self.items)
        
        print("order sent to firebase")
    }
}
