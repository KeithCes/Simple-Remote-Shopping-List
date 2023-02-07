//
//  CreateNewListView.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/6/23.
//

import Foundation
import SwiftUI

struct CreateNewListView: View {
    
    @StateObject private var viewModel = CreateNewListViewModel()
    
    @Binding var isShowingCreateNewList: Bool
    
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.isShowingCreateNewList.toggle()
                }, label: {
                    Image(systemName: "x.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(SRColors.white)
                })
                
                Spacer()
            }
            .padding(.top, 50)
            .padding(.leading, 20)
            
            VStack {
                List {
                    ForEach(0..<viewModel.items.count, id: \.self) { index in
                        TextField("", text: $viewModel.items[index], onEditingChanged: { edit in
                            viewModel.isEditing = edit
                        })
                        .foregroundColor(SRColors.blue)
                        .onTapGesture {
                            viewModel.selectedItem = viewModel.items[index]
                        }
                    }
                    .onDelete(perform: viewModel.delete)
                    .listRowBackground(SRColors.white.opacity(0.8))
                    .padding(.vertical, 5)
                    
                    HStack {
                        ZStack(alignment: .leading) {
                            if viewModel.newItem.isEmpty {
                                Text("Enter New Item")
                                    .foregroundColor(SRColors.white)
                            }
                            TextField("", text: $viewModel.newItem)
                                .foregroundColor(SRColors.blue)
                                .accentColor(SRColors.blue)
                                .submitLabel(.return)
                                .onSubmit {
                                    viewModel.addItem()
                                }
                        }
                        Button(action: {
                            viewModel.addItem()
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
                    }
                    .listRowBackground(SRColors.white.opacity(0.5))
                }
                .listStyle(InsetGroupedListStyle())
                .listRowBackground(SRColors.white)
                .scrollContentBackground(.hidden)
                .background(Rectangle()
                        .fill(SRColors.white.opacity(0.1))
                        .cornerRadius(5))
                .padding(.all, 20)
                .frame(height: (UIScreen.main.bounds.height / 2 + 100))
            }
            
            SRButton(text: "SAVE", isOutline: false) {
                
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(SRColors.blue)
        .ignoresSafeArea()
    }
}
