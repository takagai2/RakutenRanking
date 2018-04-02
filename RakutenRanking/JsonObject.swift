//
//  JsonObject.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/28.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation

class JsonObject {
    
    private let rankingGateway = RankingGateway()
    
    func setData() {
        // TODO: 受け取ったレスポンスを格納
        let testJsonData: [[String]] = rankingGateway.testArray
    }
    
    func getItems() {
        // TODO: パース
        // TODO: 該当データ抽出
        // TODO: Itemオブジェクト生成
        // TODO: Itemオブジェクトにデータ代入
        // TODO: Arrayに追加
        for i in 0...29 {
            let item = Item()
            item.name = "\(rankingGateway.testArray[0][i])"
            item.price = "\(rankingGateway.testArray[1][i])"
            item.imageUrlS = "\(rankingGateway.testArray[2][i])"
            item.imageUrlM = "\(rankingGateway.testArray[3][i])"
            
            rankingGateway.itemArray.append(item)
        }

    }
    
}
