//
//  Receipts.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 16/01/2022.
//

import SwiftUI

struct Receipts: View {
    @EnvironmentObject var viewModel: ShoppingListViewModel
    
    @State var receiptItems: [Receipt] = []
    
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            Color.themeBackground.ignoresSafeArea()
            
            VStack {
                ScrollView {
                    ForEach(0..<receiptItems.count, id: \.self) { index in
                        ReceiptElement(receipt: $receiptItems[index])
                    }
                }
                Spacer()
            }
        }
            .onAppear {
            receiptItems = viewModel.receiptList
            viewModel.getReceipts(id: viewModel.householdId)
        }.onChange(of: viewModel.receiptList) { newState in
            receiptItems = newState
        }
    }
}

struct Receipts_Previews: PreviewProvider {
    static var previews: some View {
        Receipts()
    }
}

private struct ReceiptElement: View {
    @Binding var receipt: Receipt
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack {
                        Spacer()
                        HStack {
                            Text(String(format: NSLocalizedString("Shopped by %@", comment: "Shopped by %@"), receipt.shopper)).foregroundColor(.white).font(.system(size: 14, weight: .light, design: .default)).padding(0)
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            Text(String(format: NSLocalizedString("Duration: %d", comment: "Duration: %d"), receipt.duration)).foregroundColor(.white).font(.system(size: 14, weight: .light, design: .default)).padding(0)
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            Text(String(format: NSLocalizedString("Items: %d", comment: "Items: %d"), receipt.shoppingList.count)).foregroundColor(.white).font(.system(size: 14, weight: .light, design: .default)).padding(0)
                            Spacer()
                        }
                        Spacer()
                    }.padding(.leading, 12)
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            Spacer()
                            Text(receipt.date.dateValue(), style: .date).foregroundColor(.white).font(.system(size: 12, weight: .light, design: .default))
                            Image(systemName: "chevron.right").foregroundColor(.themePrimary).font(.system(size: 16, weight: .heavy, design: .default))
                        }
                        Spacer()
                        HStack {
                            Spacer()
                            Text(String(format: "%@,-", receipt.price)).foregroundColor(.white).font(.system(size: 22, weight: .regular, design: .default))
                        }
                    }.padding(.trailing, 12).padding(.top, 12).padding(.bottom, 8)
                }
            }.frame(height: 96, alignment: .leading)
            RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                .strokeBorder(Color.themePrimary, lineWidth: 2)
                .foregroundColor(.themePrimary)
                .frame(height: 96)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 32)
    }
}
