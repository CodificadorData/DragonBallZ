//
//  WebView.swift
//  AppPapple
//
//  Created by Christian Morante on 21/04/25.
//

import WebKit

class WebViews: UIViewController {
    var urlString: String = ""
    private var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
        view = webView
    }

}
