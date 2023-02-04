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
            
            SRTextbox(field: $viewModel.email, placeholderText: "Email")
                .padding(.bottom, 30)
                .textInputAutocapitalization(.never)
            
            SRPasswordTextbox(field: $viewModel.password, placeholderText: "Password")
                .padding(.bottom, 30)
                .submitLabel(.done)
                .onSubmit {
                    viewModel.login()
                }
            
            SRButton(text: "LOGIN", isOutline: false) {
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(SRColors.sand)
        .ignoresSafeArea()
    }
}
