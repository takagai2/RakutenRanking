//
//  MenuViewController.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/22.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuRanking: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuRanking.delegate = self
        self.menuRanking.dataSource = self
    }
    
    // セル表示用のテストデータ
    let rankingList = ["1位の商品名", "2位の商品名", "3位の商品名", "4位の商品名", "5位の商品名", "6位の商品名", "7位の商品名", "8位の商品名", "9位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名"]
    
    // MARK: UITableViewDataSource
    
    // セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // セル数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rankingList.count
    }
    
    // セル内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuRankingCell", for: indexPath) as! MenuTableViewCell
        
        cell.rank.text = String(indexPath.row + 1)
        cell.itemName.text = self.rankingList[indexPath.row]
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: 各商品の詳細ページに遷移させる
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
