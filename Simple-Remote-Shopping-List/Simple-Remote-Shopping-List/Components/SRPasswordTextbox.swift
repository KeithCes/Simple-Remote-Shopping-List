//
//  SRPasswordTextbox.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/4/23.
//

import Foundation
import SwiftUI
import Combine

// default password field, functions similarly to SHTextbox with some quirks
struct SRPasswordTextbox: View {
    
    @Binding var field: String
    var placeholderText: String
    
    var body: some View {
        VStack {
            // small text title above field
            HStack {
                Text(self.placeholderText.uppercased())
                    .foregroundColor(SRColors.white)
                    .font(.custom("SFProText-Medium", size: 10))
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding(.bottom, 6)
            
            ZStack(alignment: .leading) {
                if self.field.isEmpty {
                    Text(self.placeholderText)
                        .foregroundColor(SRColors.white)
                        .padding(.leading, 18)
                }
                SecureField("", text: self.$field)
                    .padding(.leading, 17)
                    .font(.system(size: 18, weight: .regular, design: .rounded))
                    .foregroundColor(SRColors.blue)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
                    .background(Rectangle()
                        .fill(SRColors.white.opacity(0.5))
                        .frame(height: 46)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10))
                    .onReceive(Just(self.field)) { _ in limitText(30) }
            }
        }
        .padding(.horizontal, 20)
    }
    
    func limitText(_ upper: Int) {
        if self.field.count > upper {
            self.field = String(self.field.prefix(upper))
        }
    }
}

