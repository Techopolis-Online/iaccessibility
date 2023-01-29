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
class SelectedContent: ObservableObject {
    @Published var selectedArticle: Article?
}

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var liveAudioPlayer: LiveAudioPlayer
    @ObservedObject var liveButtonState = LiveButtonState()
    @ObservedObject var selectedContent = SelectedContent()
    @State var selectedItem: String?
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
             TabView {
                HomeView(liveButtonState: liveButtonState, liveAudioPlayer: liveAudioPlayer, selectedContent: selectedContent)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                ReportView(liveButtonState: liveButtonState, liveAudioPlayer: liveAudioPlayer, selectedContent: selectedContent)
                    .tabItem {
                        Label("Report", systemImage: "doc.fill")
                    }
                iACastView(liveButtonState: liveButtonState, liveAudioPlayer: liveAudioPlayer, selectedContent: selectedContent)
                    .tabItem {
                        Label("iACast", systemImage: "play.square.fill")
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
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            let items = ["Home", "Report", "iACast"]
            NavigationSplitView {
                List(items, id: \.self, selection: $selectedItem) { anItem in
                    Text(anItem)
                    
                }
                
            } content: {
                if selectedItem == "Home" {
                    HomeView(liveButtonState: liveButtonState, liveAudioPlayer: liveAudioPlayer, selectedContent: selectedContent)
                } else if selectedItem == "Report" {
                    ReportView(liveButtonState: liveButtonState, liveAudioPlayer: liveAudioPlayer, selectedContent: selectedContent)
                } else if selectedItem == "iACast" {
                    iACastView(liveButtonState: liveButtonState, liveAudioPlayer: liveAudioPlayer, selectedContent: selectedContent)
                } else {
                    HomeView(liveButtonState: liveButtonState, liveAudioPlayer: liveAudioPlayer, selectedContent: selectedContent)
                }
                
            } detail: {
                DetailView(selectedContent: selectedContent)
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

