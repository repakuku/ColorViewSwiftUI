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
    
    var body: some View {
        HStack {
            Text("\(lround(value))")
                .foregroundColor(.white)
                .frame(width: 35, alignment: .leading)
            Slider(value: $value, in: 0...255, step: 1)
                .tint(tintColor)
                .animation(.default, value: value)
            TextField("", value: $value, formatter: NumberFormatter())
                .multilineTextAlignment(.trailing)
                .padding(.trailing, 5)
                .frame(width: 50, height: 30)
                .background(.white)
                .cornerRadius(4)
                .keyboardType(.numberPad)
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
