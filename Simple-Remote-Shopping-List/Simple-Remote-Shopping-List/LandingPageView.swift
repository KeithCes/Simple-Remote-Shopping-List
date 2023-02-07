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
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button(action: {
                    viewModel.isShowingCreateNewList.toggle()
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
        .fullScreenCover(isPresented: $viewModel.isShowingCreateNewList) {
            CreateNewListView(isShowingCreateNewList: $viewModel.isShowingCreateNewList)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(SRColors.blue)
        .ignoresSafeArea()
    }
}
