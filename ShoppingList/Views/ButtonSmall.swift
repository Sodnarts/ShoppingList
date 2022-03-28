//
//  ButtonSmall.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 12/01/2022.
//

import SwiftUI

struct ButtonSmall: View {
    var title: String
    var onClick: () -> Void
    
    var body: some View {
        Button(action: {}) {
            Text(title).font(.system(size: 20, weight: .light, design: .default))
                .foregroundColor(.themePrimary)
                .frame(width: 112, height: 48, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                    RoundedRectangle(cornerRadius: 100)
                        .stroke(Color.themePrimary, lineWidth: 2)
                )
                
        }
    }
}

