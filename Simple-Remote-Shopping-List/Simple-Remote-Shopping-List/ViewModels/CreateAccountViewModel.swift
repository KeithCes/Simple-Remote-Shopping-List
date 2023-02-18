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
    
    // MARK: - Properties
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var isShowingCreate: Bool = true
    
    @Published var isShowingToast: Bool = false
    @Published var toastMessage: String = "Error"
    
    // MARK: - Methods
    
    // validates if user input is valid for creation
    func isCreateInfoValid() -> Bool {
        return email.count > 0 && checkValidEmail(email: email) && password == confirmPassword
    }
    
    // sets toast message based on validation of user input
    func checkPostErrorToast() {
        if email.count <= 0 || !checkValidEmail(email: email) {
            self.showErrorToast(message: "Email is not valid")
        }
        if password.count < 6 {
            self.showErrorToast(message: "Password is too short")
        }
        else if password != confirmPassword {
            self.showErrorToast(message: "Password confirmation must match")
        }
    }
    
    // creates account in firebase and saves user details in firebase
    func createAccount() {
        
        guard isCreateInfoValid() else {
            self.checkPostErrorToast()
            return
        }
        
        let ref = Database.database().reference()
        
        DispatchQueue.global(qos: .background).async {
            Auth.auth().createUser(withEmail: self.email, password: self.password) { username, error in
                if error == nil && username != nil {
                    
                    let userID = Auth.auth().currentUser!.uid
                    
                    let userDetails = ["email": self.email] as [String : Any]
                    
                    ref.child("users").child(userID).child("userInfo").setValue(userDetails)
                    
                    print("user created")
                    
                    DispatchQueue.main.async {
                        self.isShowingCreate = false
                    }
                }
                else {
                    print("error:  \(error!.localizedDescription)")
                    self.showErrorToast(message: error!.localizedDescription)
                }
            }
        }
    }
    
    // check if email is valid
    func checkValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // shows error toast
    private func showErrorToast(message: String) {
        DispatchQueue.main.async {
            self.toastMessage = message
            self.isShowingToast = true
        }
    }
}
