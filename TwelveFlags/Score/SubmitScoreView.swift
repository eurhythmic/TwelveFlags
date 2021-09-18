//
//  SubmitScoreView.swift
//  TwelveFlags
//
//  Created by RnD on 12/28/20.
//

import SwiftUI
import Combine

struct SubmitScoreView: View {
    @StateObject var scoreList = ScoreListViewModel()
    @StateObject var submitScore = SubmitScoreViewModel()
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                Text("High Score")
                    .textCase(.uppercase)
                    .font(CustomFont.PressStart2P(size: 20))
                    .padding(.top)
                
                Text("\(settingsViewModel.settings.rankedPlayerScore)")
                    .font(CustomFont.PressStart2P(size: 25))
            }
            
            TextField("Enter 1Up Initials!", text: $submitScore.playerName)
                .textCase(.uppercase)
                .multilineTextAlignment(.center)
                .font(CustomFont.PressStart2P(size: 15))
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onReceive(Just(submitScore.playerName), perform: { _ in
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
                    .shadow(color: .primary, radius: submitScore.playerName.isEmpty ? 0 : 1)
                    .shadow(color: .primary, radius: submitScore.playerName.isEmpty ? 0 : 1)
                    .shadow(color: .primary, radius: submitScore.playerName.isEmpty ? 0 : 1)
            }
            .disabled(submitScore.playerName.isEmpty || submitScore.buttonTapped == true)
            
            Divider()
                .frame(height: 1)
                .background(Color.primary)
                .padding()
            
            ScoreListView(scoreList: scoreList)
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea())
    }
    
    private func limitTextFieldCharacters(with upperLimit: Int) {
        if submitScore.playerName.count > upperLimit {
            submitScore.playerName = String(submitScore.playerName.prefix(upperLimit))
        }
    }
    
    private func addScore() {
        let score = Score(highScore: settingsViewModel.settings.rankedPlayerScore, name: submitScore.playerName)
        
        // Submit score
        scoreList.add(score)
        
        // Assign text field value to `playerName` setting
        settingsViewModel.settings.playerName = submitScore.playerName
        
        // Clear text field
        submitScore.playerName.removeAll()
    }
}

struct SubmitScoreView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitScoreView(scoreList: ScoreListViewModel())
            .preferredColorScheme(.dark)
    }
}
