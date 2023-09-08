//
//  ContentView.swift
//  ColorView
//
//  Created by Алексей Турулин on 7/21/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var red = Double.random(in: 0...255).rounded()
    @State private var green = Double.random(in: 0...255).rounded()
    @State private var blue = Double.random(in: 0...255).rounded()
    
    @FocusState private var focusedTextField: ColorTextField?
    
    var frameColorValue: Double {
        let average = (red + green + blue) / 3
        return 1 - average / 255
    }
    
    var body: some View {
        ZStack {
            Color(UIColor.systemCyan)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                ColorView(
                    red: red,
                    green: green,
                    blue: blue,
                    frameColor: Color(
                        red: frameColorValue,
                        green: frameColorValue,
                        blue: frameColorValue
                    )
                )
                SliderView(value: $red, color: .red)
                    .focused($focusedTextField, equals: .redTextField)
                SliderView(value: $green, color: .green)
                    .focused($focusedTextField, equals: .greenTextField)
                SliderView(value: $blue, color: .blue)
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

extension ContentView {
    private enum ColorTextField {
        case redTextField
        case greenTextField
        case blueTextField
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
