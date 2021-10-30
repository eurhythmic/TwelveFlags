//
//  ContentView.swift
//  TwelveFlags
//
//  Created by RnD on 10/3/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var content: ContentViewModel
    @StateObject var floating = FloatingNoticeViewModel()
    let start: StartViewModel
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    VStack {
                        Spacer()
                        
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                        
                        Text(content.allFlags()[content.correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    
                    ForEach(0 ..< 3) { number in
                            Button(action: {
                                flagTapped(number)
                            }) {
                                Image(content.allFlags()[number])
                                    .renderingMode(.original)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                    .shadow(color: .black, radius: 2)
                            }.disabled(content.isAnswerSelected)
                    }
                    
                    VStack {
                        if !start.isRankedMode {
                            Text("\(settingsViewModel.settings.playerScore)")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .transition(AnyTransition.scale.animation(.easeInOut(duration: 0.25)))
                                .id("playerScore \(settingsViewModel.settings.playerScore)")
                        } else {
                            Text("\(settingsViewModel.settings.rankedPlayerScore)")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .transition(AnyTransition.scale.animation(.easeInOut(duration: 0.25)))
                                .id("rankedPlayerScore \(settingsViewModel.settings.rankedPlayerScore)")
                                .glow(color: .blue, radius: content.animateShadow ? 7 : 0)
                                .onAppear {
                                    // Set initial state of shadow animation
                                    content.animateShadow = false
                                }
                                .animation(.easeInOut(duration: 1).delay(1).repeatForever(autoreverses: true))
                                .onReceive(settingsViewModel.settings.$rankedPlayerScore.dropFirst()) { _ in
                                    // Reset state of shadow animation
                                    content.animateShadow = false
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        // Begin shadow animation
                                        content.animateShadow = true
                                    }
                                }
                        }
                        
                        if !start.isRankedMode {
                            Text("High Score")
                                .foregroundColor(.white)
                                .padding(.bottom, 20)
                        } else {
                            Button("Submit Ranked Score", action: {
                                content.showSubmitScoreView.toggle()
                            })
                            .buttonStyle(FilledButton())
                            .sheet(isPresented: $content.showSubmitScoreView, content: {
                                SubmitScoreView(scoreList: ScoreListViewModel()).environmentObject(settingsViewModel)
                                })
                        }
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            Button("Settings") {
                                content.showSettingsView.toggle()
                            }
                            .buttonStyle(BorderButton())
                            .sheet(isPresented: $content.showSettingsView, content: {
                                SettingsView().environmentObject(settingsViewModel)
                            })
                            
                            Spacer()
                            
                            Button("Quit to Main Menu") {
                                self.presentation.wrappedValue.dismiss()
                            }
                            .buttonStyle(BorderButton())
                            
                            Spacer()
                        }
                        .padding(.bottom)
                    }

                }
                
                if content.showingNotice {
                    FloatingNoticeView(floating: floating)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    content.showingNotice.toggle()
                                    askQuestion()
                                }
                            }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .onAppear {
                settingsViewModel.settings.returningPlayer = true
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        content.isAnswerSelected.toggle()
        
        if number == content.correctAnswer {
            floating.symbol = "checkmark.seal"
            if !start.isRankedMode {
                settingsViewModel.settings.playerScore += 1
            } else {
                settingsViewModel.settings.rankedPlayerScore += 1
            }
            
        } else {
            floating.symbol = "xmark.seal"
            if !start.isRankedMode && settingsViewModel.settings.playerScore > 0 {
                settingsViewModel.settings.playerScore -= 1
            } else if settingsViewModel.settings.rankedPlayerScore > 0 {
                settingsViewModel.settings.rankedPlayerScore -= 1
            }
        }
        
        content.showingNotice = true
    }
    
    func askQuestion() {
        content.randomizeFlags()
        content.correctAnswer = Int.random(in: 0...2)
        content.isAnswerSelected.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(content: ContentViewModel(generator: FlagGenerator()), start: StartViewModel())
    }
}
