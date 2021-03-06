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
    static var displayPattern: Int = 0
    
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
        ViewController.displayPattern = type.pattern
        MenuViewController.gender = self.gender
        MenuViewController.age = self.age
        MenuViewController.displayPattern = ViewController.displayPattern
        
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
        self.navigationController?.navigationBar.titleTextAttributes
            = [kCTFontAttributeName: UIFont(name: "STHeitiTC-Medium", size: 15)!] as [NSAttributedStringKey : Any]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mainRanking.reloadData()
        self.collectionView.reloadData()
        self.removePageView()
        self.showPageView()
        // 画面スワイプ時に感知する左からの横幅
        SlideMenuOptions.leftBezelWidth = 200
    }
    
    @objc func refreshRanking(_ sender: UIRefreshControl) {
        rankingManager.deleteData(gender: gender, age: age)
        self.getRankingItem(gender: gender, age: age, sender)
    }
    
    private func selectTitleByRankingType(_ gender: Gender, _ age: Age) -> String {
        let genderTitle = Gender.convertGenderToString(gender: gender)
        let ageTitle = Age.convertAgeToString(age: age)
        
        return ageTitle + genderTitle
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
        self.removePageView()
        self.showPageView()
        
        setRankingPattern()
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
        if ViewController.displayPattern != MenuViewController.displayPattern {
            ViewController.displayPattern = MenuViewController.displayPattern
            setRankingPattern()
        }
        self.navigationItem.title = "\(selectTitleByRankingType(gender, age))総合ランキング"
    }
    
    private func setRankingPattern() {
        switch ViewController.displayPattern {
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
        self.collectionView.isHidden = true
        self.removePageView()
    }
    
    private func displayGridView() {
        self.mainRanking.isHidden = true
        if self.collectionView.isDescendant(of: view) == false {
            self.showGridView()
        }
        self.collectionView.isHidden = false
        self.removePageView()
    }
    
    private func displayPageView() {
        self.mainRanking.isHidden = true
        self.collectionView.isHidden = true
        self.showPageView()
    }
    
    private func selectIcon(rank: Int) -> UIImage? {
        switch rank {
        case 1:
            return UIImage(named: "No.1")!
        case 2:
            return UIImage(named: "No.2")!
        case 3:
            return UIImage(named: "No.3")!
        default:
            return nil
        }
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
        cell.itemPrice.text = "¥ " + NumberEditor.insertCommaIn(number: Int(item.price)!)
        // 画像の非同期取得
        cell.itemImage.setImageWith(URL(string: item.sSizeImageUrl!)!)
        // アイコン画像を設定
        cell.rankImage.image = self.selectIcon(rank: indexPath.row + 1)
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
        cell.itemRank.text = "\(indexPath.row + 1)"
        // nilチェックしてからcellに代入
        if let name: String = item.name {
            cell.itemName.text = "\(name)"
        }
        if let price: String = item.price {
            cell.itemPrice.text = "¥ " + NumberEditor.insertCommaIn(number: Int(price)!)
        }
        if let image: String = item.mSizeImageUrl {
            // 画像の非同期取得
            cell.itemImage.setImageWith(URL(string: image)!)
        }
        // アイコン画像の設定
        cell.rankImage.image = self.selectIcon(rank: indexPath.row + 1)
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
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        // scrollView全体のサイズ
        scrollView.contentSize = CGSize(width: CGFloat(page) * width, height: height - 44)
        
        self.view.addSubview(scrollView)
        
        // ページごとのlabelの生成
        for i in 0..<page {
            let item = self.rankingItemList[i]
            // １位から３位までのアイコン画像生成
            let rankImage: UIImageView = UIImageView()
            rankImage.frame = CGRect(x: CGFloat(i) * width + width/2 - 120, y: height/5 + 10, width: 40, height: 40)
            rankImage.image = self.selectIcon(rank: i + 1)
            // 順位のlabel生成
            let itemRank = UILabel()
            itemRank.frame = CGRect(x: CGFloat(i) * width + width/2 - 120, y: height/5 + 15, width: 40, height: 40)
            itemRank.textAlignment = .center
            itemRank.font = UIFont(name: "Gill Sans", size: 22)
            if rankImage.image == nil {
                itemRank.backgroundColor = UIColor.lightGray.withAlphaComponent(0.50)
                itemRank.layer.cornerRadius = 20
                itemRank.clipsToBounds = true
            }
            itemRank.text = "\(i + 1)"
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
                itemPrice.text = "¥ " + NumberEditor.insertCommaIn(number: Int(price)!)
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
            favoriteButton.addTarget(self, action: #selector(saveToOrDeleteFromFavoritesOnPageView(_:)), for: .touchUpInside)
            favoriteButton.setImage(UIImage(named: "NotFavorite"), for: .normal)
            if self.rankingManager.isFavorite(item: item) {
                favoriteButton.setImage(UIImage(named: "Favorite"), for: .normal)
            }
            
            scrollView.addSubview(rankImage)
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
        // インジケータの色
        let rgba = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        pageControl.pageIndicatorTintColor = rgba
        // 現在ページのインジケータの色
        pageControl.currentPageIndicatorTintColor = .gray
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
        if mainRanking.isHidden == true && collectionView.isHidden == true {
            if self.scrollView == nil {
                self.setPageView()
            }
        }
    }
    
}


