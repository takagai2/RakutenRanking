//
//  ItemDetailViewController.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/04/06.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit

class ItemDetailViewController: UIViewController {
    
    @IBOutlet weak var name: String!
    @IBOutlet weak var price: String!
    @IBOutlet weak var image: UIImageView!
    
    @IBAction func favoButton(_ sender: Any) {
        // TODO: お気に入り登録機能
    }
    
    // TODO: 各商品のデータを取得して表示

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
}
