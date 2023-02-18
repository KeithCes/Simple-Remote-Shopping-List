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
        
        // MARK: - Navigation
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
            
            // MARK: - Title
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
            
            // MARK: - List of Items
            VStack {
                List {
                    if !viewModel.items.isEmpty {
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
                                
                                Image(systemName: viewModel.items[index].isChecked ? "checkmark.square" : "square")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(viewModel.items[index].isChecked ? .green : .red)
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
                        HStack {
                            Spacer()
                            Text("ADD A NEW ITEM BELOW!")
                                .foregroundColor(SRColors.white)
                            Spacer()
                        }
                        .listRowBackground(SRColors.blue)
                    }
                }
                
                // MARK: - Add new item
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
            
            
            // MARK: - Save
            SRButton(text: "SAVE") {
                viewModel.sendShoppingListFirebase()
            }
            
            Spacer()
        }
        
        // MARK: - Lifecycle handling
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
        .onChange(of: viewModel.isSuccessfullySentToFirebase) { success in
            if success {
                self.isShowingCreateNewList.toggle()
            }
        }
        .toast(message: viewModel.toastMessage,
               isShowing: $viewModel.isShowingToast,
               duration: Toast.long
        )
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(SRColors.blue)
    }
}
