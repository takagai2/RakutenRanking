//
//  FavoriteList.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/22.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit
import AFNetworking

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var favoriteList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.favoriteList.delegate = self
        self.favoriteList.dataSource = self
        self.navigationItem.title = "お気に入りリスト"
        self.getFavoriteItem()
    }
    
    private let rankingManager = RankingManager()
    private var favoriteItem = [Item]()
    
    private func getFavoriteItem() {
        rankingManager.getFavoriteItem({[weak self](items: [Item]) -> Void in
            guard let `self` = self else { return }
            self.favoriteItem = items
            print(self.favoriteItem)
        })
    }
    
    // MARK: UITableViewDataSource
    
    // セクション数
    func tableView(_ tableView: UITableView) -> Int {
        return 1
    }
    
    // セル数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteItem.count
    }
    
    // セル内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"FavoriteListCell", for: indexPath) as! FavoriteTableViewCell
        let item = self.favoriteItem[indexPath.row]
        if let name: String = item.name {
            cell.itemName.text = "\(name)"
        }
        if let price: String = item.price {
            cell.itemPrice.text = "\(price)円"
        }
        if let image: String = item.sSizeImageUrl {
            cell.itemImage.setImageWith(URL(string: image)!)
        }
        return cell
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO タップ時のアクションを記述
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
