//
//  SettingsView.swift
//  TwelveFlags
//
//  Created by RnD on 9/16/21.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        Form {
            Section {
                Text("\(settingsViewModel.settings.playerName) dossier")
                    .font(CustomFont.PressStart2P(size: 25))
                    .textCase(.uppercase)
            }
            
            Section {
                HStack {
                    Text("PERSONAL BEST")
                    Spacer()
                    Text(String(settingsViewModel.settings.playerScore))
                }
                
                HStack {
                    Text("RANKED BEST")
                    Spacer()
                    Text(String(settingsViewModel.settings.rankedPlayerScore))
                }
            }
            
            Section {
                HStack {
                    Spacer()
                    
                    Button("SHRED MY DOSSIER") {
                        settingsViewModel.showingAlert = true
                    }
                    .alert(isPresented: $settingsViewModel.showingAlert) {
                        Alert(title: Text("Reset hard-earned notoriety?"), message: Text(settingsViewModel.playerNotoriety), primaryButton: .cancel(), secondaryButton: .destructive(Text("Proceed")) {
                            settingsViewModel.resetPlayerNotoriety()
                        })
                    }
                    
                    Spacer()
                }
            }
        }
        .font(CustomFont.PressStart2P(size: 15))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
