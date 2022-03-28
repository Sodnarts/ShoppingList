//
//  CustomNavigationLink.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 14/01/2022.
//

import SwiftUI

struct CustomNavigationLink: View {
    var title: LocalizedStringKey
    var destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            Text(title).font(.system(size: 28, weight: .regular, design: .default))
                .foregroundColor(.themePrimary)
                .frame(width: 325, height: 48)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.themePrimary, lineWidth: 2)
                )
              
        }.padding(.vertical, 12)
    }
}

