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
    @objc dynamic var genderType: Int? = nil
    @objc dynamic var ageType: Int? = nil
    @objc dynamic var rank = 0
    @objc dynamic var name = ""
    @objc dynamic var price = ""
    @objc dynamic var sSizeImageUrl = ""
    @objc dynamic var mSIzeImageUrl = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
