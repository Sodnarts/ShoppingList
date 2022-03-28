//
//  Alert.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 18/01/2022.
//

import SwiftUI


extension View {
  public func alert(isPresented: Binding<Bool>, _ alert: InputDialog) -> some View {
    AlertWrapper(isPresented: isPresented, alert: alert, content: self)
  }
}

extension UIAlertController {
  convenience init(alert: InputDialog) {
      self.init(title: alert.title, message: alert.message, preferredStyle: .alert)
    addTextField {
       $0.placeholder = alert.placeholder
       $0.keyboardType = alert.keyboardType
    }
      if let cancel = alert.cancel {
      addAction(UIAlertAction(title: cancel, style: .cancel) { _ in
        alert.action(nil)
      })
    }
    if let secondaryActionTitle = alert.secondaryActionTitle {
       addAction(UIAlertAction(title: secondaryActionTitle, style: .default, handler: { _ in
         alert.secondaryAction?()
       }))
    }
    let textField = self.textFields?.first
      addAction(UIAlertAction(title: alert.accept, style: .default) { _ in
      alert.action(textField?.text)
    })
      UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColorFromHex(rgbValue: 0x55C57A, alpha: 1)
  }
}
