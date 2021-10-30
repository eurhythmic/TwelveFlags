//
//  BorderButtonStyle.swift
//  TwelveFlags
//
//  Created by RnD on 1/17/21.
//

import SwiftUI

struct BorderButton: ButtonStyle {
    var padding: CGFloat = 7
    var fontSize: CGFloat = 17
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding(padding)
            .foregroundColor(configuration.isPressed ? Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)) : .blue)
            .cornerRadius(8)
            .font(.system(size: fontSize))
            .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(configuration.isPressed ? Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)) : .blue, lineWidth: 1))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
