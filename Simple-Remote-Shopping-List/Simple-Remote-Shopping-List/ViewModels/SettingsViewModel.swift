//
//  SettingsViewModel.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/21/23.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

final class SettingsViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var isUserLoggedOut: Bool = false
    @Published var isShowingConfirmationPopup: Bool = false
    
    // MARK: - Methods
    
    func deleteUser() {
        
        self.isShowingConfirmationPopup.toggle()
        
        let user = Auth.auth().currentUser
        let userID = Auth.auth().currentUser!.uid
        let ref = Database.database().reference()
        
        try! Auth.auth().signOut()
        
        
        DispatchQueue.global(qos: .background).async {
            ref.child("users").child(userID).removeValue()
            user?.delete { error in
              if let error = error {
                print(error)
              } else {
                  print("user deleted")
                  DispatchQueue.main.async {
                      self.isUserLoggedOut.toggle()
                  }
              }
            }
        }

    }
    
    func logoutUser() {
        try! Auth.auth().signOut()
        self.isUserLoggedOut.toggle()
    }
}
