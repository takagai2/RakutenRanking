//
//  RankingManager.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/28.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation

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
    
    func deleteData(gender: Gender, age: Age) {
        dataGateway.deleteDataObject(gender: gender, age: age)
    }
    
    func deleteAllData() {
        dataGateway.deleteAllDataObject()
    }
    
    func saveOrDeleteFavoriteObject(item: Item) {
        dataGateway.saveOrDeleteFavoriteItem(item: item)
    }
    
    func isFavorite(item: Item) -> Bool {
        return dataGateway.isFavorite(item: item)
    }
    
    func getFavoriteItem(_ callback: @escaping ([Item]) -> Void) {
        dataGateway.getFavoriteItems({(items: [Item]) -> Void in
            callback(items)
        })
    }
    
    func deleteAllFavoriteItem() {
        dataGateway.deleteAllFavoriteObject()
    }
    
    func saveRankingTypeAtStartup(gender: Gender, age: Age) {
        dataGateway.saveRankingType(genderType: gender, ageType: age)
    }
    
    func getRankingTypeAtStartup() -> (gender: Gender, age: Age) {
        let type = dataGateway.getRankingType()
        let gender = type.genderType
        let age = type.ageType
        return(gender, age)
    }
}

