//
//  DigitekaView.swift
//  Digiteka
//
//  Created by Lucas on 14/04/2021.
//  Copyright © 2021 INGENOSYA SA. All rights reserved.
//

import UIKit
import WebKit

open class DigitekaView: UIView, WKNavigationDelegate, UIScrollViewDelegate {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        let webView = WKWebView (frame: self.bounds)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
       // webView.scrollView.frame = self.webView.frame
        webView.scrollView.contentInset = UIEdgeInsets(top: 10,left: 0,bottom: 0,right: 0)
        webView.scrollView.delegate = self
        webView.scrollView.bounces = false
        webView.contentMode = .scaleToFill
        webView.allowsBackForwardNavigationGestures = true
        self.addSubview(webView)
        webView.load(URLRequest(url: URL(string: "https://www.youtube.com")!))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   public func centerView(_ views: [UIView], pointX: CGFloat) {
        for view in views {
            view.center.x = pointX
        }
    }
   public func animateWithSpring( _ pointX: CGFloat, _ delay: TimeInterval) {
        let targatAlpha: CGFloat = self.alpha == 0 ? 1 : 0
        UIView.animate(withDuration: 0.25, delay: delay, usingSpringWithDamping: 0.25, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.alpha = targatAlpha
            self.center.x = pointX
        })
    }
  public func moveViews(y: CGFloat, _ shouldRemove: Bool) {
        UIView.animate(withDuration: 0.5, animations: {
              self.center.y += y
        }) { (success) in
            if shouldRemove {
                self.removeFromSuperview()
            }
        }
    }
    
}
