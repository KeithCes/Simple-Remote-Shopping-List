//
//  CreateAccountViewModel.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/4/23.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseDatabase

final class CreateAccountViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var isShowingCreate: Bool = true
    
    @Published var isShowingToast: Bool = false
    @Published var toastMessage: String = "Error"
    
    
    func checkIfCreateInfoValid() -> Bool {
        return email.count > 0 && checkValidEmail(email: email) && password == confirmPassword
    }
    
    func checkPostErrorToast() {
        if email.count <= 0 || !checkValidEmail(email: email) {
            self.toastMessage = "Email is not valid"
        }
        if password.count < 6 {
            self.toastMessage = "Password is too short"
        }
        else if password != confirmPassword {
            self.toastMessage = "Password confirmation must match"
        }
        self.isShowingToast.toggle()
    }
    
    func createAccount() {
        
        if checkIfCreateInfoValid() {
            
            let ref = Database.database().reference()
            
            Auth.auth().createUser(withEmail: email, password: password) { username, error in
                if error == nil && username != nil {
                    
                    let userID = Auth.auth().currentUser!.uid
                    
                    let userDetails = [
                        "email": self.email,
                    ] as [String : Any]
                    
                    ref.child("users").child(userID).child("userInfo").setValue(userDetails)
                    
                    print("user created")
                    self.isShowingCreate = false
                }
                else {
                    print("error:  \(error!.localizedDescription)")
                }
            }
        }
    }
    
    func checkValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
