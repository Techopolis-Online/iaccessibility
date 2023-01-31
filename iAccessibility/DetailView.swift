//
//  DetailView.swift
//  iAccessibility
//
//  Created by Michael Doise on 10/28/22.
//

import SwiftUI
import WebKit

struct DetailView: View {
    @State var content: String?
    @State var isPoDCAST: Bool = false
    @State var title: String?
    @State var image: URL?
    @ObservedObject var selectedContent: SelectedContent
    var body: some View {
        Group {
            if UIDevice.current.userInterfaceIdiom == .phone {
                WebView(contentString: content)
                    .navigationTitle(title ?? "iAccessibility")
            } else {
                WebView(contentString: selectedContent.selectedArticle?.content ?? "testing")
                    .navigationTitle(selectedContent.selectedArticle?.title ?? "iAccessibility")
            }
        }
        
        
    }
}
struct WebView: UIViewRepresentable {
 
    var url: URL?
    var contentString: String?
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        if contentString != nil {
            webView.loadHTMLString(contentString!, baseURL: nil)
        } else {
            let request = URLRequest(url: url!)
            webView.load(request)
        }
        
    }
}
/*struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}*/
