//
//  WebView.swift
//  AppPapple
//
//  Created by Christian Morante on 21/04/25.
//

import WebKit

class WebView: UIViewController {
    var urlString: String = ""
    private var webView: WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        guard var webView = self.webView else { return }
        webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }

}
