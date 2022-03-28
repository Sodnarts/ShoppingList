//
//  Landing.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 14/01/2022.
//

import SwiftUI

struct Landing: View {
    var body: some View {
        ZStack {
            Color.themeBackground.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(LocalizedStringKey("Welcome to Shopping List")).font(.system(size: 24, weight: .light, design: .default))
                    .foregroundColor(.white).padding(.horizontal, 32)
                Text(LocalizedStringKey("The app that makes shopping a little better!")).font(.system(size: 16, weight: .light, design: .default)).foregroundColor(.white)
                Spacer()
                Image(systemName: "doc.plaintext.fill").foregroundColor(Color.themePrimary).font(.system(size: 128, weight: .regular, design: .default))
                Spacer()
                Buttons()
            }
        }
    }
}

struct Landing_Previews: PreviewProvider {
    static var previews: some View {
        Landing()
    }
}

struct Buttons: View {
    
    var body: some View {
        VStack {
            CustomNavigationLink(title: LocalizedStringKey("Sign In"), destination: AnyView(SignIn()))
            CustomNavigationLink(title: LocalizedStringKey("Sign Up"), destination: AnyView(SignUp()))
        }
    }
}
