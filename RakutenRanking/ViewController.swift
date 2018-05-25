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
import SlideMenuControllerSwift

let screenSize: CGSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SlideMenuControllerDelegate {
    
    @IBOutlet weak var mainRanking: UITableView!
    
    @IBAction func showMenuView(_ sender: Any){
        self.showMenu()
    }
    
    @IBAction func showConfigView(_ sender: Any){
        self.performSegue(withIdentifier: "toConfig", sender: nil)
    }
    
    @IBAction func showFavoriteView(_ sender: Any){
        self.performSegue(withIdentifier: "toFavoriteList", sender: nil)
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
    private var rankingItemList: [Item] = []
    // segueで値を渡すための変数
    var item: Item!
    // ランキング種別を選択するための値
    var gender: Gender = Gender.notKnown
    var age: Age = Age.notKnown
    // 表示方法のタイプを数値で保持
    private var displayPattern: Int = 0
    
    // RankingManagerのインスタンス作成
    private let rankingManager = RankingManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainRanking.delegate = self
        self.mainRanking.dataSource = self
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // 設定されたランキング種別を取得
        let type = rankingManager.getRankingTypeAtStartup()
        self.gender = type.gender
        self.age = type.age
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshRanking(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            mainRanking.refreshControl = refreshControl
        } else {
            mainRanking.addSubview(refreshControl)
        }
        
        self.slideMenuController()?.delegate = self
        
        getRankingItem(gender: gender, age: age)
        // ランキングタイトルを表示
        self.navigationItem.title = "\(selectTitleByRankingType(gender, age))総合ランキング"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mainRanking.reloadData()
        self.collectionView.reloadData()
    }
    
    @objc func refreshRanking(_ sender: UIRefreshControl) {
        rankingManager.deleteData(gender: gender, age: age)
        self.getRankingItem(gender: gender, age: age, sender)
    }
    
    private func selectTitleByRankingType(_ gender: Gender, _ age: Age) -> String {
        let genderType: String
        let ageType: String
        // 性別による分類
        switch gender {
        case .male:
            genderType = "男性"
        case .female:
            genderType = "女性"
        default:
            genderType = ""
        }
        // 年代による分類
        switch age {
        case .teens:
            ageType = "10代"
        case .twenties:
            ageType = "20代"
        case .thirties:
            ageType = "30代"
        case .forties:
            ageType = "40代"
        case .fiftiesOver:
            ageType = "50代以上"
        default:
            ageType = ""
        }
        return ageType + genderType
    }
    
    // ランキングデータを取得し、配列に格納する
    private func getRankingItem(gender: Gender, age: Age, _ sender: UIRefreshControl? = nil) {
        rankingManager.getRanking(gender: gender, age: age, {[weak self](array: [Item]) -> Void in
            guard let `self` = self else { return }
            self.displayRanking(array: array)
            sender?.endRefreshing()
        })
    }
    
    private func displayRanking(array: [Item]) {
        self.rankingItemList = array
        self.mainRanking.reloadData()
        self.collectionView.reloadData()
    }
    
    private func showMenu() {
        self.slideMenuController()?.openLeft()
    }
    
    func leftDidClose() {
        if self.gender != MenuViewController.gender || self.age != MenuViewController.age {
            self.gender = MenuViewController.gender
            self.age = MenuViewController.age
            getRankingItem(gender: gender, age: age)
        }
        
        if self.displayPattern != MenuViewController.displayPattern {
            self.displayPattern = MenuViewController.displayPattern
            setRankingPattern()
        }
        // ランキングタイトルを表示
        self.navigationItem.title = "\(selectTitleByRankingType(gender, age))総合ランキング"
    }
    
    private func setRankingPattern() {
        switch displayPattern {
        case 0:
            displayListView()
        case 1:
            displayGridView()
        case 2:
            displayPageView()
        default:
            displayListView()
        }
    }
    
    private func displayListView() {
        self.mainRanking.isHidden = false
        self.collectionView.removeFromSuperview()
        self.removePageView()
    }
    
    private func displayGridView() {
        self.mainRanking.isHidden = true
        self.showGridView()
        self.removePageView()
    }
    
    private func displayPageView() {
        self.mainRanking.isHidden = true
        self.collectionView.removeFromSuperview()
        self.showPageView()
    }
    
    private func convertPrice(price: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        let convertedPrice = formatter.string(from: Int(price)! as NSNumber)!
        return convertedPrice
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
        item = self.rankingItemList[indexPath.row]
        // セルをタップした場合の処理
        cell.onTapFavoriteListener = {[weak self]() -> Void in
            guard let `self` = self else { return }
            let item = self.rankingItemList[indexPath.row]
            // お気に入り登録する / お気に入りの解除
            self.rankingManager.saveOrDeleteFavoriteObject(item: item)
            // お気に入り登録されているかどうかを判定して、ボタンに表示する画像を変更
            if self.rankingManager.isFavorite(item: item) {
                cell.favoriteButton.setImage(UIImage(named: "Favorite"), for: .normal)
            } else {
                cell.favoriteButton.setImage(UIImage(named: "NotFavorite"), for: .normal)
            }
        }
        // 起動時にセルを表示する際、お気に入りに登録されている商品はFavorite画像を表示
        if self.rankingManager.isFavorite(item: item) {
            cell.favoriteButton.setImage(UIImage(named: "Favorite"), for: .normal)
        }
        // 商品の情報に関するviewを設定
        cell.rank.text = "\(indexPath.row + 1)"
        cell.itemName.text = "\(item.name!)"
        cell.itemPrice.text = "¥ \(self.convertPrice(price: item.price!))"
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
        item = self.rankingItemList[indexPath.row]
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
        return self.rankingItemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        item = self.rankingItemList[indexPath.row]
        // セル生成時にお気に入り登録している商品はボタンの画像を変更
        if self.rankingManager.isFavorite(item: item) {
            cell.favoriteButton.setImage(UIImage(named: "Favorite"), for: .normal)
        }
        cell.itemRank.text = " \(indexPath.row + 1)位"
        // nilチェックしてからcellに代入
        if let name: String = item.name {
            cell.itemName.text = "\(name)"
        }
        if let price: String = item.price {
            cell.itemPrice.text = "¥ \(self.convertPrice(price: price))"
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
        let item = self.rankingItemList[row!]
        rankingManager.saveOrDeleteFavoriteObject(item: item)
        // お気に入り登録されているかどうかを判定して、ボタンに表示する画像を変更
        if self.rankingManager.isFavorite(item: item) {
            cell.favoriteButton.setImage(UIImage(named: "Favorite"), for: .normal)
        } else {
            cell.favoriteButton.setImage(UIImage(named: "NotFavorite"), for: .normal)
        }
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
        item = self.rankingItemList[indexPath.row]
    }
    
    private func showGridView() {
        view.addSubview(collectionView)
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshRanking(_:)), for: .valueChanged)
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }
    }

}

extension ViewController: UIScrollViewDelegate {
    
    private func setPageView() {
        // ページ数
        let page = self.rankingItemList.count
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
            let item = self.rankingItemList[i]
            // 順位のlabel生成
            let itemRank = UILabel()
            itemRank.frame = CGRect(x: CGFloat(i) * width + width/2 - 150, y: height/5, width: 300, height: 40)
            itemRank.textAlignment = .center
            itemRank.text = "\(i + 1)位"
            // 商品名のlabel生成
            let itemName: UILabel = UILabel()
            itemName.frame = CGRect(x: CGFloat(i) * width + width/2 - 150, y: height/2 + 50, width: 300, height: 80)
            itemName.textAlignment = .center
            itemName.numberOfLines = 2
            itemName.font = UIFont.systemFont(ofSize: 16, weight: .thin)
            if let name: String = item.name {
                itemName.text = "\(name)"
            }
            // 値段のlabel生成
            let itemPrice: UILabel = UILabel()
            itemPrice.frame = CGRect(x: CGFloat(i) * width + width/2 - 150, y: height/1.5, width: 300, height: 40)
            itemPrice.textAlignment = .center
            if let price: String = item.price {
                itemPrice.text = "¥ \(self.convertPrice(price: price))"
            }
            // 商品画像を表示するimageView生成
            let itemImage: UIImageView = UIImageView()
            itemImage.frame = CGRect(x: CGFloat(i) * width + width/2 - 90, y: height/3 - 10, width: 180, height: 180)
            if let image: String = item.mSizeImageUrl {
                itemImage.setImageWith(URL(string: image)!)
            }
            // お気に入り登録ボタン生成
            let favoriteButton: UIButton = UIButton()
            favoriteButton.frame = CGRect(x: CGFloat(i) * width + width/2 + 50, y: height/1.5 + 10, width: 70, height: 70)
            favoriteButton.setImage(UIImage(named: "NotFavorite"), for: .normal)
            favoriteButton.addTarget(self, action: #selector(saveToOrDeleteFromFavoritesOnPageView(_:)), for: .touchUpInside)
            
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
        // pageControlがタップされた時のアクションを追加
        pageControl.isUserInteractionEnabled = true
        pageControl.addTarget(self, action: #selector(movePageByTapping(_:)), for: .touchUpInside)
        
        self.view.addSubview(pageControl)
    }
    
    @objc func saveToOrDeleteFromFavoritesOnPageView(_ sender: UIButton) {
        let item = self.rankingItemList[pageControl.currentPage]
        rankingManager.saveOrDeleteFavoriteObject(item: item)
        
        if self.rankingManager.isFavorite(item: item) {
            sender.setImage(UIImage(named: "Favorite"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "NotFavorite"), for: .normal)
        }
    }
    
    @objc func movePageByTapping(_ sender: UIPageControl) {
        scrollView.contentOffset.x = scrollView.frame.maxX * CGFloat(sender.currentPage)
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


