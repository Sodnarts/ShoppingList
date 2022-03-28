//
//  Logo.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 12/01/2022.
//

import SwiftUI

struct Logo: View {
    var body: some View {
        Image("Shopping List")
            .padding(.bottom, 32)
    }
}

struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        Logo()
    }
}
