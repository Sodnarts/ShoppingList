//
//  Receipt.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 16/01/2022.
//

import Foundation
import Firebase
struct Receipt: Equatable, Identifiable {
    var id: String
    var price: String
    var shopper: String
    var shoppingList: [String]
    var date: Timestamp
    var duration: Int
}
