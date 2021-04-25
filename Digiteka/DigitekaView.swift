//
//  DigitekaView.swift
//  Digiteka
//
//  Created by Lucas on 14/04/2021.
//  Copyright © 2021 INGENOSYA SA. All rights reserved.
//

import UIKit
import WebKit

open class DigitekaView: UIView, WKNavigationDelegate, UIScrollViewDelegate  {
    private var webView : WKWebView!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        print("todo init ")
        
        let preferences = WKPreferences()
         preferences.javaScriptEnabled = true
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        let scriptString = "controll('play');"
        let script = WKUserScript(source: scriptString, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
            config.userContentController.addUserScript(script)
        config.preferences = preferences
      
        webView = WKWebView(frame: self.bounds,configuration: config)
        webView.configuration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        webView.configuration.preferences.javaScriptEnabled = true
        webView.translatesAutoresizingMaskIntoConstraints = false 
        webView.navigationDelegate = self
        webView.scrollView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        webView.scrollView.delegate = self
        webView.scrollView.bounces = false
        webView.backgroundColor = .black
        webView.contentMode = .scaleToFill
        webView.allowsBackForwardNavigationGestures = true
        webView.callJS(scriptString)
        
        webView.load(URLRequest(url: URL(string: "https://www.youtube.com")!))
        
        
        self.addSubview(webView)
        //loadHTML2(webview: webView)
        
    
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
//        let targatAlpha: CGFloat = self.alpha == 0 ? 1 : 0
//        UIView.animate(withDuration: 0.25, delay: delay, usingSpringWithDamping: 0.25, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
//            self.alpha = targatAlpha
//            self.center.x = pointX
//        })
    }
    
    
    
  public func moveViews(y: CGFloat, _ shouldRemove: Bool) {
//        UIView.animate(withDuration: 0.5, animations: {
//              self.center.y += y
//        }) { (success) in
//            if shouldRemove {
//                self.removeFromSuperview()
//            }
//        }
    
        self.center.y+=y
        if shouldRemove {
            self.removeFromSuperview()
        }
    
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

    
}
extension WKWebView {
    func callJS(_ scriptString : String) {
        self.evaluateJavaScript(scriptString, completionHandler: { (object, error) in
            print(error.debugDescription)
        })
    }


}
