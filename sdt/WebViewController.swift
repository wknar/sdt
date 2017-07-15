//
//  PdfImageViewController.swift
//  sdt
//
//  Created by アラ 若菜 on 2017/05/07.
//  Copyright © 2017 wknar. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var ward: WardListViewController.Ward?
    var webView: WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        guard let webView = webView else {
            // TODO: show alert
            self.navigationController?.dismiss(animated: true, completion: nil)
            return
        }
        view.addSubview(webView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showPdf()
    }

    func showPdf() {
        var urlStr = ""
        if let ward = ward {
            switch ward {
            case .chiyoda:
                urlStr = "https://www.city.chiyoda.lg.jp/koho/kurashi/gomi/wakekata/documents/hayami_jp.pdf"
                break
            case .bunkyo:
                urlStr = "http://www.city.bunkyo.lg.jp/var/rev0/0131/1444/01.hozonban-002.pdf"
                break
            case .setagaya:
                urlStr = "http://www.city.setagaya.lg.jp/kurashi/101/113/260/d00131841_d/fil/20140401-5.pdf"
                break
            }
        }
        guard let url = URL(string: urlStr), let webView = webView else {
            return
        }
        webView.load(URLRequest(url: url))
    }

}
