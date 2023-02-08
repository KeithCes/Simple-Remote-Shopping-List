//
//  CreateNewListViewModel.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/6/23.
//

import Foundation
import FirebaseAuth

final class CreateNewListViewModel: ObservableObject {
    
    @Published var items: [String] = []
    @Published var selectedItem: String = ""
    @Published var newItem: String = ""
    @Published var isEditing = false
    
    func delete(at offsets: IndexSet) {
        self.items.remove(atOffsets: offsets)
    }
    
    func addItem() {
        guard !self.newItem.isEmpty else { return }
        self.items.insert(self.newItem, at: 0)
        self.newItem = ""
    }
}
