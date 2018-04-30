//
//  DataGateway.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/04/19.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftDate

class DataGateway: DataGatewayProtocol {
    
    let realm = try! Realm()
    let userDefaults = UserDefaults.standard
    
    func saveItems(gender: Gender, age: Age, array: [Item]) {
        // [Item]を変換して保存する処理
        for (index, item) in array.enumerated() {
            let rankingObject = RankingObject()
            rankingObject.rank = index + 1
            rankingObject.genderType = gender.rawValue
            rankingObject.ageType = age.rawValue
            rankingObject.name = item.name
            rankingObject.price = item.price
            rankingObject.sSizeImageUrl =  item.sSizeImageUrl
            rankingObject.mSizeImageUrl = item.mSizeImageUrl
            rankingObject.itemCode = item.itemCode
            rankingObject.reviewCount = item.reviewCount
            rankingObject.id = rankingObject.createNewId()
            try! realm.write {
                    realm.add(rankingObject, update: true)
            }
        }
    }
    
    func getItems(gender: Gender, age: Age, _ callback: @escaping ([Item]) -> Void) {
        // 指定されたgender,ageに当てはまるオブジェクトをrealmから取得
        let rankingData = realm.objects(RankingObject.self).filter("genderType = %@ AND ageType = %@",
                                                                gender.rawValue, age.rawValue)
        var itemArray = [Item]()
        // 取得したオブジェクトを[Item]に変換して返す
        rankingData.forEach { obj in
            let item = Item()
            item.name = obj.name
            item.price = obj.price
            item.sSizeImageUrl = obj.sSizeImageUrl
            item.mSizeImageUrl = obj.mSizeImageUrl
            item.itemCode = obj.itemCode
            item.reviewCount = obj.reviewCount
            itemArray.append(item)
        }
        callback(itemArray)
    }
    
    func deleteDataObject() {
        // キャッシュクリア
        try! realm.write{
            realm.deleteAll()
        }
    }
    
    func saveOrDeleteFavoriteItem(item: Item) {
        let obj: Results<FavoriteObject> = realm.objects(FavoriteObject.self).filter("itemCode = %@", item.itemCode)
        if obj.count == 0 {
            // データに同じItemがなければお気に入りに保存
            let favoriteObject = FavoriteObject()
            let date = Date()
            favoriteObject.name = item.name
            favoriteObject.price = item.price
            favoriteObject.sSizeImageUrl = item.sSizeImageUrl
            favoriteObject.mSizeImageUrl = item.mSizeImageUrl
            favoriteObject.itemCode = item.itemCode
            favoriteObject.reviewCount = Int(item.reviewCount)
            favoriteObject.id = favoriteObject.createNewId()
            favoriteObject.date = date.string(custom: "YYYY/MM/dd")
            try! realm.write {
                realm.add(favoriteObject)
            }
        } else {
            // 保存されているitemであれば削除
            try! realm.write() {
                realm.delete(obj)
            }
        }
    }
    
    func getFavoriteItems(_ callback: @escaping ([Item]) -> Void) {
        // お気に入りに保存しているitemを全件取得
        let favoriteItems = realm.objects(FavoriteObject.self)
        var itemArray = [Item]()
        
        favoriteItems.forEach { obj in
            let item = Item()
            item.name = obj.name
            item.price = obj.price
            item.sSizeImageUrl = obj.sSizeImageUrl
            item.mSizeImageUrl = obj.mSizeImageUrl
            item.itemCode = obj.itemCode
            item.reviewCount = Int(obj.reviewCount)
            itemArray.append(item)
        }
        callback(itemArray)
    }
    
    func deleteFavoriteObject() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func saveRankingType(genderType: Gender, ageType: Age) {
        // Key値を指定して保存
        userDefaults.set(genderType.rawValue, forKey: "genderType")
        userDefaults.set(ageType.rawValue, forKey: "ageType")
    }
    
    func getRankingType() -> (genderType: Gender, ageType: Age) {
        // Key値を指定して値を取得
        let genderType: Gender = Gender(rawValue: userDefaults.integer(forKey: "genderType"))!
        let ageType: Age = Age(rawValue: userDefaults.integer(forKey: "ageType"))!
        return(genderType, ageType)
    }
}
