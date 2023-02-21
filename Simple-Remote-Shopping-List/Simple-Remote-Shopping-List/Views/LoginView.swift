//
//  LoginView.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/4/23.
//


import Foundation
import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    
    @Binding var isShowingLogin: Bool
    
    
    var body: some View {
        VStack {
            SRText(text: "LOGIN", fontSize: 24)
                .padding(.top, 40)
            
            SRTextbox(field: $viewModel.email, placeholderText: "Email", accessibilityID: "loginEmailField")
                .padding(.bottom, 30)
                .textInputAutocapitalization(.never)
            
            SRPasswordTextbox(field: $viewModel.password, placeholderText: "Password", accessibilityID: "loginPasswordField")
                .padding(.bottom, 30)
                .submitLabel(.done)
                .onSubmit {
                    viewModel.login()
                }
            
            SRButton(text: "LOGIN", accessibilityID: "loginButton") {
                viewModel.login()
            }
            
            Spacer()
        }
        .toast(message: viewModel.toastMessage,
               isShowing: $viewModel.isShowingToast,
               duration: Toast.long
        )
        .onChange(of: viewModel.isShowingLogin, perform: { _ in
            self.isShowingLogin.toggle()
        })
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(SRColors.blue)
    }
}
