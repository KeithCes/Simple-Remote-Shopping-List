//
//  SRButton.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/4/23.
//

import Foundation
import SwiftUI

// general use button for views
struct SRButton: View {
    var text: String
    
    var clicked: (() -> Void)
    
    var body: some View {
        Button(action: self.clicked) {
            HStack {
                Text(self.text)
                   .font(.custom("SFProText-Medium", size: 16))
            }
            .foregroundColor(SRColors.blue)
            .frame(minHeight: 54, maxHeight: 54)
            .frame(maxWidth: .infinity)
            .background(Rectangle()
                .fill(SRColors.white.opacity(0.5))
                .frame(width: 250, height: 50)
                .cornerRadius(10)
            )
            .padding(.horizontal, 20)
        }
    }
}

