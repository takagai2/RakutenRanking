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
    
    func saveFavoriteItem(item: Item) {
        // Itemをお気に入りに保存
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
}
