//
//  CreateHousehold.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 15/01/2022.
//

import SwiftUI

struct CreateHousehold: View {
    @EnvironmentObject var viewModel: ShoppingListViewModel
    @State var houseName = ""
    
    var body: some View {
        ZStack {
            Color.themeBackground.ignoresSafeArea()
            
            VStack {
                Text(LocalizedStringKey("Enter your house name")).font(.system(size: 20, weight: .light, design: .default)).foregroundColor(.white).padding(.horizontal, 24)
                LabeledInputField(input: $houseName, placeholder: LocalizedStringKey("House name"), type: InputType.Plaintext, sfSymbol: "house.fill")
                Spacer()
                ButtonLarge(title: LocalizedStringKey("Create"), displaySpinner: true) {
                    viewModel.createHousehold(id: viewModel.auth.currentUser?.uid ?? "", houseName: houseName, shoppingList: [], currentList: [], nextList: [])
                }
            }
        }
    }
}

struct CreateHousehold_Previews: PreviewProvider {
    static var previews: some View {
        CreateHousehold()
    }
}
