//
//  SliderView.swift
//  ColorView
//
//  Created by Алексей Турулин on 7/23/23.
//

import SwiftUI

struct SliderView: View {
    
    @Binding var value: Double
    @State private var text = ""
    @State private var alertPresented = false
    
    let color: Color
    
    var body: some View {
        HStack {
            Text("\(lround(value))")
                .foregroundColor(.white)
                .frame(width: 35, alignment: .leading)
            
            Slider(value: $value, in: 0...255, step: 1)
                .tint(color)
                .onChange(of: value) { newValue in
                    text = newValue.formatted()
                }
            
            TextFieldView(text: $text, action: checkValue)
                .onAppear {
                    text = value.formatted()
                }
                .alert("Wrong Format", isPresented: $alertPresented, actions: {}) {
                    Text("Please enter value from 0 to 255")
                }
        }
    }
    
    private func checkValue() {
        if let value = Double(text), (0...255).contains(value) {
            self.value = value
            if text.first == "0" && text.count > 1 {
                text.removeFirst()
                checkValue()
            }
        } else {
            alertPresented.toggle()
            value = 0
            text = value.formatted()
        }
        
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.systemCyan)
                .ignoresSafeArea()
            SliderView(value: .constant(150), color: .red)
        }
    }
}
