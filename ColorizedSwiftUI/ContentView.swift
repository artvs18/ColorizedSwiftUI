//
//  ContentView.swift
//  ColorizedSwiftUI
//
//  Created by Artemy Volkov on 12.12.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var red = Double.random(in: 0...255).rounded()
    @State private var green = Double.random(in: 0...255).rounded()
    @State private var blue = Double.random(in: 0...255).rounded()
    
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        ZStack {
            Color(red: red / 255, green: green / 255, blue: blue / 255)
                .ignoresSafeArea()
                .onTapGesture {
                    isInputActive = false
                }
            
            VStack {
                Spacer()
                
                VStack {
                    ColorSliderView(value: $red, color: .red)
                        .padding([.horizontal, .top])
                    ColorSliderView(value: $green, color: .green)
                        .padding(.horizontal)
                    ColorSliderView(value: $blue, color: .blue)
                        .padding([.horizontal, .bottom])
                }
                .background(.black.opacity(0.75))
                .cornerRadius(30)
                .padding()
                .focused($isInputActive)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            isInputActive = false
                        }
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
