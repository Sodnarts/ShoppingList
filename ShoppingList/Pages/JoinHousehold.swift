//
//  JoinHousehold.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 15/01/2022.
//

import SwiftUI

struct JoinHousehold: View {
    @EnvironmentObject var viewModel: ShoppingListViewModel
    @State var code = ""
    
    var body: some View {
        ZStack {
            Color.themeBackground.ignoresSafeArea()
            
            VStack {
                Text(LocalizedStringKey("Enter your household's code")).font(.system(size: 20, weight: .light, design: .default)).foregroundColor(.white).padding(.horizontal, 24)
                LabeledInputField(input: $code, placeholder: LocalizedStringKey("Code"), type: InputType.Plaintext, sfSymbol: "number")
                Text(viewModel.errorInvalidHouseholdCode).foregroundColor(.themeError).padding(.horizontal, 24)
                Spacer()
                ButtonLarge(title: LocalizedStringKey("Join"), displaySpinner: viewModel.errorInvalidHouseholdCode.isEmpty ? true : false) {
                    viewModel.joinHousehold(id: viewModel.auth.currentUser?.uid ?? "", code: code.uppercased())
                }
            }
        }
    }
}

struct JoinHousehold_Previews: PreviewProvider {
    static var previews: some View {
        JoinHousehold()
    }
}
