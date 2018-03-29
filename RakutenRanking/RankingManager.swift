//
//  RankingManager.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/28.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation

class RankingManager {
    
    let rankingGateway: RankingGatewayProtocol = RankingGateway()
    
    // TODO: segmentの選択結果によって取得するランキング種別を決定
    func getOverallRanking() {
        rankingGateway.getOverallRankingRes()
    }
    
    func getFemaleRanking() {
        rankingGateway.getFemaleRankingRes()
    }
    
    func getMaleRanking() {
        rankingGateway.getMaleRankingRes()
    }
    
    func get10sRanking() {
        rankingGateway.get10sRankingRes()
    }
    
    func get20sRanking() {
        rankingGateway.get20sRankingRes()
    }
    
    func get30sRanking() {
        rankingGateway.get30sRankingRes()
    }
    
    func get40sRanking() {
        rankingGateway.get40sRankingRes()
    }
    
    func get50sOverRanking() {
        rankingGateway.get50sOverRankingRes()
    }
    
    func get10sFemaleRanking() {
        rankingGateway.get10sFemaleRankingRes()
    }
    
    func get10sMaleRanking() {
        rankingGateway.get10sMaleRankingRes()
    }
    
    func get20sFemaleRanking() {
        rankingGateway.get20sFemaleRankingRes()
    }
    
    func get20sMaleRanking() {
        rankingGateway.get20sMaleRankingRes()
    }
    
    func get30sFemaleRanking() {
        rankingGateway.get30sFemaleRankingRes()
    }
    
    func get30sMaleRanking() {
        rankingGateway.get30sMaleRankingRes()
    }
    
    func get40sFemaleRanking() {
        rankingGateway.get40sFemaleRankingRes()
    }
    
    func get40sMaleRanking() {
        rankingGateway.get40sMaleRankingRes()
    }
    
    func get50sOverFemaleRanking() {
        rankingGateway.get50sOverFemaleRankingRes()
    }
    
    func get50sOverMaleRanking() {
        rankingGateway.get50sOverMaleRankingRes()
    }
    
}
