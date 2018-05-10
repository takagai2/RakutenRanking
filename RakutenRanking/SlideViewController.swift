//
//  SlideViewController.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/05/10.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation
import SlideMenuControllerSwift

class SlideViewController: SlideMenuController, SlideMenuControllerDelegate {
    
    override func viewDidLoad() {
        // メニューの横幅
        SlideMenuOptions.leftViewWidth = 320
        // 画面スワイプ時に感知する左からの横幅
        SlideMenuOptions.leftBezelWidth = 20.0
        // メニューを開いた時のViewControllerの縮小率
        SlideMenuOptions.contentViewScale = 1
        // メニューを開いた時にViewControllerをメニューのwidth分ずらす
        SlideMenuOptions.contentViewDrag = true
        // メニューを表示する速度
        SlideMenuOptions.animationDuration = 0.2
        
        super.viewDidLoad()
        self.slideMenuController()?.delegate = self
    }
}
