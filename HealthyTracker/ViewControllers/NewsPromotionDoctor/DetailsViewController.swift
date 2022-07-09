//
//  DetailsViewController.swift
//  HealthyTracker
//
//  Created Nguyen Quang Hung on 02/07/2022.
//

import UIKit
import WebKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var lbTitle: UILabel!
    
    var url : URL?
    var titles: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func configVC(title: String?, url: URL?) {
        self.title = title
        self.url = url
    }
    
    func setupView(){
        if let titles = titles{
            lbTitle.text = titles
        }
        
        if let url = self.url{
            self.webView.load(URLRequest(url: url))
        }
        self.webView.navigationDelegate = self
        
        /// if webview didn't finish loading data in 3s, display webview
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.loading.isHidden = true
            self.webView.isHidden = false
        }

    }
    
    @IBAction func onTapBtnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onTapBtnShare(_ sender: UIButton) {
        /// copy news url to clipboard
        UIPasteboard.general.string = self.url?.description
        self.showToast(message: "Copied url to clipboard")
    }
}
extension DetailsViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loading.startAnimating()
        loading.isHidden = false
        self.webView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.isHidden = false
        loading.isHidden = true
        loading.stopAnimating()
    }
}
