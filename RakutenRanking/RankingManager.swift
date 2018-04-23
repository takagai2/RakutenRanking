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
    
    // 総合ランキング
    func getOverallRanking(gender: Gender, age: Age, _ callback: @escaping ([Item]) -> Void) {
        // Realmから呼び出す処理
        self.dataGateway.getItems(gender: gender, age: age, {[weak self](items: [Item]) -> Void in
            guard let `self` = self else { return }
            // Realmに保存されていなければapi取得
            if items.isEmpty {
                print("保存されていないのでapi取得")
                self.rankingGateway.getOverallRankingRes(gender: gender, age: age, {[weak self](array: [Item]) -> Void in
                    guard let `self` = self else { return }
                    // arrayをRealmに保存する処理
                    self.dataGateway.saveItems(gender: gender, age: age, array: array)
                    // XXXViewControllerにItemを渡す処理
                    callback(array)
                })
            } else {
                print("保存されていたのでrealmから取得")
                callback(items)
            }
        })
    }
    
    // 男女別ランキング
    func getRankingByGender(gender: Gender, age: Age, _ callback: @escaping ([Item]) -> Void) {
        // Realmから呼び出す処理
        self.dataGateway.getItems(gender: gender, age: age, {[weak self](items: [Item]) -> Void in
            guard let `self` = self else { return }
            // Realmに保存されていなければapi取得
            if items.isEmpty {
                print("保存されていないのでapi取得")
                self.rankingGateway.getRankingByGenderRes(gender: gender, age: age, {[weak self](array: [Item]) -> Void in
                    guard let `self` = self else { return }
                    // arrayをRealmに保存する処理
                    self.dataGateway.saveItems(gender: gender, age: age, array: array)
                    // XXXViewControllerにItemを渡す処理
                    callback(array)
                })
            } else {
                print("保存されていたのでrealmから取得")
                callback(items)
            }
        })
    }
    
    // 年齢別ランキング
    func getRankingByAge(gender: Gender, age: Age, _ callback: @escaping ([Item]) -> Void) {
        // Realmから呼び出す処理
        self.dataGateway.getItems(gender: gender, age: age, {[weak self](items: [Item]) -> Void in
            guard let `self` = self else { return }
            // Realmに保存されていなければapi取得
            if items.isEmpty {
                print("保存されていないのでapi取得")
                self.rankingGateway.getRankingByAgeRes(gender: gender, age: age, {[weak self](array: [Item]) -> Void in
                    guard let `self` = self else { return }
                    // arrayをRealmに保存する処理
                    self.dataGateway.saveItems(gender: gender, age: age, array: array)
                    // XXXViewControllerにItemを渡す処理
                    callback(array)
                })
            } else {
                print("保存されていたのでrealmから取得")
                callback(items)
            }
        })
    }
    
    // 男女年齢別ランキング
    func getRankingByGenderAge(gender: Gender, age: Age, _ callback: @escaping ([Item]) -> Void) {
        // Realmから呼び出す処理
        self.dataGateway.getItems(gender: gender, age: age, {[weak self](items: [Item]) -> Void in
            guard let `self` = self else { return }
            // Realmに保存されていなければapi取得
            if items.isEmpty {
                print("保存されていないのでapi取得")
                self.rankingGateway.getRankingByGenderAgeRes(gender: gender, age: age, {[weak self](array: [Item]) -> Void in
                    guard let `self` = self else { return }
                    // arrayをRealmに保存する処理
                    self.dataGateway.saveItems(gender: gender, age: age, array: array)
                    // XXXViewControllerにItemを渡す処理
                    callback(array)
                })
            } else {
                print("保存されていたのでrealmから取得")
                callback(items)
            }
        })
    }
    
}

