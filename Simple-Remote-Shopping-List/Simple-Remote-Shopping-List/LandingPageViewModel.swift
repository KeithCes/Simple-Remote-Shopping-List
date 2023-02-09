//
//  LandingPageViewModel.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/6/23.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

final class LandingPageViewModel: ObservableObject {
    
    @Published var shoppingLists: [ShoppingList] = []
    
    @Published var selectedShoppingList: ShoppingList?
    
    @Published var isShowingEditShoppingList: Bool = false
    @Published var isProgressViewHidden: Bool = false
    
    func getYourLists() {
        
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        
        let ref = Database.database().reference()
        
        self.shoppingLists = []
        self.isProgressViewHidden = false
        
        DispatchQueue.global(qos: .background).async {
            ref.child("users").child(userID).child("shoppingLists").observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let snapshot = snapshot.value as? [String: Any] else {
                    return
                }
                
                for snap in snapshot {
                    
                    guard let snapshotDict = snap.value as? [String: Any] else {
                        return
                    }
                    
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: snapshotDict, options: [])
                        let shoppingList = try JSONDecoder().decode(ShoppingList.self, from: jsonData)
                        
                        self.shoppingLists.append(shoppingList)
                    }
                    catch let error {
                        print(error)
                    }
                }
                
                self.shoppingLists.sort { $0.title < $1.title }
                
                self.isProgressViewHidden = true
            })
        }
    }
}
