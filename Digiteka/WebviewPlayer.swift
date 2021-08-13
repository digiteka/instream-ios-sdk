//
//  WebviewPlayer.swift
//  Digiteka
//
//  Created by INGENOSYA on 28/04/2021.
//  Copyright © 2021 INGENOSYA SA. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore

class WebviewPlayer {
    
    
    let contentController = WKUserContentController()
    public var _webview : WKWebView!
    var _paramURL:String
    var _paramSRC:String
    var _paramMDTK:String
    var _paramZONE:String
    var _paramGDPRCONSENTSTRING:String
    var _autoplay:String
    var _test:Bool?
    var _config :WKWebViewConfiguration!
    
    init(webview : WKWebView,paramURL:String , paramSRC:String,autoplay:String,paramMDTK:String,paramZONE:String,paramGDPRCONSENTSTRING:String,config : WKWebViewConfiguration!) {
        self._webview = webview
        self._paramURL = paramURL
        self._paramSRC = paramSRC
        self._paramMDTK = paramMDTK
        self._paramZONE = paramZONE
        self._paramGDPRCONSENTSTRING = paramGDPRCONSENTSTRING
        self._autoplay = autoplay
        self._config = config
    
        loadHTMLDigiteka()
    }
    
    func loadHTMLDigiteka(){
        
        let strURL = URL(string: _paramURL)
        
        print("_paramGDPRCONSENTSTRING------------- = "+_paramGDPRCONSENTSTRING)
        
        //BaseURL
        let myURL = URL(string: (strURL?.scheme)!+"://"+(strURL?.host)!+"/")
        
        let html = "<!DOCTYPE html>\n" +
             "<html lang=\"en\">\n" +
            "<head>\n" +
            "    <meta charset=\"UTF-8\">\n" +
            "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
            "    <link rel='canonical' href='"+_paramURL+"'>\n" +
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
            "        src='https://www.ultimedia.com/deliver/generic/iframe/mdtk/"+_paramMDTK+"/src/"+_paramSRC+"/zone/"+_paramZONE+"/showtitle/1/gdprconsentstring/"+_paramGDPRCONSENTSTRING+"?urlfacebook="+_paramURL+"&tagparamdecoded=video_app&sa=D&ust=1586938702508000&usg=AOvVaw0EoSE28fXl4HfVg-fQrA4n'>" +
            "    </iframe>\n" +
            "\n" +
            "<script type=\"text/javascript\">" +
            "console.log(\"je suis dans la fonction 'controll' \");" +
            "function controll(p){\n" +
            "  var controll = document.getElementById(\"frame\").contentWindow.postMessage(p,\"*\") ;\n" +
            "  console.log(\"je suis dans la fonction 'controll' \");\n" +
            "  return controll" +
            "}" +
            "function setStatusVideoPlay(status) {\n" +
            "  window.webkit.messageHandlers.eventHandler.postMessage(status);\n" +
            "}\n" +
            "if ("+_autoplay+" === 1) {" +
                "window.onload = function() {\n" +
                "      controll('play');\n" +
                "      console.log(\"function play() called\");\n" +
                "}\n" +
            "}" +
            "window.addEventListener(\"message\", function (message) { \n" +
            "       if(message.data=='event=played'){setStatusVideoPlay(true)};\n" +
            "       if(message.data=='event=paused'){setStatusVideoPlay(false)};\n" +

            " }, false);\n" +
            "</script>\n" +
            "</body>\n" +
        "</html>"
    
        _webview.loadHTMLString(html, baseURL: myURL)

        
    }
    
    
    public func changeControll(boolean : Bool){
        self._test=boolean
        if self._test! {
            _webview.callJavascript("controll('play');")

        }
    }
    
}

extension WKWebView {
    func callJavascript(_ scriptString : String) {
         print("Appel fonction Javascript")
        self.evaluateJavaScript(scriptString, completionHandler: { (object, error) in
            print(error.debugDescription)
        })
    }
}

