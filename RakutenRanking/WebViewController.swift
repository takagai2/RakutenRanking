//
//  WebViewController.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/22.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var itemPage: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 表示するWebページのURLを指定
        let url = URL(string: "https://books.rakuten.co.jp/rb/15404535/?l2-id=Ranking_PC_top-0-day_rnkRankingMain&s-id=Ranking_PC_top-0-day_rnkRankingMain_1")
        let urlRequest = URLRequest(url: url!)
        
        // Webページの読み込みを開始
        itemPage.load(urlRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
