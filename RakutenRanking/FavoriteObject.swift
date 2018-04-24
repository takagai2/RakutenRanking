//
//  FavoriteObject.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/04/24.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation
import RealmSwift

class FavoriteObject: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var price = ""
    @objc dynamic var sSizeImageUrl = ""
    @objc dynamic var mSizeImageUrl = ""
    @objc dynamic var itemCode = ""
    @objc dynamic var date = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    // 新しいidを取得
    func createNewId() -> Int {
        let realm = try! Realm()
        return (realm.objects(type(of: self).self).sorted(byKeyPath: "id", ascending: false).first?.id ?? 0) + 1
    }
}
