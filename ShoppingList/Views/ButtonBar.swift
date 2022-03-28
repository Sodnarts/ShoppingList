//
//  ButtonBar.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 16/01/2022.
//

import SwiftUI

struct ButtonBar: View {
    var body: some View {
        ZStack {
            Color.themeDarkGray.ignoresSafeArea()
            VStack {
                Spacer()
                Row1()
                Spacer()
                Row2()
                Spacer()
            }
        }.frame(height: 168, alignment: .center).cornerRadius(16).padding(.horizontal, 8).padding(.bottom, 12).shadow(radius: 2).shadow(radius: 8)
    }
}

struct Row1: View {
    @EnvironmentObject var viewModel: ShoppingListViewModel
    
    var body: some View {
        HStack {
            Spacer()
            SheetPopupButton()
            Spacer()
            NavigationCircle(title: LocalizedStringKey("Receipts"), sfSymbol: "scroll.fill", destination: AnyView(Receipts()))
            Spacer()
            ButtonCircle(title: LocalizedStringKey("Placeholder"), sfSymbol: "questionmark") {}
            Spacer()
        }
    }
}

struct Row2: View {
    @EnvironmentObject var viewModel: ShoppingListViewModel
    
    var body: some View {
        HStack {
            Spacer()
            NavigationCircle(title: LocalizedStringKey("Household"), sfSymbol: "house.fill", destination: AnyView(HouseholdDetails()))
            Spacer()
            NavigationCircle(title: LocalizedStringKey("Settings"), sfSymbol: "gearshape.fill", destination: AnyView(Receipts()))
            Spacer()
            ButtonCircle(title: LocalizedStringKey("Sign out"), sfSymbol: "arrowshape.turn.up.forward.fill") {
                viewModel.signOut()
            }
            Spacer()
        }
    }
}

struct ButtonCircle: View {
    var title: LocalizedStringKey
    var sfSymbol: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {action()}) {
            VStack {
                ZStack {
                    Circle().strokeBorder(Color.themePrimary, lineWidth: 2).frame(width: 40, height: 40, alignment: .center)
                    Image(systemName: sfSymbol).font(.system(size: 20, weight: .regular, design: .default)).foregroundColor(.themePrimary).frame(width: 40, height: 40, alignment: .center)
                    
                }
                Text(title).font(.system(size: 12, weight: .light, design: .default)).foregroundColor(.white).padding(.top, -4)
                    .frame(width: 96, height: 12,
                           al
                           ignment: .center)
            }
        }
    }
}

struct NavigationCircle: View {
    var title: LocalizedStringKey
    var sfSymbol: String
    var destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack {
                ZStack {
                    Circle().strokeBorder(Color.themePrimary, lineWidth: 2).frame(width: 40, height: 40, alignment: .center)
                    Image(systemName: sfSymbol).font(.system(size: 20, weight: .regular, design: .default)).foregroundColor(.themePrimary).frame(width: 40, height: 40, alignment: .center)
                }
                Text(title).font(.system(size: 12, weight: .light, design: .default)).foregroundColor(.white).padding(.top, -4)
                    .frame(width: 96, height: 12, alignment: .center)
            }
        }
    }
}


struct SheetPopupButton: View {
    @State private var showingSheet = false
    
    var body: some View {
        ButtonCircle(title: LocalizedStringKey("Shop"), sfSymbol: "cart.fill") {
            showingSheet.toggle()
        }.sheet(isPresented: $showingSheet) {
            ShoppingSheet()
        }
    }
}
