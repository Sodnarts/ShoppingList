//
//  ShoppingItem.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 13/01/2022.
//

import Foundation

struct ShoppingItem: Equatable, Codable {
    var name: String
    var isShopped: Bool
}

struct ShoppingItems: Equatable, Codable {
    var results: [ShoppingItem]
}
