//
//  PaymentViewController.swift
//  CCommerce
//
//  Created by dodor on 12/28/23.
//

import UIKit
import WebKit

final class PaymentViewController: UIViewController {

    private var webView: WKWebView?
    private var getMessageScriptName: String = "receiveMessage"
    
    override func loadView() {
        let contentController = WKUserContentController()
        contentController.add(self, name: getMessageScriptName)
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        webView = WKWebView(frame: .zero, configuration: config)
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView?.load(URLRequest(url: URL(string: "https://google.co.kr")!))
    }

    private func loadWebView() {
        guard let htmlPath = Bundle.main.path(forResource: "test", ofType: "html")
        else { return }
        let url = URL(fileURLWithPath: htmlPath)
        let request = URLRequest(url: url)
        
        webView?.load(request)
    }
    
    private func setUserAgent() {
        webView?.customUserAgent = "CCommerce/1.0.0/iOS"
    }
    
    private func setCookie() {
        guard let cookie = HTTPCookie(properties: [
            .domain: "google.co.kr",
            .path: "/",
            .name: "myCookie",
            .value: "cookieValue",
            .secure: "FALSE",
            .expires: NSDate(timeIntervalSinceNow: 3600)
        ]) else { return }
        webView?.configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
    }
    
    private func callJavaScript() {
        webView?.evaluateJavaScript("javascriptFunction();")
    }
}

extension PaymentViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == getMessageScriptName {
            print("\(message.body)")
        }
    }
}

#Preview {
    PaymentViewController()
}
