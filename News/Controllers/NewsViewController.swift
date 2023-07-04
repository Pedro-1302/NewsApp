//
//  NewsViewController.swift
//  News
//
//  Created by Pedro Franco on 03/07/23.
//

import UIKit
import WebKit

class NewsViewController: UIViewController {

    @IBOutlet weak var newsWebView: WKWebView!
    
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    
    @IBOutlet weak var loadingView: UIView!
    
    var news: NewsModel? {
        didSet {
            self.title = news?.source.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
    }
    
    private func setupWebView() {
        newsWebView.navigationDelegate = self
        
        guard let news = news else { return }
        guard let url = URL(string: news.url ?? "www.google.com") else { return }
        
        newsWebView.load(URLRequest(url: url))

        newsWebView.allowsBackForwardNavigationGestures = true
    }
}

extension NewsViewController: WKNavigationDelegate {
    // Para saber quando comecou a carregar a webview
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.loadingActivity.startAnimating()
        self.loadingView.isHidden = false
    }
    
    // Para saber quando finalizou
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.loadingActivity.stopAnimating()
        self.loadingView.isHidden = true
    }
    
    // Para saber quando deu algum erro
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.loadingActivity.stopAnimating()
        self.loadingView.isHidden = true
    }
}
