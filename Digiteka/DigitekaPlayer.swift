//
//  DigitekaPlayer.swift
//  Digiteka
//
//  Created by INGENOSYA SA on 13/04/2021.
//  Copyright © 2021 INGENOSYA SA. All rights reserved.
//
import UIKit
import WebKit

open class DigitekaPlayer : UIViewController, UIScrollViewDelegate {
    private var webView : WKWebView!
    private var contentView : DigitekaView?
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    public func log(message : String){
    
        print("Message = ",message)
        
    }
    
    public func affiche_webview(_view : UIView){
        
        self.webView = WKWebView (frame: _view.bounds)
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.webView.navigationDelegate = self
        self.webView.scrollView.frame = self.webView.frame
        self.webView.scrollView.contentInset = UIEdgeInsets(top: 10,left: 0,bottom: 0,right: 0)
        self.webView.scrollView.delegate = self
        self.webView.scrollView.bounces = false
        self.webView.contentMode = .scaleToFill
        self.webView.allowsBackForwardNavigationGestures = true
        _view.addSubview(webView)
        webView.load(URLRequest(url: URL(string: "https://www.youtube.com")!))
      
    }
    
   private func removeViewExisting() {
       
        if contentView != nil {
            contentView?.removeFromSuperview()
            contentView = nil
        }
    }
    deinit{
            webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.loading))
            webView.navigationDelegate = nil
            webView.scrollView.delegate = nil
            webView.removeFromSuperview()
            webView = nil
     }
    open override func loadView() {
        super.loadView()
        
     }
    
}


extension DigitekaPlayer : WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void){
          if navigationAction.targetFrame == nil {
              webView.load(navigationAction.request)
          }
          decisionHandler(.allow)
      }

}

extension DigitekaPlayer : WebViewHelpersDelegate {
    
    public func viewDidAutoPlayTopAsLeft() {
      
        
    }
    public func viewDidAutoPlayTopAsRightDidScroll() {
    
    }
    public func viewDidAutoPlayBottomAsLeft() {
        self.removeViewExisting()
        let frame = CGRect(x: 20, y: self.view.frame.height * 1.7, width: self.view.frame.width - 40 ,
                           height: self.view.frame.height - 180)
        contentView = DigitekaView(frame: frame)
        contentView?.backgroundColor = UIColor.black
        view.addSubview(contentView ?? UIView())
        contentView?.moveViews(y: -self.view.frame.height, false)
        
    }
}

