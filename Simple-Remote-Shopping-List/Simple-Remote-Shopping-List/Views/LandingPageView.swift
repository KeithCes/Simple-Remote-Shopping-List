//
//  LandingPageView.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/6/23.
//

import Foundation
import SwiftUI

struct LandingPageView: View {
    
    @StateObject private var viewModel = LandingPageViewModel()
    

    var body: some View {
        VStack {
            
            SRText(text: "SHOPPING LISTS", fontSize: 30)
                .padding(.top, 60)
            
            // MARK: - Shopping List
            VStack {
                List {
                    if viewModel.shoppingLists.count > 0 {
                        ForEach(0..<viewModel.shoppingLists.count, id: \.self) { index in
                            HStack {
                                SRText(text: viewModel.shoppingLists[index].title, fontSize: 16, textColor: SRColors.blue)
                                Spacer()
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                viewModel.selectedShoppingList = viewModel.shoppingLists[index]
                                viewModel.isShowingEditShoppingList.toggle()
                            }
                        }
                        .listRowBackground(SRColors.white.opacity(0.8))
                        .padding(.vertical, 5)
                    }
                    else {
                        HStack {
                            Spacer()
                            Text("ADD A NEW LIST!")
                                .foregroundColor(SRColors.white)
                            Spacer()
                        }
                        .onTapGesture {
                            viewModel.isShowingEditShoppingList.toggle()
                        }
                        .listRowBackground(SRColors.blue)
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .listRowBackground(SRColors.white)
            .scrollContentBackground(.hidden)
            .background(Rectangle()
                .fill(SRColors.white.opacity(0.1))
                .cornerRadius(10))
            .padding(.all, 20)
            .frame(height: (UIScreen.main.bounds.height / 2) + 150)
            
            Spacer()
            
            // MARK: - Settings and Create List Buttons
            HStack {
                SRButtonCircleSymbol(symbolName: "gear", accessibilityID: "settingsButton") {
                    viewModel.isShowingSettings.toggle()
                }
                .padding(.leading, 16)
                
                Spacer()
                
                SRButtonCircleSymbol(symbolName: "plus", accessibilityID: "createListButton") {
                    viewModel.isShowingEditShoppingList.toggle()
                }
                .padding(.trailing, 16)
            }
        }
        // MARK: - Progress View
        .overlay(
            ProgressView()
                .scaleEffect(x: 2, y: 2, anchor: .center)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                .background(RoundedRectangle(cornerRadius: 3)
                    .fill(SRColors.blue))
                .progressViewStyle(CircularProgressViewStyle(tint: SRColors.white))
                .isHidden(viewModel.isProgressViewHidden)
        )
        // MARK: - Full Screen Covers
        .fullScreenCover(isPresented: $viewModel.isShowingEditShoppingList, onDismiss: {
            viewModel.selectedShoppingList = nil
            viewModel.getYourLists()
        }) {
            EditShoppingListView(isShowingCreateNewList: $viewModel.isShowingEditShoppingList,
                                 selectedShoppingList: $viewModel.selectedShoppingList)
        }
        .fullScreenCover(isPresented: $viewModel.isShowingSettings) {
            SettingsView(isShowingSettings: $viewModel.isShowingSettings)
        }
        .onAppear{
            // force hide progress view during uitest
            #if UITest
            viewModel.isProgressViewHidden = true
            #endif
            
            viewModel.getYourLists()
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(SRColors.blue)
    }
}
