//
//  ContentView.swift
//  ColorView
//
//  Created by Алексей Турулин on 7/21/23.
//

import SwiftUI

struct ContentView: View {
    enum TextField {
        case redTextField
        case greenTextField
        case blueTextField
    }
    
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    
    @State private var alertPresented = false
    
    @FocusState private var focusedTextField: TextField?
    
    var body: some View {
        ZStack {
            Color(UIColor.systemCyan)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                ColorView(redValue: $redSliderValue, greenValue: $greenSliderValue, blueValue: $blueSliderValue)
                SliderView(value: $redSliderValue, tintColor: .red)
                    .focused($focusedTextField, equals: .redTextField)
                SliderView(value: $greenSliderValue, tintColor: .green)
                    .focused($focusedTextField, equals: .greenTextField)
                SliderView(value: $blueSliderValue, tintColor: .blue)
                    .focused($focusedTextField, equals: .blueTextField)
                Spacer()
            }
            .padding()
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Up") {
                    switchTextField(up: true)
                }
                Button("Down") {
                    switchTextField(up: false)
                }
                
                Spacer()
                Button("Done") {
                    focusedTextField = nil
                    checkValue()
                }
                .alert("Wrong Format", isPresented: $alertPresented, actions: {}) {
                    Text("Please enter value from 0 to 255")
                }
            }
        }
    }
    
    private func switchTextField(up: Bool) {
        if up {
            switch focusedTextField {
            case .none:
                break
            case .redTextField:
                focusedTextField = .blueTextField
            case .greenTextField:
                focusedTextField = .redTextField
            case .blueTextField:
                focusedTextField = .greenTextField
            }
        } else {
            switch focusedTextField {
            case .none:
                break
            case .redTextField:
                focusedTextField = .greenTextField
            case .greenTextField:
                focusedTextField = .blueTextField
            case .blueTextField:
                focusedTextField = .redTextField
            }
        }
    }
    
    private func checkValue() {
        var value = 0.0
        
        switch focusedTextField {
        case .none:
            break
        case .redTextField:
            value = redSliderValue
        case .greenTextField:
            value = greenSliderValue
        case .blueTextField:
            value = blueSliderValue
        }
        
        if !(0...255).contains(value) {
            alertPresented = true
        }
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
