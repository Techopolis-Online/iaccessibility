//
//  ContentView.swift
//  iAccessibility
//
//  Created by Michael Doise on 10/26/22.
//

import SwiftUI

class LiveButtonState: ObservableObject {
    @Published var isPlaying = false
}

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var liveAudioPlayer: LiveAudioPlayer
    @ObservedObject var liveButtonState = LiveButtonState()
    var body: some View {
        TabView {
            Group {
                HomeView(liveButtonState: liveButtonState, liveAudioPlayer: liveAudioPlayer)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                ReportView(liveButtonState: liveButtonState, liveAudioPlayer: liveAudioPlayer)
                    .tabItem {
                        Label("Report", systemImage: "doc.fill")
                    }
                iACastView(liveButtonState: liveButtonState, liveAudioPlayer: liveAudioPlayer)
                    .tabItem {
                        Label("iACast", systemImage: "play.square.fill")
                    }
            }
            
            
        }
        .accentColor(.blue)
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if liveAudioPlayer.player?.rate ?? 0 > 0 {
                    liveButtonState.isPlaying = true
                } else {
                    liveButtonState.isPlaying = false
                }
            }
            
            
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let audioPlayer = LiveAudioPlayer()
        ContentView(liveAudioPlayer: audioPlayer)
    }
}

