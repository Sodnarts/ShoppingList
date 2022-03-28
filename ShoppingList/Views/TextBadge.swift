//
//  TextBadge.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 12/01/2022.
//

import SwiftUI

struct TextBadge: View {
    var time: String
    var format: String
    
    var body: some View {
        ZStack {
            HStack {
                Text(time).font(.system(size: 12, weight: .light, design: .default)).foregroundColor(.white)
                
                Text(format).font(.system(size: 12, weight: .light, design: .default)).foregroundColor(.white).padding(.leading, -7)
            }
            Circle().strokeBorder(Color.themePrimary, lineWidth: 2).frame(width: 48, height: 48, alignment: .center)
        }
    }
}

struct TextBadge_Previews: PreviewProvider {
    static var previews: some View {
        TextBadge(time: "40", format: "min")
    }
}
