//
//  SliderView.swift
//  ColorView
//
//  Created by Алексей Турулин on 7/23/23.
//

import SwiftUI

struct SliderView: View {
    @Binding var sliderValue: Double
    @Binding var textFieldValue: Double
    
    let tintColor: Color
    
    var body: some View {
        HStack {
            Text("\(lround(sliderValue))")
                .foregroundColor(.white)
                .frame(width: 35, alignment: .leading)
            Slider(value: $sliderValue, in: 0...255, step: 1)
                .tint(tintColor)
                .animation(.default, value: sliderValue)
            TextField("", value: $textFieldValue, formatter: NumberFormatter())
                .multilineTextAlignment(.trailing)
                .padding(.trailing, 5)
                .frame(width: 50, height: 30)
                .background(.white)
                .cornerRadius(4)
                .keyboardType(.numberPad)
                .onChange(of: sliderValue) { newValue in
                    textFieldValue = sliderValue
                }
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
