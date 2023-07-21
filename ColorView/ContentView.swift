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
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ColorView: View {
    @Binding var redValue: Double
    @Binding var greenValue: Double
    @Binding var blueValue: Double
    
    var body: some View {
        Color(UIColor(
            red: redValue / 255,
            green: greenValue / 255,
            blue: blueValue / 255,
            alpha: 1)
        )
        .rounded()
    }
}

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
            TextField("", value: $value, format: .number.rounded(increment: 1))
                .multilineTextAlignment(.trailing)
                .padding(.trailing, 5)
                .frame(width: 50, height: 30)
                .background(.white)
                .cornerRadius(4)
        }
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
