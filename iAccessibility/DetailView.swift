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
    
    var body: some View {
        NavigationStack {
            WebView(contentString: content)
        }
        .navigationTitle("iAccessibility")
        
    }
}
struct WebView: UIViewRepresentable {
 
    var url: URL?
    var contentString: String?
 
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
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
struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
