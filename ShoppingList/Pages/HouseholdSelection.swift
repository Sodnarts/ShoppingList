//
//  HouseholdSelection.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 15/01/2022.
//

import SwiftUI

struct HouseholdSelection: View {
    @EnvironmentObject var viewModel: ShoppingListViewModel
    
    var body: some View {
        ZStack {
            Color.themeBackground.ignoresSafeArea()
            
            VStack {
                Text(String(format: NSLocalizedString("Welcome, %@!", comment: "Welcome, %@!"), viewModel.userName)).foregroundColor(.white).font(.system(size: 24, weight: .light, design: .default)).padding(.bottom, 8)
                Text(LocalizedStringKey("To use the app you need to be registered in a household. Either join an existing household, or create one yourself."))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white).padding(.horizontal, 24)
                Spacer()
                CustomNavigationLink(title: LocalizedStringKey("Join"), destination: AnyView(JoinHousehold()))
                CustomNavigationLink(title: LocalizedStringKey("Create"), destination: AnyView(CreateHousehold()))
            }
        }
    }
}

struct HouseholdSelection_Previews: PreviewProvider {
    static var previews: some View {
        HouseholdSelection()
    }
}
