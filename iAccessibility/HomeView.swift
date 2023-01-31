//
//  HomeView.swift
//  iAccessibility
//
//  Created by Michael Doise on 10/26/22.
//

import SwiftUI

struct HomeView: View {
    @State var articles: [Article] = []
    @State private var searchString = ""
    @State private var listenTitle = "Listen"
    @ObservedObject var liveButtonState: LiveButtonState
    @ObservedObject var liveAudioPlayer: LiveAudioPlayer
    @ObservedObject var selectedContent: SelectedContent
    @State private var selectedArticle: Article?
    
    var body: some View {
        NavigationStack {
            Group {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    List(searchResults, id:\.self, selection:$selectedContent.selectedArticle) { article in
                        NavigationLink(destination: DetailView(content: article.content, title: article.title, selectedContent: selectedContent)) {
                            HStack {
                                ImageView(withURL: article.img ?? URL(string: "https://i0.wp.com/iaccessibility.net/wp-content/uploads/2018/06/cropped-cropped-ialogo-512.png?fit=512%2C512&ssl=1")!)
                                    .frame(width: 76, height: 76)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .frame(width: 76, height: 76)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                Text(article.title)
                            }
                        }
                    }
                } else if UIDevice.current.userInterfaceIdiom == .pad {
                    List(searchResults, id:\.self, selection: $selectedContent.selectedArticle) { article in
                        HStack {
                            ImageView(withURL: article.img ?? URL(string: "https://i0.wp.com/iaccessibility.net/wp-content/uploads/2018/06/cropped-cropped-ialogo-512.png?fit=512%2C512&ssl=1")!)
                                .frame(width: 76, height: 76)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .frame(width: 76, height: 76)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            Text(article.title)
                        }
                        
                        
                    }
                }
            }
            .navigationTitle("Home")
            .navigationBarItems(trailing: Button(changeLiveLabel()) {
                playAudio()
            })
            .searchable(text: $searchString, placement: .automatic)
            .onAppear {
                let url = URL(string: "https://iaccessibility.net/feed")
                let request = URLRequest(url: url!)
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if data == nil {
                        print("dataTaskWithRequest error: \(String(describing: error?.localizedDescription))")
                        return
                    }
                    let myParser: FeedParser = FeedParser.init(data: data!)
                    myParser.parse()
                    self.articles = myParser.articles
                    print(self.articles)
                }
                task.resume()
            }
        }
        .navigationSplitViewStyle(.prominentDetail)
        .navigationBarItems(trailing: Button(changeLiveLabel()) {
            playAudio()
        })
        
    }
    func changeLiveLabel() -> String {
        if liveButtonState.isPlaying {
            return "Stop"
        } else {
            return "Listen"
        }
    }
    func playAudio() {
        liveButtonState.isPlaying.toggle()
        if liveButtonState.isPlaying == true {
            listenTitle = "Stop"
            liveAudioPlayer.play(url: URL(string: "https://streaming.live365.com/a63924")!)
        } else {
            listenTitle = "Listen"
            liveAudioPlayer.pause()
        }
    }
    var searchResults: [Article] {
        if searchString.isEmpty {
            return articles
        } else {
            return articles.filter { $0.title
                .localizedCaseInsensitiveContains(searchString) }
        }
        
    }
}

/*struct HomeView_Previews: PreviewProvider {
 static var previews: some View {
 let livePlayerButton = LiveButtonState()
 let audioPlayer = LiveAudioPlayer()
 HomeView(liveButtonState: livePlayerButton, liveAudioPlayer: audioPlayer, selectedContent: SelectedContent)
 }
 }*/
