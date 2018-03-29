//
//  RankingManager.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/28.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation

class RankingManager {
    
    // TODO: ランキング種別ごとにURLを保持
    var url: String = ""
    
    let rankingGateway: RankingGatewayProtocol = RankingGateway()
    
    // TODO: segmentの選択結果によって取得するランキング種別を決定
    func getRanking() {
        rankingGateway.getRes(url: url)
    }
    
}
