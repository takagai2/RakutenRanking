//
//  MenuViewController.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/22.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var menuRanking: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBAction func chooseAge(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            // TODO 総合を選択したときの処理
            print("総合を選択")
        case 1:
            // TODO 10代を選択したときの処理
            print("10代を選択")
        case 2:
            // TODO 20代を選択したときの処理
            print("20代を選択")
        case 3:
            // TODO 30代を選択したときの処理
            print("30代を選択")
        case 4:
            // TODO 40代を選択したときの処理
            print("40代を選択")
        case 5:
            // TODO 50代~を選択したときの処理
            print("50代以上を選択")
        default:
            print("デフォルトは総合")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
    }
    
    // スクロール停止時に呼び出される
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // ページコントロールに現在のページ番号を設定
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
