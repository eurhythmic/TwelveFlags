//
//  ScoreView.swift
//  TwelveFlags
//
//  Created by RnD on 1/14/21.
//

import SwiftUI

struct ScoreView: View {
    var scoreViewModel: ScoreViewModel
    
    var body: some View {
        HStack() {
            Text(scoreViewModel.score.name)
            
            Spacer()
            
            Text(String(scoreViewModel.score.highScore))
        }
        .font(CustomFont.PressStart2P(size: 20))
        .frame(maxWidth: .infinity, alignment: .leading)
        .lineLimit(1)
        .minimumScaleFactor(0.5)
        .padding()
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        let score = testData[Int.random(in: 1...10)]
        
        VStack {
            ScoreView(scoreViewModel: ScoreViewModel(score: score))
            
            ScoreView(scoreViewModel: ScoreViewModel(score: score))
            
            ScoreView(scoreViewModel: ScoreViewModel(score: score))
        }
    }
}
