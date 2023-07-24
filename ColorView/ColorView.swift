//
//  ColorView.swift
//  ColorView
//
//  Created by Алексей Турулин on 7/23/23.
//

import SwiftUI

struct ColorView: View {
    let redValue: Double
    let greenValue: Double
    let blueValue: Double
    let frameColor: Color
    
    var body: some View {
        Color(red: redValue / 255, green: greenValue / 255, blue: blueValue / 255)
            .rounded()
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(frameColor, lineWidth: 4)
            )
    }
}

struct ColorView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.systemCyan)
                .ignoresSafeArea()
            ColorView(redValue: 150, greenValue: 10, blueValue: 10, frameColor: .white)
        }
    }
}
