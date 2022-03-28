//
//  CustomTextField.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 13/01/2022.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var value: String
    
    var width: CGFloat
    var callback: () -> Void
    
    var body: some View {
        VStack {
            TextField("", text: $value, onEditingChanged: { isEditing in
                if !isEditing {
                    callback()
                }
            })
                .padding(.horizontal, 24)
                .foregroundColor(.white)
            Line()
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [4]))
                .frame(height: 1)
                .foregroundColor(.themePrimary)
                .padding(.horizontal, 16)
        }.padding(.bottom, 4)
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
