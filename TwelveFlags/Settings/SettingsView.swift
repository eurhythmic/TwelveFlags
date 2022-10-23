//
//  SettingsView.swift
//  TwelveFlags
//
//  Created by RnD on 9/16/21.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    
    private var playerName: Binding<String> {
        Binding {
            settingsViewModel.settings.playerName
        } set: {
            let formattedName = $0.trimmingCharacters(in: .whitespacesAndNewlines)
            settingsViewModel.settings.playerName = formattedName
        }
    }
    
    var body: some View {
        Form {
            Section {
                if settingsViewModel.showingTextField {
                    TextField("Name", text: playerName)
                        .font(CustomFont.PressStart2P(size: 25))
                        .textInputAutocapitalization(.characters)
                        .autocorrectionDisabled(true)
                        .textCase(.uppercase)
                        .onSubmit {
                            withAnimation {
                                settingsViewModel.showingTextField = false
                            }
                        }
                } else {
                    Text(settingsViewModel.settings.playerName.isEmpty ? "Dossier" : "\(settingsViewModel.settings.playerName) Dossier")
                        .font(CustomFont.PressStart2P(size: 25))
                        .textCase(.uppercase)
                        .onTapGesture {
                            withAnimation {
                                settingsViewModel.showingTextField = true
                            }
                        }
                }
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
            .environmentObject(SettingsViewModel())
    }
}
