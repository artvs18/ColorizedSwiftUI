//
//  ColorSliderView.swift
//  ColorizedSwiftUI
//
//  Created by Artemy Volkov on 16.12.2022.
//

import SwiftUI

struct ColorSliderView: View {
    @Binding var value: Double
    @State var text = ""
    @State private var isPresented = false
    
    let color: Color
    
    var body: some View {
        HStack {
            Text(value.formatted())
                .frame(width: 35)
                .monospacedDigit()
            
            Slider(value: $value, in: 0...255, step: 1)
                .tint(color)
                .onChange(of: value) { text = $0.formatted() }
            
            TextFieldView(text: $text, action: validate)
                .alert("Wrong Format", isPresented: $isPresented, actions: {}) {
                    Text("Enter value between 0 and 255")
                }
        }
        .onAppear { text = value.formatted() }
    }
    
    private func validate() {
        if let value = Int(text), (0...255).contains(value) {
            self.value = Double(value)
            return
        }
        isPresented.toggle()
        text = "0"
        value = 0
    }
}


struct ColorSliderView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSliderView(value: .constant(10), color: .red)
    }
}
