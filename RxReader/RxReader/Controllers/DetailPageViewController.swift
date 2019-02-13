//
//  DetailPageViewController.swift
//  RxReader
//
//  Created by 玉置 on 2019/02/03.
//  Copyright © 2019 Tamaoki. All rights reserved.
//

import UIKit
import WebKit
import RxWebKit
import RxSwift
import RxCocoa
import RxOptional

class DetailPageViewController: UIViewController {
    
    var urlString: String?
    
    private var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        return WKWebView(frame: .zero, configuration: webConfiguration)
    }()

    private var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .bar
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
        view = webView
        setupRXAndRequestPage()
        setupProgressView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.progressView.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.progressView.isHidden = true
    }
    
    private func setupProgressView() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(progressView)
        self.progressView.leftAnchor.constraint(equalTo: navigationBar.leftAnchor, constant: 0).isActive = true
        self.progressView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: 0).isActive = true
        self.progressView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 0).isActive = true
        self.progressView.heightAnchor.constraint(equalToConstant: 3.0).isActive = true
    }
    
    private func setupRXAndRequestPage() {
        let loadingObservable = webView.rx.loading
            .share()
        
        loadingObservable
            .map { return !$0 }
            .observeOn(MainScheduler.instance)
            .bind(to: progressView.rx.isHidden)
            .disposed(by: disposeBag)
        
        loadingObservable
            .bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible)
            .disposed(by: disposeBag)
        
        webView.rx.title
            .filterNil()
            .observeOn(MainScheduler.instance)
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        webView.rx.estimatedProgress
            .map { return Float($0) }
            .observeOn(MainScheduler.instance)
            .bind(to: progressView.rx.progress)
            .disposed(by: disposeBag)
        
        webView.rx.url
            .subscribe(onNext: {
                guard let url = $0 else { return }
                self.requestWebPage(url: url)
            })
            .disposed(by: disposeBag)
        
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        requestWebPage(url: url)
    }
    
    private func requestWebPage(url: URL) {
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
}

extension DetailPageViewController: WKUIDelegate {
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}
