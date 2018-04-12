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
        // TODO: パース
        let json = JSON(data!)
        
        for i in 0...30 {
            // Itemオブジェクトを生成
            let item = Item()
            // 各要素を抽出、代入
            if let itemName = json["Items"][i]["Item"]["itemName"].string {
                item.name = itemName
                print(itemName)
            }
            if let itemPrice = json["Items"][i]["Item"]["itemPrice"].string {
                item.price = itemPrice
                print(itemPrice)
            }
            if let smallImageUrl = json["Items"][i]["Item"]["smallImageUrls"][0]["imageUrl"].string {
                item.sSizeImageUrl = smallImageUrl
                print(smallImageUrl)
            }
            if let mediumImageUrl = json["Items"][i]["Item"]["mediumImageUrls"][0]["imageUrl"].string {
                item.mSizeImageUrl = mediumImageUrl
                print(mediumImageUrl)
            }
            // itemArrayに追加
            itemArray.append(item)
        }
        print(itemArray)
        return itemArray
        }
}
