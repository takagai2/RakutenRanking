//
//  ViewController.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/12.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit

let screenSize: CGSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)

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
    
    @IBAction func changeToList(_ sender: Any){
        self.mainRanking.isHidden = false
        self.collectionView.removeFromSuperview()
    }
    
    @IBAction func changeToGrid(_ sender: Any){
        self.mainRanking.isHidden = true
        view.addSubview(collectionView)
    }
    
    let rankingList = ["1位の商品名", "2位の商品名", "3位の商品名", "4位の商品名", "5位の商品名", "6位の商品名", "7位の商品名", "8位の商品名", "9位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名"]
    
    private let collectionView: UICollectionView = {
        //セルのレイアウト設計
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        //各々の設計に合わせて調整
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView( frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height - 100 ), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        //セルの登録
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainRanking.delegate = self
        self.mainRanking.dataSource = self
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        //        view.addSubview(collectionView)
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
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO 各商品ページを表示する
        self.performSegue(withIdentifier: "toItemPage", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // cellの個数設定
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rankingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        let cellText = rankingList[indexPath.item]
        cell.setupContents(textName: cellText)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 画面の横サイズの三分の一の大きさのcellサイズを指定
        return CGSize(width: screenSize.width / 3.0, height: screenSize.width / 3.0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        print("cocollectionViewのセル押された")
    }

}

