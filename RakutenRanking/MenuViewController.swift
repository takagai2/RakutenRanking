//
//  MenuViewController.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/22.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuList: UITableView!
    
    // テーブルのデータに使う配列
    private let genderType = ["男性", "女性"]
    private let ageType = ["10代", "20代", "30代", "40代", "50代 以上"]
    private let displayType = ["リスト表示", "グリッド表示", "ページ表示"]
    // セクションに使う配列
    private let sections = ["性別 で絞り込む", "年齢 で絞り込む", "表示方法 を選ぶ"]
    
    // 選択されたランキング種別を保持する
    static var gender: Gender = .notKnown
    static var age: Age = .notKnown
    // ランキング表示方法の変更を保持する
    static var displayPattern: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuList.delegate = self
        self.menuList.dataSource = self
    }
    
    // MARK: UITableViewDataSource
    
    // セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    // セクションのタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    // 各セクションのセル数
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
            cell.menuList.text = genderType[indexPath.row]
        case 1:
            cell.menuList.text = ageType[indexPath.row]
        case 2:
            cell.menuList.text = displayType[indexPath.row]
        default:
            cell.menuList.text = ""
        }
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    // cellが選択された時に呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuList.deselectRow(at: indexPath, animated: true)
        // タップされたセルを取得して変数に設定を保持する
        switch indexPath.section {
        case 0:
            self.setGender(index: indexPath.row)
        case 1:
            self.setAge(index: indexPath.row)
        case 2:
            MenuViewController.displayPattern = indexPath.row
        default:
            break
        }
    }
    
    private func setGender(index: Int) {
        switch index {
        case 0:
            MenuViewController.gender = .male
        case 1:
            MenuViewController.gender = .female
        default:
            MenuViewController.gender = .notKnown
        }
    }
    
    private func setAge(index: Int) {
        switch index {
        case 0:
            MenuViewController.age = .teens
        case 1:
            MenuViewController.age = .twenties
        case 2:
            MenuViewController.age = .thirties
        case 3:
            MenuViewController.age = .forties
        case 4:
            MenuViewController.age = .fiftiesOver
        default:
            MenuViewController.age = .notKnown
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
