//
//  ConfigViewController.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/22.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController, UINavigationControllerDelegate {
    
    var genderType: Int = 0
    var ageType: Int = 0
    
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var ageSegment: UISegmentedControl!

    @IBAction func chooseSex(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            // TODO 総合を選択したときの処理
            genderType = 0
            print("総合を選択", "genderType: ", genderType)
        case 1:
            // TOOD 男性を選択したときの処理
            genderType = 1
            print("男性を選択", "genderType: ", genderType)
        case 2:
            // TODO 女性を選択したときの処理
            genderType = 2
            print("女性を選択", "genderType: ", genderType)
        default:
            // デフォルトの処理
            genderType = 0
            print("デフォルトは総合", "genderType: ", genderType)
        }
    }
    
    @IBAction func chooseAge(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            // TODO 総合を押したときの処理
            ageType = 0
            print("総合を選択", "ageType: ", ageType)
        case 1:
            // TODO 10代を選択したときの処理
            ageType = 10
            print("10代を選択", "ageType: ", ageType)
        case 2:
            // TODO 20代を選択したときの処理
            ageType = 20
            print("20代を選択", "ageType: ", ageType)
        case 3:
            // TODO 30代を選択したときの処理
            ageType = 30
            print("30代を選択", "ageType: ", ageType)
        case 4:
            // TODO 40代を選択したときの処理
            ageType = 40
            print("40代を選択", "ageType: ", ageType)
        case 5:
            // TODO 50代~を選択したときの処理
            ageType = 50
            print("50代以上を選択", "ageType: ", ageType)
        default:
            ageType = 0
            print("デフォルトは総合", "ageType: ", ageType)
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
        
        print("genderType: ", genderType, "ageType: ", ageType)
        genderSegment.selectedSegmentIndex = genderType
        ageSegment.selectedSegmentIndex = ageType / 10
        print(genderSegment.selectedSegmentIndex, ageSegment.selectedSegmentIndex)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let controller = viewController as? ViewController {
            controller.gender = genderType
            controller.age = ageType
        }
    }
    
}
