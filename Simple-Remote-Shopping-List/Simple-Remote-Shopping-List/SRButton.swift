//
//  SRButton.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/4/23.
//

import Foundation
import SwiftUI

// general use button for  views
// isOutline to convert from default black to wireframe white
// isActive to make button grayed out; make sure to disable clicked action
struct SRButton: View {
    var text: String
    var isOutline: Bool
    
    var clicked: (() -> Void)
    
    var body: some View {
        Button(action: self.clicked) {
            HStack {
                Text(self.text)
                   .font(.custom("SFProText-Medium", size: 16))
            }
            .foregroundColor(self.isOutline ? Color.black : Color.white)
            .frame(minHeight: 54, maxHeight: 54)
            .frame(maxWidth: .infinity)
            .background(self.isOutline ? Color.white : Color.black)
            .cornerRadius(3)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.black)
            )
            .padding(.horizontal, 20)
        }
    }
}

