//
//  JsonObject.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/28.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation

class JsonConverter {
    
    func getItems(_ data: Any?) -> [Item] {
        print(data)
        var itemArray: [Item] = []
        // TODO: パース

//        data.forEach{ (datum) in
//            // Itemオブジェクトを生成
//            let item = Item()
//            // 各要素を抽出、代入
//            item.name = datum[0]
//            item.price = datum[1]
//            item.sSizeImageUrl = datum[2]
//            item.mSizeImageUrl = datum[3]
//            // itemArrayに追加
//            itemArray.append(item)
//        }
        return itemArray
    }
    
}
