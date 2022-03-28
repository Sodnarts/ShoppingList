//
//  RandomString.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 15/01/2022.
//

import Foundation

func randomString(length: Int) -> String {
    //let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
}
