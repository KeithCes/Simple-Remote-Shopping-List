//
//  SRText.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/4/23.
//

import Foundation
import SwiftUI

// default text; fontsize can be modified
struct SRText: View {
    var text: String
    var fontSize: CGFloat
    
    var body: some View {
        Text(self.text)
            .font(.custom("SFProText-Medium", size: self.fontSize))
            .fixedSize(horizontal: false, vertical: true)
    }
}

