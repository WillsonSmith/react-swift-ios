//
//  ViewController.swift
//  Swift iOS web hybrid template
//
//  Created by Willson Smith on 2015-11-20.
//  Copyright © 2015 Willson Smith. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler, WKUIDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        let contentController = WKUserContentController();
        contentController.add(self, name: "callbackHandler");

        let config = WKWebViewConfiguration();
        config.userContentController = contentController;
        
        webView = WKWebView(frame: UIScreen.main.bounds, configuration: config);
        webView!.uiDelegate = self;
        view = webView;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
//        let url = Bundle.main.url(forResource: "index", withExtension:"html", subdirectory: "react-swift-webview/build");
//        self.webView!.loadFileURL(url!, allowingReadAccessTo: url!);

        let url = URL(string: "http://localhost:3000")! as URL;
        print(URLRequest(url: url));
        self.webView!.load(URLRequest(url: url));
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

        if let messageBody:NSDictionary = message.body as? NSDictionary {
            let functionToRun = String(describing: messageBody.value(forKey: "functionToRun")!);
            let promiseId = String(describing: messageBody.value(forKey: "promiseId")!);
            let prefix = String(describing: messageBody.value(forKey: "prefix")!);

            switch(functionToRun) {
                case "getCurrentVersion":
                    getCurrentVersion(promiseId: promiseId, prefix: prefix);
                default:
                    return {}();
            }
        }
        
    }

    func executeJavascript(_ functionToRun:String, arguments:Array<String>?) {
        var function:String;
        var args:String;
        
        if (arguments != nil) {
            args = arguments!.joined(separator: ", ");
        } else {
            args = "";
        }
        
        function = "\(functionToRun)(\(args))";
        self.webView!.evaluateJavaScript(function, completionHandler: handleJavascriptCompletion as? (Any?, Error?) -> Void);
    }
    
    func currentVersion(prefix: String?) -> String {
        return "'\(prefix ?? "")1.0.0'";
    }
    
    func getCurrentVersion(promiseId: String, prefix: String) {
        executeJavascript("resolvePromise", arguments: [promiseId, currentVersion(prefix: prefix)]);
    }
    
    func handleJavascriptCompletion(object:AnyObject?, error:NSError?) -> Void {
        if (error != nil) {
            print(error ?? "");
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
}
