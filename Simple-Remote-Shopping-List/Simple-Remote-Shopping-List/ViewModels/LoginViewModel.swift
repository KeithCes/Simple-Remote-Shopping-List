//
//  LoginViewModel.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/4/23.
//

import Foundation
import FirebaseAuth

final class LoginViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isShowingToast: Bool = false
    @Published var toastMessage: String = ""
    
    @Published var isShowingLogin: Bool = true
    
    // MARK: - Methods
    
    func login() {
        
        #if UITest
        self.isShowingLogin = false
        return
        #endif
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                // display error message
                self.toastMessage = "Error: " + error.localizedDescription
                self.isShowingToast = true
                print(error.localizedDescription)
                return
            }
            // user is signed in
            self.isShowingLogin = false
        }
    }
}
