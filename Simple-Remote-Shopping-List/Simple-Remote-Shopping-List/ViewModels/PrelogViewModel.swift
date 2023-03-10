//
//  PrelogViewModel.swift
//  Printeroo
//
//  Created by Admin on 9/10/22.
//

import Foundation
import SwiftUI
import FirebaseAuth

final class PrelogViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var isShowingLogin: Bool = false
    @Published var isShowingCreate: Bool = false
    @Published var isCreateSuccessful: Bool = false
    @Published var isShowingTutorial: Bool = false
    
    @Published var isLoggedIn: Bool = false
    
    // MARK: - Methods
    
    func checkUserLoggedInSheetDismissed() {
        // if uitest force user past geniue auth check, otherwise make sure user logged in successfully
        #if UITest
        self.isLoggedIn.toggle()
        return
        #endif
        
        self.checkUserLoggedIn()
    }
    
    func checkUserLoggedIn() {
        
        // uncomment to force user log out
        //try! Auth.auth().signOut()
        
        if Auth.auth().currentUser == nil {
            return
        }
        self.isLoggedIn.toggle()
    }
}
