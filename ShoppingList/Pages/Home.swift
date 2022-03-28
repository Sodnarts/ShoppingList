//
//  Home.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 12/01/2022.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var viewModel: ShoppingListViewModel
    
    var body: some View {
        ZStack {
            Color.themeBackground.edgesIgnoringSafeArea(.all)
            VStack {
                HouseholdInfo(title: viewModel.householdName, code: viewModel.householdId)
                Spacer()
                TodayView(title: LocalizedStringKey("Today's dish:"), dish: "Quesedillas")
                ButtonBar()
            }
        }.alert(isPresented: $viewModel.displayDialog,
                InputDialog(title: NSLocalizedString("Price", comment: "Price"),
                            message: NSLocalizedString("Please enter the total price of your last shopping cart", comment: "Please enter the total price of your last shopping cart"),
                            placeholder: NSLocalizedString("Enter price", comment: "Enter price"),
                            keyboardType: .numberPad) { result in
                    if let text = result {
                        guard !text.isEmpty else {
                            print("Price was empty")
                            return
                        }
                        viewModel.updateReceipt(id: viewModel.householdId, price: text)
                    }
        }).background(Color.themeBackground).ignoresSafeArea()
    }
}

struct HouseholdInfo: View {
    var title: String
    var code: String
    
    var body: some View {
        VStack {
            Text(title).font(.system(size: 28, weight: .light, design: .default))
                .foregroundColor(.white)
                
            Text(code).font(.system(size: 16, weight: .thin, design: .default))
                .foregroundColor(.white)
        }.padding(.bottom, 72)
    }
}

struct TodayView: View {
    var title: LocalizedStringKey
    var dish: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title).font(.system(size: 14, weight: .light, design: .default)).foregroundColor(.white)
                    .padding(.bottom, 1)
                Text(dish).font(.system(size: 20, weight: .light, design: .default)).foregroundColor(.white)
            }.padding(.leading, 24)
            Spacer()
            Badge(servings: "4", imagePath: "cuttlery")
            Spacer()
            TextBadge(time: "40", format: "min")
            Spacer()
        }.padding(.bottom, 64)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
