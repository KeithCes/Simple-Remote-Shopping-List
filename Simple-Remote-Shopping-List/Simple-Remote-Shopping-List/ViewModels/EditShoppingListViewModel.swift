//
//  CreateNewListViewModel.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/6/23.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

final class EditShoppingListViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var items: [ShoppingListItem] = []
    @Published var selectedItem: ShoppingListItem?
    @Published var newItemName: String = ""
    @Published var isEditing = false
    @Published var listTitle: String = ""
    @Published var listID: String = UUID().uuidString
    
    @Published var isShowingToast: Bool = false
    @Published var toastMessage: String = "Error"
    
    @Published var isSuccessfullySentToFirebase: Bool = false

    // MARK: - Methods
    
    func delete(at offsets: IndexSet) {
        self.items.remove(atOffsets: offsets)
    }
    
    func addItem() {
        guard !self.newItemName.isEmpty else {
            return
        }
        self.items.insert(ShoppingListItem(name: self.newItemName, isChecked: false, ID: UUID().uuidString), at: 0)
        self.newItemName = ""
    }
    
    func sendShoppingListFirebase() {
        let ref = Database.database().reference()
        
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let itemsCoded = self.items.map { item in item.dictionary ?? [:] }
        
        if self.listTitle == "" {
            self.toastMessage = "Error: Please Name Your List Before Saving"
            self.isShowingToast = true
            return
        }
        if itemsCoded.isEmpty {
            self.toastMessage = "Error: Please Enter at least 1 item Before Saving"
            self.isShowingToast = true
            return
        }
        
        
        DispatchQueue.global(qos: .background).async {
            ref.child("users").child(userID).child("shoppingLists").child(self.listID).child("items").setValue(itemsCoded)
            ref.child("users").child(userID).child("shoppingLists").child(self.listID).child("title").setValue(self.listTitle)
            ref.child("users").child(userID).child("shoppingLists").child(self.listID).child("ID").setValue(self.listID)
            
            print("order sent to firebase")
            
            DispatchQueue.main.async {
                self.isSuccessfullySentToFirebase.toggle()
            }
        }
    }
}
