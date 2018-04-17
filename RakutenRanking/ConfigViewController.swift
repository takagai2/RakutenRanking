//
//  ConfigViewController.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/22.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController, UINavigationControllerDelegate {
    
    var genderType: Gender? = nil
    var ageType: Age? = nil
    
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var ageSegment: UISegmentedControl!

    @IBAction func chooseGender(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            // TODO 総合を選択したときの処理
            genderType = nil
            print("総合を選択", "genderType: ", genderType as Any)
        case 1:
            // TOOD 男性を選択したときの処理
            genderType = getGenderBySelectNum(num: 1)
            print("男性を選択", "genderType: ", genderType!)
        case 2:
            // TODO 女性を選択したときの処理
            genderType = getGenderBySelectNum(num: 2)
            print("女性を選択", "genderType: ", genderType!)
        default:
            // デフォルトの処理
            genderType = nil
            print("デフォルトは総合", "genderType: ", genderType as Any)
        }
    }
    
    @IBAction func chooseAge(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            // TODO 総合を押したときの処理a
            ageType = nil
            print("総合を選択", "ageType: ", ageType as Any)
        case 1:
            // TODO 10代を選択したときの処理
            ageType = getAgeBySelectNum(num: 1)
            print("10代を選択", "ageType: ", ageType!)
        case 2:
            // TODO 20代を選択したときの処理
            ageType = getAgeBySelectNum(num: 2)
            print("20代を選択", "ageType: ", ageType!)
        case 3:
            // TODO 30代を選択したときの処理
            ageType = getAgeBySelectNum(num: 3)
            print("30代を選択", "ageType: ", ageType!)
        case 4:
            // TODO 40代を選択したときの処理
            ageType = getAgeBySelectNum(num: 4)
            print("40代を選択", "ageType: ", ageType!)
        case 5:
            // TODO 50代~を選択したときの処理
            ageType = getAgeBySelectNum(num: 5)
            print("50代以上を選択", "ageType: ", ageType!)
        default:
            ageType = nil
            print("デフォルトは総合", "ageType: ", ageType as Any)
        }
    }
    
    @IBAction func cacheClearBtn() {
        // TODO キャッシュクリア処理を実装
        print("キャッシュクリアボタン押された")
    }
    
    @IBAction func favoResetBtn() {
        // TODO お気に入り全削除処理を実装
        print("お気に入りリセットボタン押された")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
        
        // 前回設定した条件によって選択状態にするセグメントのボタンを変更する
        if genderType != nil && ageType != nil {
            genderSegment.selectedSegmentIndex = genderType!.rawValue + 1
            ageSegment.selectedSegmentIndex = ageType!.rawValue / 10
            print(genderSegment.selectedSegmentIndex, ageSegment.selectedSegmentIndex)
        } else if ageType != nil {
            ageSegment.selectedSegmentIndex = ageType!.rawValue / 10
        } else if genderType != nil {
            genderSegment.selectedSegmentIndex = genderType!.rawValue + 1
        }
    }
    
    func getGenderBySelectNum(num: Int) -> Gender? {
        switch num {
        case 1:
            return Gender.male
        case 2:
            return Gender.female
        default:
            return nil
        }
    }
    
    func getAgeBySelectNum(num: Int) -> Age? {
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
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let controller = viewController as? ViewController {
            controller.gender = genderType
            controller.age = ageType
        }
    }
    
}
