//
//  ContentView.swift
//  ColorView
//
//  Created by Алексей Турулин on 7/21/23.
//

import SwiftUI

struct ContentView: View {
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    @FocusState private var keyboardPresented: Bool
    
    var body: some View {
        ZStack {
            Color(UIColor.systemCyan)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                ColorView(redValue: $redSliderValue, greenValue: $greenSliderValue, blueValue: $blueSliderValue)
                SliderView(value: $redSliderValue, tintColor: .red)
                SliderView(value: $greenSliderValue, tintColor: .green)
                SliderView(value: $blueSliderValue, tintColor: .blue)
                Spacer()
            }
            .focused($keyboardPresented)
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Done") {
                    keyboardPresented.toggle()
                    checkValue()
                }
            }
        }
    }
    
    private func checkValue() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct RoundedViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(height: 150)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white, lineWidth: 4)
            )
    }
}

extension View {
    func rounded() -> some View {
        modifier(RoundedViewModifier())
    }
}
