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
        // TODO: [Item]を変換して保存する処理
    }
    
    func getItems(gender: Gender? = nil, age: Age? = nil, _ callback: @escaping ([Item]) -> Void) {
        // TODO: realmに保存されているオブジェクトを取得
        // TODO: 取得したオブジェクトを[Item]に変換して返す
        let array = [Item]()
        callback(array)
    }
    
}
