//
//  SliderView.swift
//  ColorView
//
//  Created by Алексей Турулин on 7/23/23.
//

import SwiftUI

struct SliderView: View {
    @Binding var value: Double
    
    let tintColor: Color
    
    @State private var text = ""
    @State private var alertPresented = false
    
    var body: some View {
        HStack {
            Text("\(lround(value))")
                .foregroundColor(.white)
                .frame(width: 35, alignment: .leading)
            Slider(value: $value, in: 0...255, step: 1)
                .tint(tintColor)
                .animation(.default, value: value)
                .onChange(of: value) { newValue in
                    text = newValue.formatted()
                }
            TextField("", text: $text) { _ in
                checkValue()
            }
                .multilineTextAlignment(.trailing)
                .padding(.trailing, 5)
                .frame(width: 50, height: 30)
                .background(.white)
                .cornerRadius(4)
                .keyboardType(.numberPad)
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
        } else {
            alertPresented.toggle()
            value = 0
            text = "0"
        }
        
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.systemCyan)
                .ignoresSafeArea()
            SliderView(value: .constant(150), tintColor: .red)
        }
    }
}
