//
//  ContentView.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 11/01/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ShoppingListViewModel

    var body: some View {
        ZStack {
            Color.themeBackground.edgesIgnoringSafeArea(.all)
            if viewModel.signedIn && viewModel.getUserDefaults(key: "hasHousehold") {
                LoggedInContent()
            } else if viewModel.signedIn {
                RegisterHouseholdContent()
            } else {
                LoggedOutContent()
            }
        }.onAppear() {
            viewModel.initialLoad()
        }
    }
}

struct LoggedInContent: View {
    
    init() {
        UINavigationBar.appearance().backgroundColor = UIColorFromHex(rgbValue: 0x222222, alpha: 1)
        UINavigationBar.appearance().barTintColor = UIColorFromHex(rgbValue: 0x222222, alpha: 1)
    }
    
    var body: some View {
        ZStack {
            Color.themeBackground.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            ZStack {
                NavigationView {
                    BottomNavBar()
                }
                VStack {
                    Logo()
                    Spacer()
                }
            }
        }
    }
}

struct RegisterHouseholdContent: View {
    var body: some View {
        ZStack {
            Color.themeBackground.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            ZStack {
                NavigationView {
                    HouseholdSelection()
                }
                VStack {
                    Logo()
                    Spacer()
                }
            }
        }
    }
}

struct LoggedOutContent: View {
    var body: some View {
            ZStack {
                Color.themeBackground.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                ZStack {
                    NavigationView {
                        Landing()
                    }
                    VStack {
                        Logo()
                        Spacer()
                    }
                }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

