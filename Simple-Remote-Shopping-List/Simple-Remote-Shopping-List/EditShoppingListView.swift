//
//  EditShoppingListView.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/6/23.
//

import Foundation
import SwiftUI

struct EditShoppingListView: View {
    
    @StateObject private var viewModel = EditShoppingListViewModel()
    
    @Binding var isShowingCreateNewList: Bool
    
    @Binding var selectedShoppingList: ShoppingList?
    
    
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
            
            ZStack {
                if viewModel.listTitle.isEmpty {
                    HStack {
                        Spacer()
                        Text("New Shopping List")
                            .foregroundColor(SRColors.white)
                        Spacer()
                    }
                }
                TextField(viewModel.listTitle, text: $viewModel.listTitle)
                    .foregroundColor(SRColors.blue)
                    .accentColor(SRColors.blue)
                    .submitLabel(.done)
                    .multilineTextAlignment(.center)
            }
            .font(.custom("SFProText-Medium", size: 30))
            .background(Rectangle()
                .fill(SRColors.white.opacity(0.5))
                .frame(height: 46)
                .frame(maxWidth: .infinity)
                .cornerRadius(10))
            .padding(.all, 20)
            
            VStack {
                List {
                    if viewModel.items.count > 0 {
                        ForEach(0..<viewModel.items.count, id: \.self) { index in
                            HStack {
                                TextField("", text: $viewModel.items[index].name, onEditingChanged: { edit in
                                    viewModel.isEditing = edit
                                })
                                .foregroundColor(SRColors.blue)
                                .onTapGesture {
                                    if viewModel.items.count > index {
                                        viewModel.selectedItem = viewModel.items[index]
                                    }
                                }
                                .strikethrough(viewModel.items[index].isChecked)
                                .submitLabel(.done)
                                
                                Spacer()
                                
                                Image(systemName: "x.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.red)
                                    .onTapGesture {
                                        viewModel.items[index].isChecked.toggle()
                                    }
                            }
                            .listRowBackground(viewModel.items[index].isChecked ? SRColors.white.opacity(0.4) : SRColors.white.opacity(0.8))
                        }
                        .onDelete(perform: viewModel.delete)
                        .padding(.vertical, 5)
                    }
                    else {
                        Text("ADD A NEW ITEM BELOW!")
                            .foregroundColor(SRColors.white)
                            .padding(.leading, 20)
                            .listRowBackground(SRColors.blue)
                    }
                }
                
                HStack {
                    ZStack(alignment: .leading) {
                        if viewModel.newItemName.isEmpty {
                            Text("Enter New Item")
                                .foregroundColor(SRColors.white)
                                .padding(.leading, 20)
                        }
                        TextField("", text: $viewModel.newItemName)
                            .padding(.leading, 20)
                            .foregroundColor(SRColors.blue)
                            .accentColor(SRColors.blue)
                            .submitLabel(.done)
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
                    .padding(.trailing, 20)
                }
                .background(Rectangle()
                    .fill(SRColors.white.opacity(0.5))
                    .cornerRadius(5))
            }
            .listStyle(InsetGroupedListStyle())
            .listRowBackground(SRColors.white)
            .scrollContentBackground(.hidden)
            .background(Rectangle()
                .fill(SRColors.white.opacity(0.1))
                .cornerRadius(10))
            .padding(.all, 20)
            .frame(height: (UIScreen.main.bounds.height / 2))
            
            
            
            SRButton(text: "SAVE") {
                viewModel.sendShoppingListFirebase()
                self.isShowingCreateNewList.toggle()
            }
            
            Spacer()
        }
        .onAppear {
            guard let listTitle = self.selectedShoppingList?.title,
                  let listItems = self.selectedShoppingList?.items,
                  let listID = self.selectedShoppingList?.ID else {
                return
            }
            viewModel.listTitle = listTitle
            viewModel.items = listItems
            viewModel.listID = listID
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(SRColors.blue)
        .ignoresSafeArea()
    }
}
