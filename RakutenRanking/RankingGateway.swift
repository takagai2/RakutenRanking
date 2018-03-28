//
//  RankingGateway.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/28.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation

class RankingGateway: JsonObject, RankingGatewayProtocol {
    
    // 取得した情報を入れる空配列
    var nameArray: [String] = []
    var priceArray: [String] = []
    var imageUrlArray: [String] = []
    var urlArray: [String] = []
    
    func getRes(url: String) {
        // TODO: 通信処理を行ってレスポンスを取得
        //       success -> パース -> 空配列に追加
    }
    
}
