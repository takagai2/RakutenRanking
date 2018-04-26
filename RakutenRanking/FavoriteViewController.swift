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
    
    @IBAction func sortFavoriteList(_ sender: UISegmentedControl) {
        sortItem(index: sender.selectedSegmentIndex)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.favoriteList.delegate = self
        self.favoriteList.dataSource = self
        self.navigationItem.title = "お気に入りリスト"
        self.getFavoriteItem()
        array = favoriteItem
    }
    
    private let rankingManager = RankingManager()
    private var favoriteItem = [Item]()
    private var array = [Item]()
    var item: Item!
    
    private func getFavoriteItem() {
        rankingManager.getFavoriteItem({[weak self](items: [Item]) -> Void in
            guard let `self` = self else { return }
            self.favoriteItem = items
        })
    }
    
    // MARK: UITableViewDataSource
    
    // セクション数
    func tableView(_ tableView: UITableView) -> Int {
        return 1
    }
    
    // セル数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.array.count
    }
    
    // セル内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"FavoriteListCell", for: indexPath) as! FavoriteTableViewCell
        item = self.array[indexPath.row]
        if let name: String = item.name {
            cell.itemName.text = "\(name)"
        }
        if let price: String = item.price {
            cell.itemPrice.text = "\(price)円"
        }
        if let reviewCount: Int = item.reviewCount {
            cell.itemReviewCount.text = "\(reviewCount)件のレビュー"
        }
        if let image: String = item.sSizeImageUrl {
            cell.itemImage.setImageWith(URL(string: image)!)
        }
        return cell
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 商品詳細画面へ遷移
        self.performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    // タップしたcellの値を取得
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        item = self.favoriteItem[indexPath.row]
    }
    
    // segmentedControlの選択によってfavoriteItemを並べ替える
    func sortItem(index: Int) {
        switch index {
        case 0:
            array = favoriteItem
            favoriteList.reloadData()
        case 1:
            array = favoriteItem.reversed()
            favoriteList.reloadData()
        case 2:
            array.sort(by: {$0.reviewCount > $1.reviewCount})
            favoriteList.reloadData()
        default:
            array = favoriteItem
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let itemDetailViewController = segue.destination as! ItemDetailViewController
            itemDetailViewController.sendItem = self.item
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
