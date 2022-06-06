//
//  PlayerWebViewController.swift
//  API_table
//
//  Created by MacBook Air on 2022/06/06.
//

import UIKit
import WebKit

class PlayerWebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var playerName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = playerName
        let urlKorString = "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=" + playerName
        let urlString = urlKorString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
