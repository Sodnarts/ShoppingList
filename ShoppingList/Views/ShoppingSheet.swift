//
//  ShoppingSheet.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 13/01/2022.
//

import SwiftUI

struct ShoppingSheet: View {
    @EnvironmentObject var viewModel: ShoppingListViewModel
    
    var body: some View {
        ZStack {
            Color.themeBackground.edgesIgnoringSafeArea(.all)
            
            VStack {
                self.viewModel.shoppingList.count < 1 ? AnyView(Loading()) : AnyView(MainContent())
            }
        }.onAppear() {
            viewModel.getShoppingList(id: viewModel.householdId)
        }
    }
}

struct Loading: View {
    
    var body: some View {
        VStack {
            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .themePrimary)).foregroundColor(.themePrimary).scaleEffect(3)
        }
    }
}

struct MainContent: View {
    @EnvironmentObject var viewModel: ShoppingListViewModel
    @State var shoppingItems: [ShoppingItem] = []
    @State var currentItemsDone = 0
    @State var duration = 0
    
    var body: some View {
        VStack {
            TopInfo(timer: CalculateTime(duration: duration), currentItemsDone: currentItemsDone, totalItems: shoppingItems.count)
            
            ScrollView {
                ForEach(0..<shoppingItems.count, id: \.self) { index in
                    BorderedElement(shoppingItem: Binding(
                        get: { shoppingItems[index] },
                        set: { shoppingItems[index] = $0 })).padding(.vertical, 8)
                }
            }
            Spacer()
            BottomButton(shoppingItems: $shoppingItems, duration: $duration)
        }.onAppear() {
            shoppingItems = convertToShoppingItemList(list: viewModel.shoppingList)
            startTimer(speed: 1.0) {
                duration += 1
            }
        }.onChange(of: viewModel.shoppingList) { newState in
            shoppingItems = convertToShoppingItemList(list: newState)
        }.onChange(of: shoppingItems) { newState in
            var tmpCount = 0
            newState.forEach { (shoppingItem) in
                if shoppingItem.isShopped {
                    tmpCount = tmpCount + 1
                }
            }
            currentItemsDone = tmpCount
        }
    }
}

struct TopInfo: View {
    var timer: String
    var currentItemsDone: Int
    var totalItems: Int
    
    var body: some View {
        Rectangle().frame(width: 48, height: 3, alignment: .center).cornerRadius(8).foregroundColor(.themePrimary).padding(.top, 4)
        Text(timer).font(.system(size: 14, weight: .light, design: .default)).foregroundColor(.white)
        Text(String(format: NSLocalizedString("%d out of %d items", comment: "%d out of %d items"), currentItemsDone, totalItems)).font(.system(size: 24, weight: .light, design: .default)).foregroundColor(.white).padding(.top, 8)
        
    }
}

struct BottomButton: View {
    @EnvironmentObject var viewModel: ShoppingListViewModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var shoppingItems: [ShoppingItem]
    @Binding var duration: Int
    @State var cancelled = true
    var body: some View {
        ZStack {
            Color.themeBackground.edgesIgnoringSafeArea(.all)
            
            VStack {
                ButtonLarge(title: LocalizedStringKey("Stop Shopping"), displaySpinner: true) {
                    viewModel.updateShoppingList(id: viewModel.householdId, list: stopShopping(list: shoppingItems)) {
                        viewModel.generateReceipt(id: viewModel.householdId, list: generateReceiptList(list: shoppingItems), duration: duration, price: nil) {
                            presentationMode.wrappedValue.dismiss()
                            cancelled = false
                        }
                    }
                }
            }
        }.frame(height: 64, alignment: .bottom)
            .onDisappear {                if !cancelled {
                    viewModel.toggleDisplayDialog()
                }
            }
    }
}

private func startTimer(speed: Double, callback: @escaping () -> Void) {
    Timer.scheduledTimer(withTimeInterval: speed, repeats: true, block: { timer in
        callback()
    })
}

private func stopShopping(list: [ShoppingItem]) -> [String] {
    var tmpList: [String] = []
    
    list.forEach { s in
        guard s.isShopped == false else {
            return
        }
        tmpList.append(s.name)
    }
    
   return tmpList
}

private func generateReceiptList(list: [ShoppingItem]) -> [String] {
    var tmpList: [String] = []
    
    list.forEach { s in
        guard s.isShopped == true else {
            return
        }
        tmpList.append(s.name)
    }
    
   return tmpList
}

private func convertToShoppingItemList(list: [String]) -> [ShoppingItem] {
    let tmpList = list.map { s in
        return ShoppingItem(name: s, isShopped: false)
    }
    
    return tmpList
}

private func convertToStringList(list: [ShoppingItem]) -> [String] {
    let tmpList = list.map { s in
        return s.name
    }
    
    return tmpList
}
