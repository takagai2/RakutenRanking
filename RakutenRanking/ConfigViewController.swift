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
        genderType = getGenderBySelectNum(num: sender.selectedSegmentIndex)
    }
    
    @IBAction func chooseAge(_ sender: UISegmentedControl) {
        ageType = getAgeBySelectNum(num: sender.selectedSegmentIndex)
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
