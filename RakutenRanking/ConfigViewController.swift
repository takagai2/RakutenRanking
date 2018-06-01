//
//  ConfigViewController.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/22.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController, UINavigationControllerDelegate {
    
    var genderType: Gender = Gender.notKnown
    var ageType: Age = Age.notKnown
    
    let rankingManager = RankingManager()
    
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var ageSegment: UISegmentedControl!

    @IBAction func chooseGender(_ sender: UISegmentedControl) {
        genderType = Gender.setGenderBySelectedNum(num: sender.selectedSegmentIndex)
    }
    
    @IBAction func chooseAge(_ sender: UISegmentedControl) {
        ageType = Age.getAgeBySelectedNum(num: sender.selectedSegmentIndex)
    }
    
    @IBAction func saveSettings(_ sender: Any) {
        // 選択した条件をアプリ起動時のランキングに反映させる
        rankingManager.saveRankingTypeAtStartup(gender: self.genderType, age: self.ageType, pattern: ViewController.displayPattern)
    }
    
    @IBAction func cacheClearBtn() {
        // キャッシュクリア処理を実装
        rankingManager.deleteAllData()
    }
    
    @IBAction func favoResetBtn() {
        // お気に入り全削除処理を実装
        rankingManager.deleteAllFavoriteItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
        
        // 前回設定した条件によって選択状態にするセグメントのボタンを変更する
        if genderType != Gender.notKnown {
            genderSegment.selectedSegmentIndex = genderType.rawValue
        }
        if ageType != Age.notKnown {
            ageSegment.selectedSegmentIndex = ageType.rawValue / 10
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "設定画面"
        self.navigationController?.navigationBar.titleTextAttributes
            = [kCTFontAttributeName: UIFont(name: "STHeitiTC-Medium", size: 15)!] as [NSAttributedStringKey : Any]
    }
}
