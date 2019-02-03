//
//  DetailPageViewController.swift
//  RxReader
//
//  Created by 玉置 on 2019/02/03.
//  Copyright © 2019 Tamaoki. All rights reserved.
//

import UIKit
import WebKit

class DetailPageViewController: UIViewController, WKUIDelegate {
    
    private var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        return WKWebView(frame: .zero, configuration: webConfiguration)
    }()
    
    var urlString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.uiDelegate = self
        view = webView
        requestPage()
    }
    
    private func requestPage() {
        guard let urlString = urlString,
            let myURL = URL(string: urlString) else { return }
        let myRequest = URLRequest(url: myURL)
        webView.load(myRequest)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
