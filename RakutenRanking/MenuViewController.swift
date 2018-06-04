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
    private let sections = ["  性別 で絞り込む", "  年齢 で絞り込む", "  表示方法 を選ぶ"]
    
    // 選択されたランキング種別を保持する
    static var gender: Gender = .notKnown
    static var age: Age = .notKnown
    // ランキング表示方法の変更を保持する
    static var displayPattern: Int = 0
    // チェックマークの有無を保持する
    var checkMarks = [false, false, false, false, false]
    private var selectedCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuList.delegate = self
        self.menuList.dataSource = self
        // セクションの高さを変更
        menuList.sectionHeaderHeight = 50
        menuList.backgroundColor = .darkGray
        // タイトルを設定
        self.navigationItem.title = "M E N U"
        // タイトルのフォント、サイズ、色を指定
        self.navigationController?.navigationBar.titleTextAttributes
            = [NSAttributedStringKey.font: UIFont(name: "Gill Sans", size: 22)!, NSAttributedStringKey.foregroundColor : UIColor.white]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 起動時に表示する種別が総合でない場合は、該当の条件に予めチェックを入れておく
        checkedRankingType(gender: MenuViewController.gender, age: MenuViewController.age)
        // リスト表示の行に予めチェックを入れておく
        checkedDisplayPattern()
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
    
    // この関数内でセクションの設定を行う
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label : UILabel = UILabel()
        label.backgroundColor = .darkGray
        label.textColor = .lightGray
        label.text = sections[section]
        label.font = UIFont(name: "STHeitiTC-Medium", size: 16)
        return label
    }
    
    // セル内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuTableViewCell
        cell.backgroundColor = .darkGray
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
        selectedCell = tableView.cellForRow(at: indexPath)
        
        // タップされたセルにチェックマークをつけて変数に設定を保持する
        changeRankingType(indexPath: indexPath)
    }
    
    private func changeRankingType(indexPath: IndexPath) {
        if selectedCell == menuList.cellForRow(at: indexPath) {
            if selectedCell.accessoryType == .none {
                selectedCell.accessoryType = .checkmark
                // チェックマークをつけた動作をセクション毎に変更する
                switch indexPath.section {
                case 0:
                    MenuViewController.gender = Gender.setGenderByIndex(index: indexPath.row)
                case 1:
                    MenuViewController.age = Age.setAgeByIndex(index: indexPath.row)
                case 2:
                    MenuViewController.displayPattern = indexPath.row
                default:
                    break
                }
                checkMarks = checkMarks.enumerated().flatMap { (elem: (Int, Bool)) -> Bool in
                    if indexPath.row != elem.0 {
                        let otherCellIndexPath = NSIndexPath(row: elem.0, section: indexPath.section)
                        if let otherCell = menuList.cellForRow(at: otherCellIndexPath as IndexPath) {
                            otherCell.accessoryType = .none
                        }
                    }
                    return indexPath.row == elem.0
                }
            } else {
                // チェックマークがついている行をタップした際の動作をセクション毎に変更する
                switch indexPath.section {
                case 0:
                    selectedCell.accessoryType = .none
                    MenuViewController.gender = .notKnown
                case 1:
                    selectedCell.accessoryType = .none
                    MenuViewController.age = .notKnown
                default:
                    break
                }
            }
        }
    }

    private func checkedDisplayPattern() {
        let indexPath = NSIndexPath(row: MenuViewController.displayPattern, section: 2)
        if let myCell = menuList.cellForRow(at: indexPath as IndexPath) {
            myCell.accessoryType = .checkmark
        }
    }
    
    private func checkedRankingType(gender: Gender, age: Age) {
        if gender != .notKnown {
            let indexPath = NSIndexPath(row: Gender.convertGenderToInt(gender: gender)!, section: 0)
            if let myCell = menuList.cellForRow(at: indexPath as IndexPath) {
                myCell.accessoryType = .checkmark
            }
        }
        if age != .notKnown {
            let indexPath = NSIndexPath(row: Age.convertAgeToInt(age: age)!, section: 1)
            if let myCell = menuList.cellForRow(at: indexPath as IndexPath) {
                myCell.accessoryType = .checkmark
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
