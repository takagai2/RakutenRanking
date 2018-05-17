//
//  ConfigViewController.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/22.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class ConfigViewController: UIViewController, UINavigationControllerDelegate {
    
    var genderType: Gender = Gender.notKnown
    var ageType: Age = Age.notKnown
    
    let rankingManager = RankingManager()
    
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var ageSegment: UISegmentedControl!

    @IBAction func chooseGender(_ sender: UISegmentedControl) {
        genderType = getGenderBySelectNum(num: sender.selectedSegmentIndex)
    }
    
    @IBAction func chooseAge(_ sender: UISegmentedControl) {
        ageType = getAgeBySelectNum(num: sender.selectedSegmentIndex)
    }
    
    @IBAction func saveSettings(_ sender: Any) {
        // 選択した条件をアプリ起動時のランキングに反映させる
        rankingManager.saveRankingTypeAtStartup(gender: self.genderType, age: self.ageType)
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
    
    private func getGenderBySelectNum(num: Int) -> Gender {
        switch num {
        case 1:
            return Gender.male
        case 2:
            return Gender.female
        default:
            return Gender.notKnown
        }
    }
    
    private func getAgeBySelectNum(num: Int) -> Age {
        switch num {
        case 1:
            return Age.teens
        case 2:
            return Age.twenties
        case 3:
            return Age.thirties
        case 4:
            return Age.forties
        case 5:
            return Age.fiftiesOver
        default:
            return Age.notKnown
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let controller = viewController as? ViewController {
            controller.gender = genderType
            controller.age = ageType
        }
    }
    
}
