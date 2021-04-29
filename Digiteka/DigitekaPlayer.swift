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
    public var _position : String?
    
    private var webViewPlayer : WKWebView!
    
    //Script
    public var scriptString : String!

    
    //Visible Player
    public var player : UIView!
    
    //Param client
    public var __position : String?
    public var playerPrincipal : UIView!
    
    //JS Config
    let config = WKWebViewConfiguration()
    
    public var closePlay : Bool?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    public func affiche_webview(_view : UIView,position:String?,paramURL:String , paramSRC:String,autoplay:String,paramMDTK:String,paramZONE:String,paramGDPRCONSENTSTRING:String,margeH : Int ,margeV :Int, dimension : Int ){
        
        print ("debut ")
        
        __position = position
        playerPrincipal = _view
        
        let preferences = WKPreferences()
         preferences.javaScriptEnabled = true
        
        
        config.allowsInlineMediaPlayback = true
        config.preferences = preferences
        
        //Config Player
        self.removeViewExisting()
        if position == "top_left"  {
            scriptString = "controll('play');"
            //player = UIView(frame: CGRect(x: 20, y: 90 , width: 200  ,height: 150))
            player = UIView(frame: CGRect(x: margeH, y: 80+margeV , width: setWidth(value: dimension) ,height: setHeight(value: dimension)))
            
            
        }else if position == "top_right" {
            scriptString = "controll('play');"
            //player = UIView(frame: CGRect(x: self.view.frame.width-220, y: 90 , width: 200  ,height: 150))
            let xx = self.view.frame.width
        
            player = UIView(frame: CGRect(x: Int(CGFloat(xx)-CGFloat(setWidth(value: dimension)+margeH)), y: 80+margeV , width: setWidth(value: dimension) ,height: setHeight(value: dimension)))
        
            
            
        }else if position == "bottom_left" {
            scriptString = " "
            let yy = self.view.frame.size.height
            player = UIView(frame: CGRect(x: margeH,y:   Int(CGFloat(yy)-CGFloat(180)),width: setWidth(value: dimension),height: setHeight(value: dimension)))
            
            
        }
        
        if autoplay == "1" { // AutoPlay
            self.webView = WKWebView(frame: player.bounds, configuration: config)
            //webViewPlayer = WKWebView(frame : player.bounds , configuration: config)
            
        }else if autoplay == "2" { // Scroll to play
            self.webView = WKWebView(frame: player.bounds, configuration: config)
            //webViewPlayer = WKWebView(frame : player.bounds , configuration: config)
            
        }else if autoplay == "0" { // Click to play
            
            self.webView = WKWebView(frame: player.bounds/*, configuration: config*/)
            //webViewPlayer = WKWebView(frame : player.bounds /*, configuration: config*/)
            
        }
        

        let script = WKUserScript(source: scriptString, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
        config.userContentController.addUserScript(script)
        
        
        webView.configuration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        webView.configuration.preferences.javaScriptEnabled = true
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.webView.navigationDelegate = self
        self.webView.scrollView.frame = self.webView.frame
        self.webView.scrollView.contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        self.webView.scrollView.delegate = self
        self.webView.scrollView.bounces = false
        self.webView.contentMode = .scaleToFill
        self.webView.callJS(scriptString)
        self.webView.allowsBackForwardNavigationGestures = true
        //webView.backgroundColor = UIColor.black
        
        //webView.frame.size.width = _view.frame.size.width
        
    
        //_view.addSubview(webView)
        

        //webView.load(URLRequest(url: URL(string: "https://www.youtube.com")!))
    
        
        //let webViewPlayer = WKWebView(frame : _view.bounds , co nfiguration: config)
        
        
        loadHTMLDigiteka(webview: webView,/*visiblePlayer : webViewPlayer,*/paramURL : paramURL, paramSRC : paramSRC, autoplay : autoplay, paramMDTK : paramMDTK, paramZONE : paramZONE, paramGDPRCONSENTSTRING : paramGDPRCONSENTSTRING)
        
        player.addSubview(webView)
        self.view.addSubview(player)
        
        
        Addclose(v: player)
        
        print ("fin")
    
    
    }
    
    public func setWidth(value : Int) -> Int {
        
        var long : Int!
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        long = Int((value*Int(screenWidth))/100)
        
        return long
        
    }
    
    public func setHeight(value : Int) -> Int{
        
        var larg : Int!
        
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        
        larg = Int((value*Int(screenHeight))/100)
        
        return larg/2
        
    }
    

    public func Addclose(v : UIView){
        
        let lb = UILabel(frame: CGRect(x: v.frame.width-25, y: 10, width: 25, height: 25))
        lb.text = "x"
        lb.textColor = UIColor.white
        
        v.addSubview(lb)
        let tap = UITapGestureRecognizer(target: self, action: #selector(closePlayer))
        lb.isUserInteractionEnabled = true
        lb.addGestureRecognizer(tap)
        //let v = UIView(frame: self.bounds)
        
    }
    
     @objc func closePlayer(){
        //self.removeViewExisting()
        player?.isHidden = true
        
        closePlay = true
        
    }


    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
        case "error":
            let error = (message.body as? [String: Any])?["message"] as? String ?? "unknown"
            assertionFailure("JavaScript error: \(error)")
        default:
            assertionFailure("Received invalid message: \(message.name)")
        }
    }
    public func loadHTMLDigiteka(webview : WKWebView,paramURL:String , paramSRC:String,autoplay:String,paramMDTK:String,paramZONE:String,paramGDPRCONSENTSTRING:String){
        
    
        let strURL = URL(string: paramURL)
        
        let myURL = URL(string: (strURL?.scheme)!+"://"+(strURL?.host)!+"/")
        
    
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
    
        /*if contentView != nil {
            contentView?.removeFromSuperview()
            contentView = nil
        }*/
    
    
        

     player?.isHidden = true
    
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
        
        //self.removeViewExisting()
        
        /*contentView = DigitekaView(frame: frame)
        contentView?.backgroundColor = UIColor.clear
        view.addSubview(contentView ?? UIView())
        contentView?.moveViews(y: -self.view.frame.height, false)*/
        
    }
    

}


extension DigitekaPlayer : WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void){
          if navigationAction.targetFrame == nil {
              webView.load(navigationAction.request)
          }
          decisionHandler(.allow)
      }
    
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        print("An error from web view: \(message)")
    }

}

extension DigitekaPlayer : WebViewHelpersDelegate {
    
    public func hideDidScroll() {
        self.removeViewExisting()
    }
    public func viewDidAutoPlayTopAsLeft() {
        /*let frame = CGRect(x: 20, y: self.view.frame.height+90 , width: 200  ,height: 150)
        self.loadView(frame)*/
        if closePlay == true {
            player.isHidden = true
        }else {
            player.isHidden = false
            webView.frame.size.width = player.frame.size.width
            webView.frame.size.height = player.frame.size.height
            //webView.backgroundColor = UIColor.black
            player.addSubview(webView)
            self.view.addSubview(player)
            Addclose(v: player)
            
        }
        
        
        
    }
    public func viewDidAutoPlayTopAsRightDidScroll() {
        /*let frame = CGRect(x: self.view.frame.width - 220 ,
                           y: self.view.frame.height+90,width: 200, height: 150)
        self.loadView(frame)*/
        if closePlay == true {
            player.isHidden = true
        }else {
            player.isHidden = false
            webView.frame.size.width = player.frame.size.width
            webView.frame.size.height = player.frame.size.height
            player.addSubview(webView)
            self.view.addSubview(player)
            Addclose(v: player)
        }
    }
    public func viewDidAutoPlayBottomAsLeft() {
        /*let frame = CGRect(x: 20,
                           y: self.view.frame.size.height * 2 - 170,
                           width: 200,
                           height: 150)
        self.loadView(frame)*/
        if closePlay == true {
            player.isHidden = true
        }else {
            player.isHidden = false
            webView.frame.size.width = player.frame.size.width
            webView.frame.size.height = player.frame.size.height
            player.addSubview(webView)
            self.view.addSubview(player)
            Addclose(v: player)
        }
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
    
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        

        //print("scrollView.contentOffset.y = ",scrollView.contentOffset.y)
                let viewY = playerPrincipal.frame.origin.y
                let viewHeight = playerPrincipal.frame.height
                let viewHalfHeight = viewHeight / 2
                let digitekaHeight : CGFloat
                digitekaHeight = viewY + viewHeight
                let screenSize = UIScreen.main.bounds
                //let screenWidth = screenSize.width
                let screenHeight = screenSize.height
                /*print("Valeur de Point de View principal = ",viewY!)
                print("Valeur de Point de Height de View principal = ",viewHeight!)
                print("Valeur de Point de Height de l'ecran = ",screenHeight)
                print("Valeur de DIGITEKA = ",digitekaHeight)*/
            
        //      CONDITION D'AFFICHAGE DU PLAYER PRINCIPAL
                if ((((CGFloat(viewY) + viewHalfHeight) >= scrollView.contentOffset.y) && (digitekaHeight <= (screenHeight + scrollView.contentOffset.y)))
                    || ((scrollView.contentOffset.y + screenHeight) >= (CGFloat(viewY) + viewHalfHeight)) && (CGFloat(viewY) >= scrollView.contentOffset.y)){ // View Principal 100%
                        //print("VUE 100%")
                        hideDidScroll()
                        
                        webView.frame.size.width = playerPrincipal.frame.size.width
                        webView.frame.size.height = playerPrincipal.frame.size.height
                        playerPrincipal.addSubview(webView)
            
                        self.view.layoutIfNeeded()

          
                }
        //      CONDITION D'AFFICHAGE DU VISIBLE PLAYER
                else if ((CGFloat(viewY) >= (screenHeight + scrollView.contentOffset.y)) || (digitekaHeight <= scrollView.contentOffset.y))  { // View Principal 0%
                    
                    //print("VUE 0%")
                    if __position == "top_left" {
                        self.viewDidAutoPlayTopAsLeft()
                        
                    }else if __position == "top_right" {
                        self.viewDidAutoPlayTopAsRightDidScroll()
            
                    }else if __position == "bottom_left" {
                        self.viewDidAutoPlayBottomAsLeft()
                        
                    }
                    
                    self.view.layoutIfNeeded()

                }

    }
}


