//
//  ItemDetailViewController.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/04/06.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit
import AFNetworking

class ItemDetailViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var reviewCount: UILabel!
    
    @IBAction func favoriteButton(_ sender: Any) {
        // お気に入り登録機能実装
        self.saveOrDeleteFavoriteItem(item: sendItem)
    }
    
    var sendItem: Item!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.name.text = sendItem.name!
        self.price.text = "¥ " + ViewController.convertPrice(price: sendItem.price!)
        self.image.setImageWith(URL(string: sendItem.mSizeImageUrl!)!)
        self.reviewCount.text = "レビュー: " + String(sendItem.reviewCount) + "件"
    }
    
    private func saveOrDeleteFavoriteItem(item: Item) {
        let rankingManager = RankingManager()
        rankingManager.saveOrDeleteFavoriteObject(item: item)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
}
