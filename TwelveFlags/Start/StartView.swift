//
//  StartView.swift
//  TwelveFlags
//
//  Created by RnD on 12/29/20.
//

import SwiftUI

struct StartView: View {
    @State private var start = StartViewModel()
    @State private var singleContent = ContentViewModel()
    @State private var rankedContent = ContentViewModel()
    @Environment(SettingsViewModel.self) private var settingsViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    Text("TwelveFlags")
                        .fontWeight(.heavy)
                        .font(.title)
                        .padding(.bottom)
                    
                    Image(systemName: "flag.circle.fill")
                        .font(.title)
                }
                
                if settingsViewModel.settings.returningPlayer {
                        Text("Welcome back, \(settingsViewModel.settings.playerName)")
                            .textCase(.uppercase)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .minimumScaleFactor(0.5)
                        Text("✨")
                            .rotation3DEffect(.degrees(start.animateText ? 45 : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
                            .onAppear {
                                DispatchQueue.main.async {
                                    withAnimation(.easeInOut(duration: 2).repeatForever()) {
                                        start.animateText = true
                                    }
                                }
                            }
                }
                
                Spacer()
                    .frame(maxHeight: 110)
                
                NavigationLink(destination: ContentView(content: singleContent, start: start)
                    .onAppear {
                        self.start.isRankedMode = false
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                ) {
                    Text("Single Player")
                }
                .buttonStyle(FilledButton(padding: 18, fontSize: 40))
                .animation(.spring())
                
                NavigationLink(destination: ContentView(content: rankedContent, start: start)
                .onAppear {
                    self.start.isRankedMode = true
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                ) {
                    VStack {
                        Text("Ranked Mode")
                        Text("Compete with players worldwide")
                            .textCase(.uppercase)
                            .font(.footnote)
                            .foregroundColor(.blue)
                            .opacity(0.9)
                    }
                }
                .buttonStyle(BorderButton(padding: 7, fontSize: 40))
                .animation(.spring())
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StartView()
                .preferredColorScheme(.dark)
                .environment(SettingsViewModel())
        }
    }
}
