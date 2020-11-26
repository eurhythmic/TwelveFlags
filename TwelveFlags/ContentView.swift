//
//  ContentView.swift
//  TwelveFlags
//
//  Created by RnD on 10/3/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(viewModel.countries[viewModel.correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
            
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(viewModel.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                
                VStack {
                    Text("\(viewModel.playerScore)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("High Score")
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                }
            }
            
        }
        .alert(isPresented: $viewModel.showingScore, content: {
            Alert(title: Text(viewModel.scoreTitle), message: Text("Your score is \(viewModel.playerScore)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        })
    }
    
    func flagTapped(_ number: Int) {
        if number == viewModel.correctAnswer {
            viewModel.scoreTitle = "Correct"
            viewModel.playerScore += 1
        } else {
            viewModel.scoreTitle = "Wrong"
            if viewModel.playerScore > 0 {
                viewModel.playerScore -= 1
            }
        }
        
        viewModel.showingScore = true
    }
    
    func askQuestion() {
        viewModel.countries.shuffle()
        viewModel.correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
