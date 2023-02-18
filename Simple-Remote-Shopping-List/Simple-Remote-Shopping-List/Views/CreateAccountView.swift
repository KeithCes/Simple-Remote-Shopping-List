//
//  CreateAccountView.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/4/23.
//

import Foundation
import SwiftUI
import Combine

struct CreateAccountView: View {
    
    @StateObject private var viewModel = CreateAccountViewModel()
    
    @Binding var isShowingCreate: Bool
    
    
    var body: some View {
        VStack {
            SRText(text: "CREATE ACCOUNT", fontSize: 24)
                .padding(.top, 40)
            
            SRTextbox(field: $viewModel.email, placeholderText: "Email", charLimit: 30)
                .padding(.bottom, 30)
                .textInputAutocapitalization(.never)
            
            SRPasswordTextbox(field: $viewModel.password, placeholderText: "Password")
                .padding(.bottom, 30)
            
            SRPasswordTextbox(field: $viewModel.confirmPassword, placeholderText: "Confirm Password")
                .padding(.bottom, 30)
                .submitLabel(.done)
                .onSubmit {
                    viewModel.checkPostErrorToast()
                    
                    if viewModel.isCreateInfoValid() {
                        viewModel.createAccount()
                    }
                }
            
            SRButton(text: "CREATE") {
                viewModel.checkPostErrorToast()
                
                if viewModel.isCreateInfoValid() {
                    viewModel.createAccount()
                }
            }
            
            Spacer()
            
        }
        .onChange(of: viewModel.isShowingCreate, perform: { _ in
            self.isShowingCreate.toggle()
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(SRColors.blue)
        .ignoresSafeArea()
    }
}
