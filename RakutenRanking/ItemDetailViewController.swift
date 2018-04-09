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
    
    @IBAction func favoriteButton(_ sender: Any) {
        // TODO: お気に入り登録機能実装
        print("favoriteButton押された")
    }
    
    var sendItem: Item!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.name.text = sendItem.name!
        self.price.text = sendItem.price!
        self.image.setImageWith(URL(string: sendItem.mSizeImageUrl!)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
}
