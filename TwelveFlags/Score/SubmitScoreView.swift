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
            
            TextField(submitScore.textFieldLabel, text: $submitScore.playerName, onCommit: {
                submitAction()
            })
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .multilineTextAlignment(.center)
                .font(CustomFont.PressStart2P(size: 15))
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: submitScore.playerName, perform: { name in
                    submitScore.playerName = submitScore.limitTextFieldCharacters(for: name, with: submitScore.characterLimit)
                })
                .disabled(submitScore.scoreSent == true)
            
            Button(action: {
                submitAction()
            }) {
                Text("Add New Score")
                    .textCase(.uppercase)
                    .font(CustomFont.PressStart2P(size: 15))
                    .shadow(color: .primary, radius: submitScore.playerName.isEmpty ? 0 : 1)
                    .shadow(color: .primary, radius: submitScore.playerName.isEmpty ? 0 : 1)
                    .shadow(color: .primary, radius: submitScore.playerName.isEmpty ? 0 : 1)
            }
            .disabled(submitScore.playerName.isEmpty || submitScore.scoreSent == true)
            
            Divider()
                .frame(height: 1)
                .background(Color.primary)
                .padding()
            
            ScoreListView(scoreList: scoreList)
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea())
    }
    
    private func submitAction() {
        submitScore.scoreSent = true
        submitScore.playerName = submitScore.playerName.trimmingCharacters(in: .whitespaces)
        addScore()
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
