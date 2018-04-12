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
    
    private let rankingGateway: RankingGatewayProtocol = RankingGateway()

    // 総合ランキング
    func getOverallRanking(_ callback: ([Item]) -> Void) {
        rankingGateway.getOverallRankingRes({(array: [Item]) -> Void in
            // TODO: Realmに保存する処理
            // XXXViewControllerにItemを渡す処理
            callback(array)
        })
        
    }
    
    // 男女別ランキング
    func getRankingByGender(gender: Gender, _ callback: ([Item]) -> Void) {
        rankingGateway.getRankingByGenderRes(gender: gender, {(array: [Item]) -> Void in
            // TODO: Realmに保存する処理
            // XXXViewControllerにItemを渡す処理
            callback(array)
        })
    }
    
    // 年齢別ランキング
    func getRankingByAge(age: Age, _ callback: ([Item]) -> Void) {
        rankingGateway.getRankingByAgeRes(age: age, {(array: [Item]) -> Void in
            // TODO: Realmに保存する処理
            // XXXViewControllerにItemを渡す処理
            callback(array)
        })
    }
    
    // 男女年齢別ランキング
    func getRankingByGenderAge(gender: Gender, age: Age, _ callback: ([Item]) -> Void) {
        rankingGateway.getRankingByGenderAgeRes(gender: gender, age: age, {(array: [Item]) -> Void in
            // TODO: Realmに保存する処理
            // XXXViewControllerにItemを渡す処理
            callback(array)
        })
        
    }
    
}

