//
//  ViewController.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/12.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mainRanking: UITableView!
    
    @IBAction func showMenuView(_ sender: Any){
        self.performSegue(withIdentifier: "toMenu", sender: nil)
    }
    
    @IBAction func showConfigView(_ sender: Any){
        self.performSegue(withIdentifier: "toConfig", sender: nil)
    }
    
    @IBAction func showFavoriteView(_ sender: Any){
        self.performSegue(withIdentifier: "toFavoriteList", sender: nil)
    }
    
    let rankingList = ["1位の商品名", "2位の商品名", "3位の商品名", "4位の商品名", "5位の商品名", "6位の商品名", "7位の商品名", "8位の商品名", "9位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainRanking.delegate = self
        self.mainRanking.dataSource = self
        
        // ランキングタイトルを表示
        self.navigationItem.title = "Ranking"
    }
    
    // MARK: UITableViewDatasource
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainRankingCell", for: indexPath) as! MainTableViewCell

        cell.rank.text = String(indexPath.row + 1)
        cell.itemName.text = self.rankingList[indexPath.row]
        return cell
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO タップ時のアクションを記述
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

