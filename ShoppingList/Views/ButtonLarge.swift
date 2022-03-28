//
//  ButtonLarge.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 12/01/2022.
//

import SwiftUI

struct ButtonLarge: View {
    var title: LocalizedStringKey
    var displaySpinner: Bool
    @State private var hasClicked = false
    var onClick: () -> Void
    
    
    var body: some View {
        Button(action: {
            hasClicked = true
            onClick()
        }) {
           displaySpinner && hasClicked
            ? AnyView(LoadingButton())
            : AnyView(ButtonContent(title: title))
        }.padding(.vertical, 12)
    }
}

struct ButtonContent: View {
    var title: LocalizedStringKey
    
    var body: some View {
        Text(title)
            .font(.system(size: 28, weight: .regular, design: .default))
            .foregroundColor(.themePrimary)
            .frame(width: 325, height: 48)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.themePrimary, lineWidth: 2)
            )
          
    }
}

struct LoadingButton: View {
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .themePrimary))
            .foregroundColor(.themePrimary)
            .scaleEffect(1)
            .frame(width: 325, height: 48)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.themePrimary, lineWidth: 2)
        )
    }
}
