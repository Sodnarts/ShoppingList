//
//  List.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 12/01/2022.
//

import SwiftUI

struct ShoppingList: View {
    @EnvironmentObject var viewModel: ShoppingListViewModel
    
    @State var shoppingItems: [String] = []
    
    var body: some View {
        ZStack {
            Color.themeBackground
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ScrollView {
                    ForEach(0..<shoppingItems.count, id: \.self) { index in
                        CustomTextField(value: Binding(
                            get: { shoppingItems[index] },
                            set: { shoppingItems[index] = $0 }), width: 300) {
                                var tmpList = shoppingItems
                                _ = tmpList.popLast()
                                viewModel.updateShoppingList(id: viewModel.householdId, list: tmpList) {}
                            }
                    }
                }
                Spacer()
            }
       }
        .onAppear() {
            shoppingItems = viewModel.shoppingList
            viewModel.getShoppingList(id: viewModel.householdId)
        }
        .onChange(of: viewModel.shoppingList) { newState in
            shoppingItems = newState
        }
        .onChange(of: shoppingItems) { newState in
            if newState[newState.count - 1].count > 0 {
                self.shoppingItems.append("")
            } else if newState[newState.count - 2].count == 0 {
                guard newState.count > 2 else {
                    return
                }
                _ = self.shoppingItems.popLast()
            }
        }
    }
}

struct ShoppingList_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingList()
    }
}

