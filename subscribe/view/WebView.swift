//
//  WebView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/03/04.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var urlToLoad: String
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.urlToLoad)
        else { return WKWebView() }

        let webView = WKWebView()
        webView.load(URLRequest(url: url))

        return webView
    }
}
