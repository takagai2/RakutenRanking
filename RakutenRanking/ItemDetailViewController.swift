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
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBAction func favoriteButton(_ sender: Any) {
        // お気に入り登録機能実装
        self.saveOrDeleteFavoriteItem(item: sendItem)
    }
    
    var sendItem: Item!
    let rankingManager = RankingManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.name.text = sendItem.name!
        self.price.text = "¥ " + NumberEditor.insertCommaIn(number: Int(sendItem.price)!)
        self.image.setImageWith(URL(string: sendItem.mSizeImageUrl!)!)
        self.reviewCount.text = "レビュー: " + String(sendItem.reviewCount) + "件"
        self.favoriteButton.setImage(UIImage(named: "NotFavorite"), for: .normal)
        favoriteButton.imageView?.contentMode = .scaleAspectFit
        favoriteButton.contentHorizontalAlignment = .fill
        favoriteButton.contentVerticalAlignment = .fill
        if rankingManager.isFavorite(item: sendItem) {
            favoriteButton.setImage(UIImage(named: "Favorite"), for: .normal)
        }
    }
    
    private func saveOrDeleteFavoriteItem(item: Item) {
        rankingManager.saveOrDeleteFavoriteObject(item: item)
        if self.rankingManager.isFavorite(item: item) {
            favoriteButton.setImage(UIImage(named: "Favorite"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "NotFavorite"), for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
}
