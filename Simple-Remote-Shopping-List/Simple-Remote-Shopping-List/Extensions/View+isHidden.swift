//
//  View+isHidden.swift
//  Simple-Remote-Shopping-List
//
//  Created by Keith C on 2/9/23.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
}
