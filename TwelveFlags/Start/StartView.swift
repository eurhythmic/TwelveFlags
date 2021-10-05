//
//  StartView.swift
//  TwelveFlags
//
//  Created by RnD on 12/29/20.
//

import SwiftUI

struct StartView: View {
    @StateObject var start = StartViewModel()
    let content = ContentViewModel()
    @StateObject var settingsViewModel = SettingsViewModel()
    
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
                    HStack {
                        Text("Welcome back, \(settingsViewModel.settings.playerName)")
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
                }
                
                Spacer()
                    .frame(maxHeight: 110)
                
                NavigationLink(destination: ContentView(content: content, start: start)
                    .onAppear {
                        self.start.isRankedMode = false
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                ) {
                    Text("Single Player")
                }.buttonStyle(FilledButton())
                
                NavigationLink(destination: ContentView(content: content, start: start)
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
                }.buttonStyle(BorderButton())
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .environmentObject(settingsViewModel)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StartView()
                .preferredColorScheme(.dark)
        }
    }
}
