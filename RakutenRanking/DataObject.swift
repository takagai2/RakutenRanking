//
//  DataObject.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/04/18.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation
import RealmSwift

class DataObject: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var price = ""
    @objc dynamic var sSizeImageUrl = ""
    @objc dynamic var mSizeImageUrl = ""
    @objc dynamic var itemCode = ""
    @objc dynamic var reviewCount = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // 新しいidを取得
    func createNewId() -> Int {
        let realm = try! Realm()
        return (realm.objects(type(of: self).self).sorted(byKeyPath: "id", ascending: false).first?.id ?? 0) + 1
    }
}
