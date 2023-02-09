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
            
            VStack {
                List {
                    if viewModel.shoppingLists.count > 0 {
                        ForEach(0..<viewModel.shoppingLists.count, id: \.self) { index in
                            HStack {
                                SRText(text: viewModel.shoppingLists[index].title, fontSize: 16)
                                    .foregroundColor(SRColors.blue)
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
                        Text("ADD A NEW ITEM BELOW!")
                            .foregroundColor(SRColors.white)
                            .padding(.leading, 20)
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
            .frame(height: (UIScreen.main.bounds.height / 2))
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button(action: {
                    viewModel.isShowingEditShoppingList.toggle()
                }, label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(SRColors.white)
                            .frame(width: 48, height: 48)
                            .cornerRadius(48)
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(Color.black)
                    }
                })
                .padding(.vertical, 32)
                .padding(.trailing, 16)
            }
        }
        .fullScreenCover(isPresented: $viewModel.isShowingEditShoppingList, onDismiss: {
            viewModel.selectedShoppingList = nil
        }) {
            EditShoppingListView(isShowingCreateNewList: $viewModel.isShowingEditShoppingList,
                                 selectedShoppingList: $viewModel.selectedShoppingList)
        }
        .onAppear{
            viewModel.getYourLists()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(SRColors.blue)
        .ignoresSafeArea()
    }
}
