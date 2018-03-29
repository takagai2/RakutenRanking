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
    func getOverallRanking(url: String) {
        rankingGateway.getOverallRankingRes()
    }
    
    func getFemaleRanking(url: String) {
        rankingGateway.getFemaleRankingRes()
    }
    
    func getMaleRanking(url: String) {
        rankingGateway.getMaleRankingRes()
    }
    
    func get10sRanking(url: String) {
        rankingGateway.get10sRankingRes()
    }
    
    func get20sRanking(url: String) {
        rankingGateway.get20sRankingRes()
    }
    
    func get30sRanking(url: String) {
        rankingGateway.get30sRankingRes()
    }
    
    func get40sRanking(url: String) {
        rankingGateway.get40sRankingRes()
    }
    
    func get50sOverRanking(url: String) {
        rankingGateway.get50sOverRankingRes()
    }
    
    func get10sFemaleRanking(url: String) {
        rankingGateway.get10sFemaleRankingRes()
    }
    
    func get10sMaleRanking(url: String) {
        rankingGateway.get10sMaleRankingRes()
    }
    
    func get20sFemaleRanking(url: String) {
        rankingGateway.get20sFemaleRankingRes()
    }
    
    func get20sMaleRanking(url: String) {
        rankingGateway.get20sMaleRankingRes()
    }
    
    func get30sFemaleRanking(url: String) {
        rankingGateway.get30sFemaleRankingRes()
    }
    
    func get30sMaleRanking(url: String) {
        rankingGateway.get30sMaleRankingRes()
    }
    
    func get40sFemaleRanking(url: String) {
        rankingGateway.get40sFemaleRankingRes()
    }
    
    func get40sMaleRanking(url: String) {
        rankingGateway.get40sMaleRankingRes()
    }
    
    func get50sOverFemaleRanking(url: String) {
        rankingGateway.get50sOverFemaleRankingRes()
    }
    
    func get50sOverMaleRanking(url: String) {
        rankingGateway.get50sOverMaleRankingRes()
    }
    
}
