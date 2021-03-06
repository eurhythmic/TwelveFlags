//
//  SubmitScoreView.swift
//  TwelveFlags
//
//  Created by RnD on 12/28/20.
//

import SwiftUI
import Combine

struct SubmitScoreView: View {
    @ObservedObject var content: ContentViewModel
    @ObservedObject var scoreList: ScoreListViewModel
    @ObservedObject var submitScore = SubmitScoreViewModel()
    let characterLimit = 25
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                Text("High Score")
                    .textCase(.uppercase)
                    .font(CustomFont.PressStart2P(size: 20))
                    .padding(.top)
                
                Text("\(content.playerScore)")
                    .font(CustomFont.PressStart2P(size: 25))
            }
            
            TextField("Enter 1Up Initials!", text: $content.name)
                .textCase(.uppercase)
                .multilineTextAlignment(.center)
                .font(CustomFont.PressStart2P(size: 15))
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onReceive(Just(content.name), perform: { _ in
                    limitTextFieldCharacters(with: characterLimit)
                })
                .disabled(submitScore.buttonTapped == true)
            
            Button(action: {
                submitScore.buttonTapped = true
                addScore()
            }) {
                Text("Add New Score")
                    .textCase(.uppercase)
                    .font(CustomFont.PressStart2P(size: 15))
                    .shadow(color: .primary, radius: content.name.isEmpty ? 0 : 1)
                    .shadow(color: .primary, radius: content.name.isEmpty ? 0 : 1)
                    .shadow(color: .primary, radius: content.name.isEmpty ? 0 : 1)
            }
            .disabled(content.name.isEmpty || submitScore.buttonTapped == true)
            
            Divider()
                .frame(height: 1)
                .background(Color.primary)
                .padding()
            
            ScoreListView()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
    
    private func limitTextFieldCharacters(with upperLimit: Int) {
        if content.name.count > upperLimit {
            content.name = String(content.name.prefix(upperLimit))
        }
    }
    
    private func addScore() {
        let score = Score(highScore: content.playerScore, name: content.name)
        
        scoreList.add(score)
        
        content.name.removeAll()
    }
}

struct SubmitScoreView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitScoreView(content: ContentViewModel(), scoreList: ScoreListViewModel())
            .preferredColorScheme(.dark)
    }
}
