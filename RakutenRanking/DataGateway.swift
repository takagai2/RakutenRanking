//
//  DataGateway.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/04/19.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation
import RealmSwift

class DataGateway: DataGatewayProtocol {
    
    let realm = try! Realm()
    
    func saveItems(gender: Gender, age: Age, array: [Item]) {
        // [Item]を変換して保存する処理
        for (index, item) in array.enumerated() {
            let dataObject = DataObject()
            dataObject.rank = index + 1
            dataObject.genderType = gender.rawValue
            dataObject.ageType = age.rawValue
            dataObject.name = item.name
            dataObject.price = item.price
            dataObject.sSizeImageUrl =  item.sSizeImageUrl
            dataObject.mSizeImageUrl = item.mSizeImageUrl
            
            try! realm.write {
                if dataObject.id == 0 { dataObject.id = dataObject.createNewId() }
                    realm.add(dataObject, update: true)
            }
        }
    }
    
    func getItems(gender: Gender, age: Age, _ callback: @escaping ([Item]) -> Void) {
        // 指定されたgender,ageに当てはまるオブジェクトをrealmから取得
        let rankingData = realm.objects(DataObject.self).filter("genderType = %@ AND ageType = %@",
                                                                gender.rawValue, age.rawValue)
        var itemArray = [Item]()
        // 取得したオブジェクトを[Item]に変換して返す
        rankingData.forEach { obj in
            let item = Item()
            item.name = obj.name
            item.price = obj.price
            item.sSizeImageUrl = obj.sSizeImageUrl
            item.mSizeImageUrl = obj.mSizeImageUrl
            itemArray.append(item)
            print(obj.id)
            print(obj.rank)
            print(obj.sSizeImageUrl)
        }
        callback(itemArray)
    }
    
}
