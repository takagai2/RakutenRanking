//
//  ConfigViewController.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/22.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func chooseSex(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            // TODO 総合を選択したときの処理
            print("総合を選択")
        case 1:
            // TOOD 女性を選択したときの処理
            print("女性を選択")
        case 2:
            // TODO 男性を選択したときの処理
            print("男性を選択")
        default:
            // デフォルトの処理
            print("デフォルトは総合")
        }
    }
    
    @IBAction func chooseAge(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            // TODO 総合を押したときの処理
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
    
    @IBAction func cacheClearBtn() {
        // TODO キャッシュクリア処理を実装
        print("キャッシュクリアボタン押された")
    }
    
    @IBAction func favoResetBtn() {
        // TODO お気に入り全削除処理を実装
        print("お気に入りリセットボタン押された")
    }
    
}
