//
//  ContentView.swift
//  ColorView
//
//  Created by Алексей Турулин on 7/21/23.
//

import SwiftUI

struct ContentView: View {
    private enum ColorTextField {
        case redTextField
        case greenTextField
        case blueTextField
    }
    
    @State private var redSliderValue = 100.0
    @State private var greenSliderValue = 100.0
    @State private var blueSliderValue = 100.0
    
    @State private var redTextFieldValue = 100.0
    @State private var greenTextFieldValue = 100.0
    @State private var blueTextFieldValue = 100.0
    
    @State private var alertPresented = false
    
    @FocusState private var focusedTextField: ColorTextField?
    
    var body: some View {
        ZStack {
            Color(UIColor.systemCyan)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                ColorView(redValue: $redSliderValue, greenValue: $greenSliderValue, blueValue: $blueSliderValue)
                SliderView(sliderValue: $redSliderValue, textFieldValue: $redTextFieldValue, tintColor: .red)
                    .focused($focusedTextField, equals: .redTextField)
                SliderView(sliderValue: $greenSliderValue, textFieldValue: $greenTextFieldValue, tintColor: .green)
                    .focused($focusedTextField, equals: .greenTextField)
                SliderView(sliderValue: $blueSliderValue, textFieldValue: $blueTextFieldValue, tintColor: .blue)
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
        switch focusedTextField {
        case .none:
            break
        case .redTextField:
            focusedTextField = up ? .blueTextField : .greenTextField
        case .greenTextField:
            focusedTextField = up ? .redTextField : .blueTextField
        case .blueTextField:
            focusedTextField = up ? .greenTextField : .redTextField
        }
    }
    
    private func checkValue() {
        switch focusedTextField {
        case .none:
            break
        case .redTextField:
            if redTextFieldValue > 255 {
                alertPresented = true
                redTextFieldValue = 255
            }
            redSliderValue = redTextFieldValue
        case .greenTextField:
            if greenTextFieldValue > 255 {
                alertPresented = true
                greenTextFieldValue = 255
            }
            greenSliderValue = greenTextFieldValue
        case .blueTextField:
            if blueTextFieldValue > 255 {
                alertPresented = true
                blueTextFieldValue = 255
            }
            blueSliderValue = blueTextFieldValue
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
