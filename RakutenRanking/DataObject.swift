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
    
    @objc dynamic var rankingType: String = ""
    @objc dynamic var rank: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var price: String = ""
    @objc dynamic var sSizeImageUrl: String = ""
    @objc dynamic var mSIzeImageUrl: String = ""
    
}
