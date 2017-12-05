//
//  ViewController.swift
//  Swift iOS web hybrid template
//
//  Created by Willson Smith on 2015-11-20.
//  Copyright © 2015 Willson Smith. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler {

    var webView: WKWebView?
    
    override func loadView() {
        let contentController = WKUserContentController();
        contentController.add(self, name: "callbackHandler");

        let config = WKWebViewConfiguration();
        config.userContentController = contentController;
        
        webView = WKWebView(frame: UIScreen.main.bounds, configuration: config)

        view = webView;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let url = Bundle.main.url(forResource: "index", withExtension:"html");
        self.webView!.loadFileURL(url!, allowingReadAccessTo: url!);
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

        if let messageBody:NSDictionary = message.body as? NSDictionary {
            let functionToRun = String(describing: messageBody.value(forKey: "functionToRun")!);
            switch(functionToRun) {
                case "getCurrentVersion":
                    getCurrentVersion();
                default:
                    return {}();
            }
        }
        
    }

    func executeJavascript(functionToRun:String, argument:String?) {
        var functionName:String;
        var arg:String;
        if ((argument) != nil) {
            arg = argument!;
        } else {
            arg = "";
        }
        
        functionName = "\(functionToRun)('\(arg)')";
        self.webView!.evaluateJavaScript(functionName, completionHandler: handleJavascriptCompletion as? (Any?, Error?) -> Void);
    }
    
    func currentVersion() -> String {
        return "Swift iOS web hybrid template 1.0.0";
    }
    
    func getCurrentVersion() {
        executeJavascript(functionToRun: "addVersion", argument:currentVersion())
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
