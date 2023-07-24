//
//  TextFieldView.swift
//  ColorView
//
//  Created by Алексей Турулин on 7/24/23.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var text: String
    
    let action: () -> Void
    
    var body: some View {
        TextField("", text: $text) { _ in
            withAnimation {
                action()
            }
        }
        .multilineTextAlignment(.trailing)
        .frame(width: 50, alignment: .trailing)
        .textFieldStyle(.roundedBorder)
        .keyboardType(.numberPad)
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.systemCyan)
                .ignoresSafeArea()
            TextFieldView(text: .constant("100"), action: {} )
        }
       
    }
}
