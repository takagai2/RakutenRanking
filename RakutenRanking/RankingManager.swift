//
//  RankingManager.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/28.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation

enum Gender: Int {
    
    case notKnown = 0
    case male = 1
    case female = 2
}

enum Age: Int {
    
    case notKnown = 0
    case teens = 10
    case twenties = 20
    case thirties = 30
    case forties = 40
    case fiftiesOver = 50
}

class RankingManager {
    
    private let rankingGateway: RankingGatewayProtocol = RankingGateway()
    private let dataGateway: DataGatewayProtocol = DataGateway()
    
    // ランキングを取得
    func getRanking(gender: Gender, age: Age, _ callback: @escaping ([Item]) -> Void) {
        // Realmから呼び出す処理
        self.dataGateway.getItems(gender: gender, age: age, {[weak self](items: [Item]) -> Void in
            guard let `self` = self else { return }
            // Realmに保存されていなければapi取得
            if items.isEmpty {
                self.rankingGateway.getRankingRes(gender: gender, age: age, {[weak self](array: [Item]) -> Void in
                    guard let `self` = self else { return }
                    // arrayをRealmに保存する処理
                    self.dataGateway.saveItems(gender: gender, age: age, array: array)
                    // XXXViewControllerにItemを渡す処理
                    callback(array)
                })
            } else {
                callback(items)
            }
        })
    }
    
    func deleteData() {
        dataGateway.deleteDataObject()
    }
    
}

