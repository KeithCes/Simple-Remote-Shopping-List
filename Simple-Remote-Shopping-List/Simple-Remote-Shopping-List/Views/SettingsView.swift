//
//  SettingsView.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/21/23.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    
    @Binding var isShowingSettings: Bool
    
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.isShowingSettings.toggle()
                }, label: {
                    Image(systemName: "x.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(SRColors.white)
                })
                
                Spacer()
                
                SRButtonCircleSymbol(symbolName: "rectangle.portrait.and.arrow.right", accessibilityID: "logoutButton") {
                    viewModel.logoutUser()
                }
            }
            .padding(.top, 50)
            .padding(.horizontal, 16)
            
            SRText(text: "SETTINGS", fontSize: 30)
                .padding(.top, 80)
            
            SRButton(text: "DELETE ACCOUNT") {
                viewModel.isShowingConfirmationPopup.toggle()
            }
            .padding(.top, 120)
            
            Spacer()
        }
        .sheet(isPresented: $viewModel.isShowingConfirmationPopup) {
            SRPopupView(
                title: "Are you sure?",
                message: "This action cannot be undone.",
                confirmAction: {
                    viewModel.deleteUser()
                },
                cancelAction: {
                    viewModel.isShowingConfirmationPopup.toggle()
                }
            )
            .presentationDetents([.medium])
        }
        .fullScreenCover(isPresented: $viewModel.isUserLoggedOut) {
            PrelogView()
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(SRColors.blue)
    }
}
