//
//  LabeledInputField.swift
//  ShoppingLIst
//
//  Created by Glenn Robert Strandos on 14/01/2022.
//

import SwiftUI

struct LabeledInputField: View {
    @Binding var input: String
    var placeholder: LocalizedStringKey
    var type: InputType
    var sfSymbol: String
    
    var body: some View {
        VStack {
            HStack {
                Text(placeholder).foregroundColor(.themePrimary).font(.system(size: 12, weight: .light, design: .default))
                    .padding(.bottom, -4).padding(.top, 16).padding(.leading, 8)
                Spacer()
            }
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                    .strokeBorder(Color.themePrimary, lineWidth: 3)
                    .foregroundColor(.themePrimary)
                    .frame(height: 48)
                HStack {
                    Image(systemName: sfSymbol).padding(.leading, 16).foregroundColor(.themePrimary)
                    if type == InputType.Password {
                        AnyView(SecureInputField(input: $input, placeholder: placeholder))
                    } else if type == InputType.Email {
                        AnyView(EmailInputField(input: $input, placeholder: placeholder))
                    } else {
                        AnyView(PlainInputField(input: $input, placeholder: placeholder))
                    }
                }
            }
        }.padding(.horizontal, 16)
    }
}

struct PlainInputField: View {
    @Binding var input: String
    var placeholder: LocalizedStringKey
    
    var body: some View {
        TextField(placeholder, text: $input)
            .disableAutocorrection(true)
            .padding(.leading, 8).padding(.trailing, 24)
            .foregroundColor(.white)
            .placeholder(when: input.isEmpty) {
                Text(placeholder).foregroundColor(.white).padding(.leading, 8)
            }
    }
}

struct EmailInputField: View {
    @Binding var input: String
    var placeholder: LocalizedStringKey
    
    var body: some View {
        TextField(placeholder, text: $input)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding(.leading, 8).padding(.trailing, 24)
            .foregroundColor(.white)
            .placeholder(when: input.isEmpty) {
                Text(placeholder).foregroundColor(.white).padding(.leading, 8)
            }
//        FirstResponderTextField(text: $input, placerholder: placeholder)
//            .disableAutocorrection(true)
//            .autocapitalization(.none)
//            .padding(.leading, 8).padding(.trailing, 24)
//            .foregroundColor(.white)
//            .placeholder(when: input.isEmpty) {
//                Text(placeholder).foregroundColor(.white).padding(.leading, 8)
//            }
    }
}

struct SecureInputField: View {
    @Binding var input: String
    var placeholder: LocalizedStringKey
    
    var body: some View {
        SecureField(placeholder, text: $input)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding(.leading, 8).padding(.trailing, 24)
            .foregroundColor(.white)
            .placeholder(when: input.isEmpty) {
                Text(placeholder).foregroundColor(.white).padding(.leading, 8)
            }
    }
}

enum InputType: String {
    case Plaintext
    case Email
    case Password
}

struct FirstResponderTextField: UIViewRepresentable {
    
    @Binding var text: String
    let placerholder: String
    
    class Coordinator: NSObject, UITextFieldDelegate {
        
        @Binding var text: String
        var becameFirstResponder = false
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.placeholder = placerholder
        textField.textColor = .white
        return textField
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if !context.coordinator.becameFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.becameFirstResponder = true
        }
    }
}
