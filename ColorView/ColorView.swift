//
//  ColorView.swift
//  ColorView
//
//  Created by Алексей Турулин on 7/23/23.
//

import SwiftUI

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

struct ColorView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
