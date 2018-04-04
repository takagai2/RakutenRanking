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
        self.setPageView()
    }
    
    let rankingList = ["1位の商品名", "2位の商品名", "3位の商品名", "4位の商品名", "5位の商品名", "6位の商品名", "7位の商品名", "8位の商品名", "9位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名", "10位の商品名"]
    
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
    
    var pageControl: UIPageControl! = nil
    var scrollView: UIScrollView!
    
    // ランキングデータを格納する配列
    var rankingItemList: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainRanking.delegate = self
        self.mainRanking.dataSource = self
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // ランキングタイトルを表示
        self.navigationItem.title = "Ranking"
        
        getRankingItem()
    }
    
    // ランキングデータを取得し、配列に格納する
    func getRankingItem() {
        let rankingManager = RankingManager()
        // TODO: セグメントで選択された結果によって、呼び出す関数を変更する処理
        rankingManager.getOverallRanking()
        rankingItemList = rankingManager.itemArray
    }
    
    // MARK: UITableViewDatasource
    
    // セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // セル数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rankingItemList.count
    }
    
    // セル内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainRankingCell", for: indexPath) as! MainTableViewCell

        cell.rank.text = String(indexPath.row + 1)
        cell.itemName.text = "\(self.rankingItemList[indexPath.row])"
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO 各商品ページを表示する
        self.performSegue(withIdentifier: "toItemPage", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // cellの個数設定
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rankingList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        let cellText = "\(rankingItemList[indexPath.item])"
        cell.setupContents(textName: cellText)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 画面の横サイズの三分の一の大きさのcellサイズを指定
        return CGSize(width: screenSize.width / 3.0, height: screenSize.width / 3.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cocollectionViewのセル押された")
    }

}

extension ViewController: UIScrollViewDelegate {
    
    func setPageView() {
        // ページ数
        let page = rankingItemList.count
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
        
        // TODO: ページごとのlabelの生成
        for i in 0..<page {
            let label: UILabel = UILabel()
            label.frame = CGRect(x: CGFloat(i) * width + width/2 - 60, y: height/2 - 40, width: 120, height: 80)
            label.textAlignment = NSTextAlignment.center
            label.text = "\(i + 1)位"
            scrollView.addSubview(label)
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
        // TODO: pageControlのタップに夜ページ移動を実装
        
        self.view.addSubview(pageControl)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // スクロール距離＝1ページ（画面幅）
        if fmod(scrollView.contentOffset.x, scrollView.frame.width) == 0 {
            // ページの切り替え
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        }
    }
    
    func removePageView() {
        if self.scrollView != nil {
            self.scrollView.removeFromSuperview()
            self.pageControl.removeFromSuperview()
        } else {
            print("pageViewはnil")
        }
    }
    
}


