//
//  FilledButtonStyle.swift
//  TwelveFlags
//
//  Created by RnD on 1/8/21.
//

import SwiftUI

struct FilledButton: ButtonStyle {
    var padding: CGFloat = 7
    var fontSize: CGFloat = 17
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding(padding)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 8, style: .continuous).fill(Color.blue).opacity(0.2)
                    
                    RoundedRectangle(cornerRadius: 8, style: .continuous).stroke((Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))), lineWidth: configuration.isPressed ? 3 : 0)
                })
            .foregroundColor(configuration.isPressed ? Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)) : .blue)
            .cornerRadius(8)
            .font(.system(size: fontSize))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
