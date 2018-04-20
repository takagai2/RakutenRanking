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
    
    func saveItems(array: [Item]) {
        // [Item]を変換して保存する処理
        for (index, item) in array.enumerated() {
            let dataObject = DataObject()
            dataObject.rank = index + 1
            dataObject.name = item.name
            dataObject.price = item.price
            dataObject.sSizeImageUrl =  item.sSizeImageUrl
            dataObject.mSizeImageUrl = item.mSizeImageUrl
            
            if realm.isInWriteTransaction {
                if dataObject.id == 0 { dataObject.id = dataObject.createNewId() }
                realm.add(dataObject, update: true)
            } else {
                try! realm.write {
                    if dataObject.id == 0 { dataObject.id = dataObject.createNewId() }
                    realm.add(dataObject, update: true)
                }
            }
        }
    }
    
    func getItems(gender: Gender? = nil, age: Age? = nil, _ callback: @escaping ([Item]) -> Void) {
        // 指定されたgender,ageに当てはまるオブジェクトをrealmから取得
        let rankingData = realm.objects(DataObject.self).filter("genderType = \(String(describing: gender)) AND ageType = \(String(describing: age))")
        print(rankingData)
        // TODO: 取得したオブジェクトを[Item]に変換して返す
        let array = [Item]()
        callback(array)
    }
    
}
