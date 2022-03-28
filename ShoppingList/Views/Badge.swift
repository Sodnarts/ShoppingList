//
//  Badge.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 12/01/2022.
//

import SwiftUI

struct Badge: View {
    var servings: String
    var imagePath: String
    
    var body: some View {
      HStack {
        Text(servings).font(.system(size: 16, weight: .light, design: .default)).foregroundColor(.white)
        
        Image(imagePath).padding(.leading, -4).padding(.top, -2)
        }.overlay(GeometryReader{ geometry in
            Circle().strokeBorder(Color.themePrimary, lineWidth: 2).frame(width: 48, height: 48, alignment: .topLeading).padding(.leading, -8).padding(.top, -15)
        })
        
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge(servings: "4", imagePath: "fork.knife")
    }
}
