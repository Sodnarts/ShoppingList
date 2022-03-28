//
//  BorderedElement.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 13/01/2022.
//

import SwiftUI

struct BorderedElement: View {
    @Binding var shoppingItem: ShoppingItem
    
    var body: some View {
        shoppingItem.isShopped ?
            AnyView(LineBorder(shoppingItem: $shoppingItem))
            :
            AnyView(DashedBorder(shoppingItem: $shoppingItem))
    }
}

struct DashedBorder: View {
    @Binding var shoppingItem: ShoppingItem
    @State private var phase: CGFloat = 0
    
    var body: some View {
        Button(action: {
            shoppingItem.isShopped.toggle()
        }) {
            ZStack {
                HStack {
                    Text(shoppingItem.name).foregroundColor(.white)
                    Spacer()
                }.padding(.horizontal, 24)
            
                RoundedRectangle(cornerSize: CGSize(width: 24, height: 24))
                    .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [4], dashPhase: phase))
                    .foregroundColor(Color.themePrimary)
                    .frame(height: 40)
            }.padding(.horizontal, 24)
        }
    }
}

struct LineBorder: View {
    @Binding var shoppingItem: ShoppingItem
    
    var body: some View {
        Button(action: {
            shoppingItem.isShopped.toggle()
        }) {
            ZStack {
                HStack {
                    Text(shoppingItem.name).foregroundColor(.white)
                    Spacer()
                    Image(systemName: "checkmark").font(.system(size: 18, weight: .bold, design: .default)).foregroundColor(Color.themePrimary)
                }.padding(.horizontal, 24)
            
                RoundedRectangle(cornerSize: CGSize(width: 24, height: 24))
                    .strokeBorder(Color.themePrimary, lineWidth: 3)
                    .foregroundColor(.themePrimary)
                    .frame(height: 40)
            }.padding(.horizontal, 24)
        }
    }
}
