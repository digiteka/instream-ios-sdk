//
//  DigitekaPlayer.swift
//  Digiteka
//
//  Created by INGENOSYA SA on 13/04/2021.
//  Copyright © 2021 INGENOSYA SA. All rights reserved.
//
import UIKit
import WebKit
import JavaScriptCore

open class DigitekaPlayer : UIViewController, UIScrollViewDelegate {
    private var webView : WKWebView!
    private var contentView : DigitekaView?
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    public func log(message : String){
    
        print("Message = ",message)
        
    }
    
    public func affiche_webview(_view : UIView,paramURL:String , paramSRC:String,autoplay:String,paramMDTK:String,paramZONE:String,paramGDPRCONSENTSTRING:String){
        
        self.webView = WKWebView (frame: _view.bounds)
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.webView.navigationDelegate = self
        self.webView.scrollView.frame = self.webView.frame
        self.webView.scrollView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        self.webView.scrollView.delegate = self
        self.webView.scrollView.bounces = false
        self.webView.contentMode = .scaleToFill
    
        self.webView.allowsBackForwardNavigationGestures = true
        _view.addSubview(webView)
        
        //webView.load(URLRequest(url: URL(string: "https://www.youtube.com")!))
        
        loadHTMLDigiteka(webview: webView,paramURL : paramURL, paramSRC : paramSRC, autoplay : autoplay, paramMDTK : paramMDTK, paramZONE : paramZONE, paramGDPRCONSENTSTRING : paramGDPRCONSENTSTRING)
      
    }
    
    public func loadHTMLDigiteka(webview : WKWebView,paramURL:String , paramSRC:String,autoplay:String,paramMDTK:String,paramZONE:String,paramGDPRCONSENTSTRING:String){
        
        
        let myURL = URL(string:"https://www.20minutes.fr/")
        
        
        let html = "<html>\n" +
            "<head>\n" +
            "    <meta charset=\"UTF-8\">\n" +
            "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
            "    <link rel='canonical' href='"+paramURL+"'>\n" +
            "    <style type=\"text/css\">\n" +
            "        body{\n" +
            "            margin: 0;\n" +
            "            padding: 0;\n" +
            "        }\n" +
            "\n" +
            "        iframe {\n" +
            "            position: absolute;\n" +
            "            width: 100%;\n" +
            "            height: 100%;\n" +
            "            top: 0;\n" +
            "            left: 0;\n" +
            "        }\n" +
            "    </style>\n" +
            "    <title>Digiteka Player</title>\n" +
            "</head>\n" +
            "<body>\n" +
            "    <iframe id=\"frame\"\n" +
            "        frameborder=\"0\"\n" +
            "        scrolling='no' marginwidth='0' marginheight='0' hspace='0' vspace='0' allowfullscreen='true' allow='autoplay'" +
            "        src='https://www.ultimedia.com/deliver/generic/iframe/mdtk/"+paramMDTK+"/src/"+paramSRC+"/zone/1/showtitle/"+paramZONE+"/gdprconsentstring/"+paramGDPRCONSENTSTRING+"?urlfacebook="+paramURL+"&tagparamdecoded=video_app&sa=D&ust=1586938702508000&usg=AOvVaw0EoSE28fXl4HfVg-fQrA4n'>" +
            "    </iframe>\n" +
            "\n" +
            "<script type=\"text/javascript\" >" +
            "function controll(p){\n" +
            "  var controll = document.getElementById(\"frame\").contentWindow.postMessage(p,\"*\") ;\n" +
            "  console.log(\"je suis dans la fonction 'controll' \");\n" +
            "  return controll" +
            "}" +
            "if ("+autoplay+" !== 1) {" +
            "window.onload = function() {\n" +
            "      controll('pause');\n" +
            "      console.log(\"function pause() called\");\n" +
            "}\n" +
            "}" +
            "else {Android.setStatusVideoPlay(true);}" +
            "window.addEventListener(\"message\", function (message) { \n" +
            "       if(message.data=='event=played')Android.setStatusVideoPlay(true);\n" +
            "       if(message.data=='event=paused')Android.setStatusVideoPlay(false);\n" +
            " }, false);\n" +
            "</script>\n" +
            "</body>\n" +
        "</html>"
        
        webview.loadHTMLString(html, baseURL: myURL)
        
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
    

    private func loadView(_ frame : CGRect){
        self.removeViewExisting()
        contentView = DigitekaView(frame: frame)
        contentView?.backgroundColor = UIColor.clear
        view.addSubview(contentView ?? UIView())
        contentView?.moveViews(y: -self.view.frame.height, false)
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
    
    public func hideDidScroll() {
        self.removeViewExisting()
    }
    public func viewDidAutoPlayTopAsLeft() {
        let frame = CGRect(x: 20, y: self.view.frame.height , width: 200  ,height: 150)
        self.loadView(frame)
    }
    public func viewDidAutoPlayTopAsRightDidScroll() {
        let frame = CGRect(x: self.view.frame.width - 200 ,
                           y: self.view.frame.height,width: 200, height: 150)
        self.loadView(frame)
    }
    public func viewDidAutoPlayBottomAsLeft() {
        let frame = CGRect(x: 20,
                           y: self.view.frame.size.height * 2 - 150,
                           width: 200,
                           height: 150)
        self.loadView(frame)
    }
    
    public func onChangeScrollView(_ scrollView: UIScrollView) {
        //Ato Via SDK manova visiblity
    }
    public func onScrollTopLeft(_ isHashShow: Bool, _ contentOffset: CGPoint) {
    }
    public func onScrollBottomLeft(_ isHashShow: Bool, _ contentOffset: CGPoint) {
        
    }
    public func onScrollTopRight(_ isHashShow: Bool, _ contentOffset: CGPoint) {
        
    }
}

