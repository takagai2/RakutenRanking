//
//  RankingObject.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/04/24.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation
import RealmSwift

class RankingObject: DataObject {
    
    @objc dynamic var genderType = 0
    @objc dynamic var ageType = 0
    @objc dynamic var rank = 0
}
