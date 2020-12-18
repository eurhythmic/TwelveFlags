//
//  View+Glow.swift
//  TwelveFlags
//
//  Created by RnD on 12/18/20.
//

import SwiftUI

extension View {
    func glow(color: Color = .white, radius: CGFloat = 20) -> some View {
        self
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
    }
}
