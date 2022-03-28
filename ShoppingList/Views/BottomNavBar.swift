//
//  BottomNavBar.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 12/01/2022.
//

import SwiftUI

struct BottomNavBar: View {
    @State private var selection = 1
    
    init() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColorFromHex(rgbValue: 0x333333, alpha: 1)
        UITabBar.appearance().backgroundColor = UIColorFromHex(rgbValue: 0x333333, alpha: 1)
    }
    
    var body: some View {
        TabView(selection: $selection) {
            Calendar()
                .tabItem() {
                    Label(LocalizedStringKey("Calendar"), systemImage: "calendar")
                }.tag(0)
            Home()
                .tabItem() {
                    Label(LocalizedStringKey("Home"), systemImage: "house.fill")
                }.tag(1)
            ShoppingList()
                .tabItem() {
                    Label(LocalizedStringKey("List"), systemImage: "doc.text")
                }.tag(2)
        }.accentColor(.themePrimary)
    }
}

struct BottomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavBar()
    }
}
