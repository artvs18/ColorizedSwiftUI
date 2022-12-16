//
//  TextFieldView.swift
//  ColorizedSwiftUI
//
//  Created by Artemy Volkov on 16.12.2022.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var text: String
    var action: () -> Void
    
    var body: some View {
        TextField("", text: $text) { _ in
            withAnimation {
                action()
            }
        }
        .frame(width: 45)
        .textFieldStyle(.roundedBorder)
        .keyboardType(.numberPad)
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(text: .constant("128"), action: {})
    }
}
