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
                        
                        Text(content.countries[content.correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    
                    ForEach(0 ..< 3) { number in
                            Button(action: {
                                flagTapped(number)
                            }) {
                                Image(content.countries[number])
                                    .renderingMode(.original)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                    .shadow(color: .black, radius: 2)
                            }.disabled(content.isAnswerSelected)
                    }
                    
                    VStack {
                        if !start.isRankedMode {
                            Text("\(content.playerScore)")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .transition(AnyTransition.scale.animation(.easeInOut(duration: 0.25)))
                                .id("playerScore \(content.playerScore)")
                        } else {
                            Text("\(content.rankedPlayerScore)")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .transition(AnyTransition.scale.animation(.easeInOut(duration: 0.25)))
                                .id("playerScore \(content.rankedPlayerScore)")
                                .glow(color: .blue, radius: content.animateShadow ? 7 : 0)
                                .onAppear {
                                    // Set initial state of shadow animation
                                    content.animateShadow = false
                                }
                                .animation(.easeInOut(duration: 1).delay(1).repeatForever(autoreverses: true))
                                .onReceive(content.$rankedPlayerScore.dropFirst()) { _ in
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
                            }).sheet(isPresented: $content.showSubmitScoreView, content: {
                                SubmitScoreView(content: content, scoreList: ScoreListViewModel())
                                })
                        }
                        
                        Spacer()
                        
                        Button("Quit to Main Menu", action: {
                            self.presentation.wrappedValue.dismiss()
                        })
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
        }
    }
    
    func flagTapped(_ number: Int) {
        content.isAnswerSelected.toggle()
        
        if number == content.correctAnswer {
            floating.symbol = "checkmark.seal"
            if !start.isRankedMode {
                content.playerScore += 1
            } else {
                content.rankedPlayerScore += 1
            }
            
        } else {
            floating.symbol = "xmark.seal"
            if !start.isRankedMode && content.playerScore > 0 {
                content.playerScore -= 1
            } else if content.rankedPlayerScore > 0 {
                content.rankedPlayerScore -= 1
            }
        }
        
        content.showingNotice = true
    }
    
    func askQuestion() {
        content.countries.shuffle()
        content.correctAnswer = Int.random(in: 0...2)
        content.isAnswerSelected.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(content: ContentViewModel(generator: FlagGenerator()), start: StartViewModel())
    }
}
