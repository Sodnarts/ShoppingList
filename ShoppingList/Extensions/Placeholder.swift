//
//  Placeholder.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 14/01/2022.
//

import Foundation
import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 0.5 : 0)
            self
        }
    }
}
