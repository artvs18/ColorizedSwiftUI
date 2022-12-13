//
//  ContentView.swift
//  ColorizedSwiftUI
//
//  Created by Artemy Volkov on 12.12.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    var body: some View {
        ZStack {
            Color(
                red: redSliderValue / 255,
                green: greenSliderValue / 255,
                blue: blueSliderValue / 255
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .frame(height: 175)
                    .foregroundColor(.black.opacity(0.75))
                    .overlay(settingsView)
                    .padding()
            }
        }
        .preferredColorScheme(.dark)
    }
    
    var settingsView: some View {
        VStack {
            SettingsRowView(value: $redSliderValue, accentColor: .red)
            SettingsRowView(value: $greenSliderValue, accentColor: .green)
            SettingsRowView(value: $blueSliderValue, accentColor: .blue)
        }
        .padding()
    }
}

struct SettingsRowView: View {
    @Binding var value: Double
    let accentColor: Color
    @State var text: String = ""
    @State private var alertPresented = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Text(lround(value).formatted())
                .frame(width: 35)
                .monospacedDigit()
            
            Slider(value: $value, in: 0...255, step: 1)
                .accentColor(accentColor)
            
            TextField("", text: $text)
                .textFieldStyle(.roundedBorder)
                .frame(width: 45)
                .keyboardType(.numberPad)
                .onAppear { text = lround(value).formatted() }
                .onChange(of: value) { text = lround($0).formatted() }
                .focused($isFocused)
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        Button("Done") {
                            validate(text)
                            isFocused.toggle()
                        }
                            .alert(
                                "Wrong Format",
                                isPresented: $alertPresented,
                                actions: {}) {
                                    Text("Enter value between 0 and 255")
                                }
                    }
                }
        }
    }
    
    private func validate(_ text: String) {
        if let value = Double(text), value >= 0 && value <= 255 {
            withAnimation {
                self.value = value
            }
        } else {
            self.text = lround(self.value).formatted()
            alertPresented.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
