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
    
    // 総合ランキングの呼び出し
    func getOverallRanking() {
        rankingGateway.getOverallRankingRes()
        // TODO: 総合ランキングを返す
    }
    
    // 男女別ランキングの呼び出し
    func getRankingByGender(gender: Gender) {
        switch gender {
        case .female:
            rankingGateway.getFemaleRankingRes()
            // TODO: 女性ランキングを返す処理
        case .male:
            rankingGateway.getMaleRankingRes()
            // TODO: 男性ランキングを返す処理
        }
        return
    }
    
    // 年齢別ランキングの呼び出し
    func getRankingByAge(age: Age) {
        switch age {
        case .teens:
            rankingGateway.get10sRankingRes()
            // TODO: 10代ランキングを返す処理
        case .twenties:
            rankingGateway.get20sRankingRes()
            // TODO: 20代ランキングを返す処理
        case .thirties:
            rankingGateway.get30sRankingRes()
            // TODO: 30代ランキングを返す処理
        case .forties:
            rankingGateway.get40sRankingRes()
            // TODO: 40代ランキングを返す処理
        case .fiftiesOver:
            rankingGateway.get50sOverRankingRes()
            // TODO: 50代ランキングを返す処理
        }
        return
    }
    
    // 男女年齢別ランキングの呼び出し
    func getRankingByGenderAge(gender: Gender, age: Age) {
        switch age {
        case .teens:
            if gender == .female {
                rankingGateway.get10sFemaleRankingRes()
                // TODO: 10代女性ランキングを返す処理
            } else {
                rankingGateway.get10sMaleRankingRes()
                // TODO: 10代男性ランキングを返す処理
            }
        case .twenties:
            if gender == .female {
                rankingGateway.get20sFemaleRankingRes()
                // TODO: 20代女性ランキングを返す処理
            } else {
                rankingGateway.get20sMaleRankingRes()
                // TODO: 20代男性ランキングを返す処理
            }
        case .thirties:
            if gender == .female {
                rankingGateway.get30sFemaleRankingRes()
                // TODO: 30代女性ランキングを返す処理
            } else {
                rankingGateway.get30sMaleRankingRes()
                // TODO: 30代男性ランキングを返す処理
            }
        case .forties:
            if gender == .female {
                rankingGateway.get40sFemaleRankingRes()
                // TODO: 40代女性ランキングを返す処理
            } else {
                rankingGateway.get40sMaleRankingRes()
                // TODO: 40代男性ランキングを返す処理
            }
        case .fiftiesOver:
            if gender == .female {
                rankingGateway.get50sOverFemaleRankingRes()
                // TODO: 50代以上女性ランキングを返す処理
            } else {
                rankingGateway.get50sOverMaleRankingRes()
                // TODO: 50代以上男性ランキングを返す処理
            }
        }
        return
    }
    
}

