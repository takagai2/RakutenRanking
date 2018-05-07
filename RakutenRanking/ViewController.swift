//
//  ViewController.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/12.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit
import AFNetworking
import RealmSwift

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
        self.removePageView()
    }
    
    @IBAction func changeToGrid(_ sender: Any){
        self.mainRanking.isHidden = true
        view.addSubview(collectionView)
        self.removePageView()
    }
    
    @IBAction func changeToPage(_ sender: Any){
        self.mainRanking.isHidden = true
        self.collectionView.removeFromSuperview()
        self.showPageView()
    }
    
    private let collectionView: UICollectionView = {
        //セルのレイアウト設計
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        //各々の設計に合わせて調整
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView( frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height - 44 ), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        //セルの登録
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        return collectionView
    }()
    
    var pageControl: UIPageControl!
    var scrollView: UIScrollView!
    
    // ランキングデータを格納する配列
    static var rankingItemList: [Item] = []
    // segueで値を渡すための変数
    var item: Item!
    // ランキング種別を選択するための値
    var gender: Gender = Gender.notKnown
    var age: Age = Age.notKnown
    
    // RankingManagerのインスタンス作成
    private let rankingManager = RankingManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainRanking.delegate = self
        self.mainRanking.dataSource = self
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // ランキングタイトルを表示
        self.navigationItem.title = "Ranking"
        
        // 設定されたランキング種別を取得
        let type = rankingManager.getRankingTypeAtStartup()
        self.gender = type.gender
        self.age = type.age
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getRankingItem(gender: gender, age: age)
    }
    
    // ランキングデータを取得し、配列に格納する
    private func getRankingItem(gender: Gender, age: Age) {
        rankingManager.getRanking(gender: gender, age: age, {[weak self](array: [Item]) -> Void in
            guard let `self` = self else { return }
            self.displayRanking(array: array)
        })
    }
    
     private func displayRanking(array: [Item]) {
        ViewController.rankingItemList = array
        self.mainRanking.reloadData()
        self.collectionView.reloadData()
    }
    
    // MARK: UITableViewDatasource
    
    // セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // セル数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.rankingItemList.count
    }
    
    // セル内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainRankingCell", for: indexPath) as! MainTableViewCell
        cell.indexPath = indexPath
        item = ViewController.rankingItemList[indexPath.row]
        cell.rank.text = "\(indexPath.row + 1)"
        cell.itemName.text = "\(item.name!)"
        cell.itemPrice.text = "\(item.price!)円"
        // 画像の非同期取得
        cell.itemImage.setImageWith(URL(string: item.sSizeImageUrl!)!)
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        // アイテム詳細画面を表示する
        self.performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    // アイテム詳細画面へ渡す値をcellから取得
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        item = ViewController.rankingItemList[indexPath.row]
    }
    
    // アイテム詳細画面へ遷移時、値を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toConfig" {
            let configViewController = segue.destination as! ConfigViewController
            configViewController.genderType = self.gender
            configViewController.ageType = self.age
        }
        
        if segue.identifier == "toDetail" {
            let itemDetailViewController = segue.destination as! ItemDetailViewController
            itemDetailViewController.sendItem = self.item
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // cellの個数設定
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ViewController.rankingItemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        item = ViewController.rankingItemList[indexPath.row]
        cell.itemRank.text = " \(indexPath.row + 1)位"
        // nilチェックしてからcellに代入
        if let name: String = item.name {
            cell.itemName.text = " \(name)"
        }
        if let price: String = item.price {
            cell.itemPrice.text = "\(price)円"
        }
        if let image: String = item.mSizeImageUrl {
            // 画像の非同期取得
            cell.itemImage.setImageWith(URL(string: image)!)
        }
        return cell
    }
    
    @objc func saveToOrDeleteFromFavoritesOnGridView(_ sender: Any) {
        let btn = sender as! UIButton
        let cell = btn.superview?.superview as! CollectionViewCell
        let row = collectionView.indexPath(for: cell)?.row
        rankingManager.saveOrDeleteFavoriteObject(item: ViewController.rankingItemList[row!])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 画面の横サイズの三分の一の大きさのcellサイズを指定
        return CGSize(width: screenSize.width / 3.0, height: screenSize.width / 2.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        // アイテム詳細画面を表示
        self.performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    // アイテム詳細画面へ渡す値をcellから取得
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        item = ViewController.rankingItemList[indexPath.row]
    }

}

extension ViewController: UIScrollViewDelegate {
    
    private func setPageView() {
        // ページ数
        let page = ViewController.rankingItemList.count
        // ページのサイズ
        let width = screenSize.width
        let height = screenSize.height
        
        // UIScrollViewの設定
        scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: width, height: height - 44 )
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        // scrollView全体のサイズ
        scrollView.contentSize = CGSize(width: CGFloat(page) * width, height: height - 44)
        
        self.view.addSubview(scrollView)
        
        // ページごとのlabelの生成
        for i in 0..<page {
            let item = ViewController.rankingItemList[i]
            // 順位のlabel生成
            let itemRank = UILabel()
            itemRank.frame = CGRect(x: CGFloat(i) * width + width/2 - 150, y: height/5, width: 300, height: 40)
            itemRank.textAlignment = .center
            itemRank.text = "\(i + 1)位"
            // 商品名のlabel生成
            let itemName: UILabel = UILabel()
            itemName.frame = CGRect(x: CGFloat(i) * width + width/2 - 150, y: height/2 + 50, width: 300, height: 80)
            itemName.textAlignment = .center
            if let name: String = item.name {
                itemName.text = "\(name)"
            }
            // 値段のlabel生成
            let itemPrice: UILabel = UILabel()
            itemPrice.frame = CGRect(x: CGFloat(i) * width + width/2 - 150, y: height/1.5, width: 300, height: 40)
            itemPrice.textAlignment = .center
            if let price: String = item.price {
                itemPrice.text = "\(price)円"
            }
            // 商品画像を表示するimageView生成
            let itemImage: UIImageView = UIImageView()
            itemImage.frame = CGRect(x: CGFloat(i) * width + width/2 - 90, y: height/3 - 10, width: 180, height: 180)
            if let image: String = item.mSizeImageUrl {
                itemImage.setImageWith(URL(string: image)!)
            }
            // お気に入り登録ボタン生成
            let favoriteButton: UIButton = UIButton()
            favoriteButton.frame = CGRect(x: CGFloat(i) * width + width/2 - 150, y: height/1.4, width: 270, height: 40)
            favoriteButton.contentHorizontalAlignment = .right
            favoriteButton.setTitleColor(UIColor.blue, for: .normal)
            favoriteButton.setTitle("Favo", for: UIControlState.normal)
            favoriteButton.titleLabel?.font =  UIFont.systemFont(ofSize: 16)
            
            scrollView.addSubview(itemName)
            scrollView.addSubview(itemPrice)
            scrollView.addSubview(itemRank)
            scrollView.addSubview(itemImage)
            scrollView.addSubview(favoriteButton)
        }
        
        // UIPageContolのインスタンス作成
        pageControl = UIPageControl()
        // pageControlの位置とサイズの設定
        pageControl.frame = CGRect(x: -50, y: height - 90, width: width + 100, height: 50)
        // 背景色の設定
        pageControl.backgroundColor = UIColor.darkGray
        // ページ数の設定
        pageControl.numberOfPages = page
        // 現在ページの設定
        pageControl.currentPage = 0
        // pageControlのスケールを小さくする
        pageControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        self.view.addSubview(pageControl)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // スクロール距離＝1ページ（画面幅）
        if fmod(scrollView.contentOffset.x, scrollView.frame.width) == 0 {
            // ページの切り替え（nliチェックしてからcurrentPageを設定）
            if let control: UIPageControl = pageControl {
                control.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
            }
        }
    }
    
    private func removePageView() {
        if self.scrollView != nil {
            self.scrollView.removeFromSuperview()
            self.pageControl.removeFromSuperview()
            self.scrollView = nil
        }
    }
    
    private func showPageView() {
        if self.scrollView == nil {
            self.setPageView()
        }
    }
    
}


