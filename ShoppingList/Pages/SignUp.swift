//
//  SignUp.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 14/01/2022.
//

import SwiftUI

struct SignUp: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var viewModel: ShoppingListViewModel
    
    var body: some View {
        ZStack {
            Color.themeBackground.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(LocalizedStringKey("Sign up using your email and password"))
                    .multilineTextAlignment(.center)
                    .font(.system(size: 20, weight: .light, design: .default))
                    .foregroundColor(.white).padding(.horizontal, 24)
                LabeledInputField(input: $name, placeholder: LocalizedStringKey("First Name"), type: InputType.Plaintext, sfSymbol: "person.fill")
                LabeledInputField(input: $email, placeholder: LocalizedStringKey("E-Mail"), type: InputType.Email, sfSymbol: "envelope.fill")
                LabeledInputField(input: $password, placeholder: LocalizedStringKey("Password"), type: InputType.Password, sfSymbol: "lock.fill")
                Text(viewModel.errorSigningInOrUp).foregroundColor(.themeError).padding(.horizontal, 24)
                Spacer()
                ButtonLarge(title: LocalizedStringKey("Sign Up"), displaySpinner: viewModel.errorSigningInOrUp.isEmpty ? true : false) {
                    viewModel.signUp(email: email, password: password, name: name)
                }
            }.onDisappear() {
                viewModel.errorSigningInOrUp = ""
            }
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
