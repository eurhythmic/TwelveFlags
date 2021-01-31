//
//  FloatingNoticeView.swift
//  TwelveFlags
//
//  Created by RnD on 12/1/20.
//

import SwiftUI

struct FloatingNoticeView: View {
    @EnvironmentObject var floating: FloatingNoticeViewModel
    
     var body: some View {
         VStack {
            Image(systemName: floating.symbol ?? "lightbulb")
                .foregroundColor(.white)
                .font(.system(size: 48, weight: .regular))
                .padding()
                .background(Color.blue.opacity(0.8))
                .overlay(RoundedRectangle(cornerRadius: 15.0).stroke(Color.blue, lineWidth: 6))
                .cornerRadius(15)
                .glow(color: .white, radius: 90)
                .transition(.scale)
         }
     }
}

struct FloatingNoticeView_Previews: PreviewProvider {
    static var previews: some View {
        FloatingNoticeView().environmentObject(FloatingNoticeViewModel())
    }
}
