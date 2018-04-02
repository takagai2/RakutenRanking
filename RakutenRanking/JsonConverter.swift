//
//  JsonObject.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/28.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation

class JsonConverter {
    
    func getItems(_ data: [[String]]) -> [Item] {
        var itemArray: [Item] = []
        // TODO: パース
        
        // TODO: Itemオブジェクト生成
        let item = Item()
        
        for i in 0...29 {
            // TODO: 該当データ抽出
            // TODO: Itemオブジェクトにデータ代入
            item.name = data[0][i]
            item.price = data[1][i]
            item.imageUrlS = data[2][i]
            item.imageUrlM = data[3][i]
            
            itemArray.append(item)
        }
        return itemArray
    }
    
}
