//
//  JsonObject.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/28.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation
import SwiftyJSON

class JsonConverter {
    
    func getItems(_ data: Any?) -> [Item] {
        var itemArray: [Item] = []
        // パース
        let rankingJson = JSON(data!)
        
        rankingJson["Items"].forEach { (_, object) in
            // Itemオブジェクトを生成
            let item = Item()
            // 各要素を抽出、代入
            item.name = object["Item"]["itemName"].string!
            item.price = object["Item"]["itemPrice"].string!
            item.sSizeImageUrl = object["Item"]["smallImageUrls"][0]["imageUrl"].string!
            item.mSizeImageUrl = object["Item"]["mediumImageUrls"][0]["imageUrl"].string!
            item.itemCode = object["Item"]["itemCode"].string!
            // itemArrayに追加
            itemArray.append(item)
        }
        return itemArray
    }
}
