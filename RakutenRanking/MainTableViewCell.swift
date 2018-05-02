//
//  MainTableViewCell.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/21.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemPrice: UILabel!
    
    @IBAction func favoriteButton(_ sender: Any) {
        self.onTapFavoriteButton()
    }
    
    var indexPath = IndexPath()
    let rankingManager = RankingManager()
    
    private func onTapFavoriteButton() {
        let item = ViewController.rankingItemList[indexPath.row]
        rankingManager.saveOrDeleteFavoriteObject(item: item)
        print(ViewController.rankingItemList[indexPath.row])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
