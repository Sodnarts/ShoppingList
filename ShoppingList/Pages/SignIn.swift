//
//  SignIn.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 14/01/2022.
//

import SwiftUI

struct SignIn: View {
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var viewModel: ShoppingListViewModel
    
    var body: some View {
        ZStack {
            Color.themeBackground.edgesIgnoringSafeArea(.all)
            
            
            VStack {
                Text(LocalizedStringKey("Sign in using your email and password"))
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20, weight: .light, design: .default))
                    .foregroundColor(.white).padding(.horizontal, 24)
                LabeledInputField(input: $email, placeholder: LocalizedStringKey("E-Mail"), type: InputType.Email, sfSymbol: "envelope.fill")
                LabeledInputField(input: $password, placeholder: LocalizedStringKey("Password"), type: InputType.Password, sfSymbol: "lock.fill")
                Text(viewModel.errorSigningInOrUp).foregroundColor(.themeError).padding(.horizontal, 24)
                Spacer()
                ButtonLarge(title: LocalizedStringKey("Sign In"), displaySpinner: viewModel.errorSigningInOrUp.isEmpty ? true : false) {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    viewModel.signIn(email: email, password: password)
                }
            }.onDisappear() {
                viewModel.errorSigningInOrUp = ""
            }
        }
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}

private enum Field: Int, Hashable {
    case email, password
}
