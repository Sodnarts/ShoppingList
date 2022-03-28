//
//  Fetch.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 13/01/2022.
//

import Foundation

func Fetch(url: String, callback: @escaping (String) -> Void) {
    if let url = URL(string: url) {
       URLSession.shared.dataTask(with: url) { data, response, error in
          if let data = data {
             if let jsonString = String(data: data, encoding: .utf8) {
                callback(jsonString)
             }
           }
       }.resume()
    }
}


func Fetch2(url: String, callback: @escaping (Data) -> Void) {
    if let url = URL(string: url) {
       URLSession.shared.dataTask(with: url) { data, response, error in
          if let data = data {
                callback(data)
           }
       }.resume()
    }
}

func Fetch3(url: String, callback: @escaping (Data) -> Void) {
    if let url = URL(string: url) {
        if let data = try? Data(contentsOf: url) {
            callback(data)
        }
    }
}
