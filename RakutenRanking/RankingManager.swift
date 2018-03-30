//
//  RankingManager.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/28.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation

enum Gender {
    
    case male
    case female
}

enum Age {
    
    case teens
    case twenties
    case thirties
    case forties
    case fiftiesOver
}

class RankingManager {
    
    let rankingGateway: RankingGatewayProtocol = RankingGateway()
    
    // 総合ランキング
    func getOverallRanking() {
        // TODO: 総合ランキング呼び出し
    }
    
    // 男女別ランキング
    func getRankingByGender(gender: Gender) {
        // 男女別ランキングの呼び出し
    }
    
    // 年齢別ランキング
    func getRankingByAge(age: Age) {
        // 年齢別ランキングの呼び出し
    }
    
    // 男女年齢別ランキング
    func getRankingByGenderAge(gender: Gender, age: Age) {
        // 男女年齢別ランキングの呼び出し
        
    }
    
}

