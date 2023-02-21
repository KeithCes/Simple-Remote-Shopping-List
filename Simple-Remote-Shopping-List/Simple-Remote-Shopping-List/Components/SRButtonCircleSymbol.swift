//
//  SRButtonCircleSymbol.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/18/23.
//

import Foundation
import SwiftUI

// circle button with SF symbol inside; need accessibiltyID for uitesting
struct SRButtonCircleSymbol: View {
    var symbolName: String
    var accessibilityID: String = ""
    
    var clicked: (() -> Void)
    
    var body: some View {
        Button(action: self.clicked)  {
            ZStack {
                Rectangle()
                    .foregroundColor(SRColors.white)
                    .frame(width: 48, height: 48)
                    .cornerRadius(48)
                Image(systemName: self.symbolName)
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(Color.black)
            }
        }
        .padding(.vertical, 32)
        .accessibilityIdentifier(self.accessibilityID)
    }
}
