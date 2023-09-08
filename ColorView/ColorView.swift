//
//  ColorView.swift
//  ColorView
//
//  Created by Алексей Турулин on 7/23/23.
//

import SwiftUI

struct ColorView: View {
    let red: Double
    let green: Double
    let blue: Double
    let frameColor: Color
    
    var body: some View {
        Color(red: red / 255, green: green / 255, blue: blue / 255)
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
            ColorView(red: 150, green: 10, blue: 10, frameColor: .white)
        }
    }
}
