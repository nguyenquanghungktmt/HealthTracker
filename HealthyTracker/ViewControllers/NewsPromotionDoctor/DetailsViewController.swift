//
//  DetailsViewController.swift
//  HealthyTracker
//
//  Created by pc_1359 on 02/07/2022.
//

import UIKit
import WebKit

class DetailsViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var viewContent: UIView!
    
    var webView : WKWebView!
    var url : URL?
    
    override func loadView() {
//        webView = WKWebView(frame: viewContent.bounds, configuration: WKWebViewConfiguration())
//        webView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.viewContent.addSubview(webView!)
//
//        webView?.navigationDelegate = self
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 30))
//        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        webView.navigationDelegate = self
        
        if let url = self.url{
            webView?.load(URLRequest(url: url))
//            self.viewContent.addSubview(webView)
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
