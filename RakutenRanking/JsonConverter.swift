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
    
    func getItems(_ data: Any?, _ callback: ([Item]) -> Void) {
        var itemArray: [Item] = []
        // パース
        let json = JSON(data!)
        
        json["Items"].forEach { (_, json) in
            // Itemオブジェクトを生成
            let item = Item()
            // 各要素を抽出、代入
            item.name = json["Item"]["itemName"].string!
            item.price = json["Item"]["itemPrice"].string!
            item.sSizeImageUrl = json["Item"]["smallImageUrls"][0]["imageUrl"].string!
            item.mSizeImageUrl = json["Item"]["mediumImageUrls"][0]["imageUrl"].string!
            // itemArrayに追加
            itemArray.append(item)
        }
        callback(itemArray)
        }
}
