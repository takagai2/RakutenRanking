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
    
    // テーブルのデータに使う配列
    private let genderType = ["男性", "女性"]
    private let ageType = ["10代", "20代", "30代", "40代", "50代 以上"]
    private let displayType = ["リスト表示", "グリッド表示", "ページ表示"]
    // セクションに使う配列
    private let sections = ["性別 で絞り込む", "年齢 で絞り込む", "表示方法 を選ぶ"]
    
    // MARK: UITableViewDataSource
    
    // セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    // セクションのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    // cellが選択された時に呼ばれる
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print("Value: \(genderType[indexPath.row])")
        case 1:
            print("Value: \(ageType[indexPath.row])")
        case 2:
            print("Value: \(displayType[indexPath.row])")
        default:
            print("Value: nil")
        }
    }
    
    // セル数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return genderType.count
        case 1:
            return ageType.count
        case 2:
            return displayType.count
        default:
            return 0
        }
    }
    
    // セル内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.rankingType.text = genderType[indexPath.row]
        case 1:
            cell.rankingType.text = ageType[indexPath.row]
        case 2:
            cell.rankingType.text = displayType[indexPath.row]
        default:
            cell.rankingType.text = ""
        }
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: ランキング種別の絞り込みを設定したら、表示するランキングを変更する
        // TODO: 表示設定の切り替えをしたら、表示方法を変更する
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
