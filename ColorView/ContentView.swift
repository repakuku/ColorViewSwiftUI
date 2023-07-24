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
    
    @State private var redValue = Double.random(in: 0...255)
    @State private var greenValue = Double.random(in: 0...255)
    @State private var blueValue = Double.random(in: 0...255)
    
    @State private var alertPresented = false
    
    @FocusState private var focusedTextField: ColorTextField?
    
    var frameColorValue: Double {
        let average = (redValue + greenValue + blueValue) / 3
        return average / 255
    }
    
    var body: some View {
        ZStack {
            Color(UIColor.systemCyan)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                ColorView(redValue: redValue, greenValue: greenValue, blueValue: blueValue, frameColor: Color(red: frameColorValue, green: frameColorValue, blue: frameColorValue))
                SliderView(value: $redValue, tintColor: .red)
                    .focused($focusedTextField, equals: .redTextField)
                SliderView(value: $greenValue, tintColor: .green)
                    .focused($focusedTextField, equals: .greenTextField)
                SliderView(value: $blueValue, tintColor: .blue)
                    .focused($focusedTextField, equals: .blueTextField)
                Spacer()
            }
            .padding()
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button {
                    switchTextField(up: true)
                } label: {
                    Image(systemName: "chevron.up")
                }
                Button {
                    switchTextField(up: false)
                } label: {
                    Image(systemName: "chevron.down")
                }
                
                Spacer()
                Button("Done") {
                    focusedTextField = nil
                }
            }
        }
        .onTapGesture {
            focusedTextField = nil
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
    }
}

extension View {
    func rounded() -> some View {
        modifier(RoundedViewModifier())
    }
}
