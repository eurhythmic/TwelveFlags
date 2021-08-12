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
            
            TextField("Enter 1Up Initials!", text: $content.playerName)
                .textCase(.uppercase)
                .multilineTextAlignment(.center)
                .font(CustomFont.PressStart2P(size: 15))
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onReceive(Just(content.playerName), perform: { _ in
                    limitTextFieldCharacters(with: submitScore.characterLimit)
                })
                .disabled(submitScore.buttonTapped == true)
            
            Button(action: {
                submitScore.buttonTapped = true
                addScore()
            }) {
                Text("Add New Score")
                    .textCase(.uppercase)
                    .font(CustomFont.PressStart2P(size: 15))
                    .shadow(color: .primary, radius: content.playerName.isEmpty ? 0 : 1)
                    .shadow(color: .primary, radius: content.playerName.isEmpty ? 0 : 1)
                    .shadow(color: .primary, radius: content.playerName.isEmpty ? 0 : 1)
            }
            .disabled(content.playerName.isEmpty || submitScore.buttonTapped == true)
            
            Divider()
                .frame(height: 1)
                .background(Color.primary)
                .padding()
            
            ScoreListView()
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
    
    private func limitTextFieldCharacters(with upperLimit: Int) {
        if content.playerName.count > upperLimit {
            content.playerName = String(content.playerName.prefix(upperLimit))
        }
    }
    
    private func addScore() {
        let score = Score(highScore: content.playerScore, name: content.playerName)
        
        scoreList.add(score)
        
        content.playerName.removeAll()
    }
}

struct SubmitScoreView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitScoreView(content: ContentViewModel(generator: FlagGenerator()), scoreList: ScoreListViewModel())
            .preferredColorScheme(.dark)
    }
}
