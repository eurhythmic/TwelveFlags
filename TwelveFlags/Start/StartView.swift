//
//  StartView.swift
//  TwelveFlags
//
//  Created by RnD on 12/29/20.
//

import SwiftUI

struct StartView: View {
    let start = StartViewModel()
    let content = ContentViewModel(generator: FlagGenerator())
    @StateObject var settingsViewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack(alignment: .top) {
                    Text("TwelveFlags")
                        .fontWeight(.heavy)
                        .font(.title)
                        .padding(.bottom, 110)
                    
                    Image(systemName: "flag.circle.fill")
                        .font(.title)
                }
                
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
