//
//  SRTextbox.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/4/23.
//

import Foundation
import SwiftUI
import Combine

// default textbox used across app
// placeholder text is text in textbox before user types
// titleText is optional to modify title text above textbox; default is placeholder text uppercased
struct SRTextbox: View {
    
    @Binding var field: String
    var placeholderText: String
    var charLimit: Int = 30
    var titleText: String = ""
    
    var body: some View {
        VStack {
            // small text title above field
            HStack {
                Text(self.titleText != "" ? self.titleText : self.placeholderText.uppercased())
                    .foregroundColor(Color.black)
                    .font(.custom("SFProText-Medium", size: 10))
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding(.bottom, 6)
            
            TextField(self.placeholderText, text: self.$field)
                .padding(.leading, 17)
                .font(.custom("SFProText-Medium", size: 16))
                .foregroundColor(Color.gray)
                .fixedSize(horizontal: false, vertical: true)
                .background(Rectangle()
                    .fill(SRColors.darkGray)
                    .frame(height: 46)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(2))
                .onReceive(Just(self.field)) { _ in limitText(self.charLimit) }
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, 20)
    }
    
    func limitText(_ upper: Int) {
        if self.field.count > upper {
            self.field = String(self.field.prefix(upper))
        }
    }
}

