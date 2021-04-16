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
        
        //webView.load(URLRequest(url: URL(string: "https://www.youtube.com")!))
        loadHTML2(webview: webView)
        
    
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
    
    public func loadHTML2(webview : WKWebView){
        
        let paramURL = "https://www.20minutes.fr/arts-stars/television/2981275-20210222-marseillais-dubai-quand-ca-allait-tapais-poing-table-previent-jessica-aidi-bookeuse"
        
        let paramSRC = "pqvp3r"
        let autoplay = "1"
        
        let paramMDTK = "01132356"
        let paramZONE = "54"
        let paramGDPRCONSENTSTRING = "BOj8iv4Oj8iwYAHABAlxCS-AAAAnF7_______9______9uz_Ov_v_f__33e87_9v_l_7_-___u_-3zd4-_1vf99yfm1-7etr3tp_87ues2_Xur__59__3z3_9phPrsk89r633A"
        
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
