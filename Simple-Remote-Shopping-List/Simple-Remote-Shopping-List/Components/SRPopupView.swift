//
//  SRPopupView.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/21/23.
//

import Foundation
import SwiftUI

struct SRPopupView: View {
    let title: String
    let message: String
    let confirmAction: () -> Void
    let cancelAction: (() -> Void)?
    
    var body: some View {
        VStack {
            SRText(text: self.title, fontSize: 30)
                .padding(.bottom, 10)
            SRText(text: self.message, fontSize: 18)
                .padding(.bottom, 30)
            HStack {
                Button("Cancel") {
                    self.cancelAction?()
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .background(Color.gray)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                Button("Confirm") {
                    self.confirmAction()
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(10)
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(SRColors.blue)
    }
}
