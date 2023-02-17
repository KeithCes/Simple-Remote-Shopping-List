//
//  PrelogView.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/4/23.
//

import Foundation
import SwiftUI
import Combine
import FirebaseAuth

struct PrelogView: View {
    
    @StateObject private var viewModel = PrelogViewModel()
    
    var body: some View {
        VStack {
            if Auth.auth().currentUser == nil {
                
                SRButton(text: "LOGIN") {
                    viewModel.isShowingLogin.toggle()
                }
                .sheet(isPresented: $viewModel.isShowingLogin, onDismiss: {
                    // if uitest force user past geniue auth check, otherwise make sure user logged in successfully
                    if CommandLine.arguments.contains("-TestUserNotLoggedIn") {
                        viewModel.isLoggedIn.toggle()
                    }
                    else {
                        viewModel.checkUserLoggedIn()
                    }
                }) {
                    LoginView(isShowingLogin: $viewModel.isShowingLogin)
                }
                
                SRButton(text: "CREATE") {
                    viewModel.isShowingCreate.toggle()
                }
                .sheet(isPresented: $viewModel.isShowingCreate, onDismiss: {
                    viewModel.checkUserLoggedIn()
                }) {
                    CreateAccountView(isShowingCreate: $viewModel.isShowingCreate)
                }
            }
        }
        .onAppear {
            viewModel.checkUserLoggedIn()
        }
        .fullScreenCover(isPresented: $viewModel.isLoggedIn) {
            LandingPageView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(SRColors.blue)
        .ignoresSafeArea()
    }
}

