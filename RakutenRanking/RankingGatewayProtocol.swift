//
//  RankingGatewayProtocol.swift
//  RakutenRanking
//
//  Created by mao takagai on 2018/03/28.
//  Copyright © 2018年 mao takagai. All rights reserved.
//

import Foundation

protocol RankingGatewayProtocol {
    
    var itemArray: [Item] { get set }
    
    func getOverallRankingRes()
    
    func getFemaleRankingRes()
    
    func getMaleRankingRes()
    
    func get10sRankingRes()
    
    func get20sRankingRes()
    
    func get30sRankingRes()
    
    func get40sRankingRes()
    
    func get50sOverRankingRes()
    
    func get10sFemaleRankingRes()
    
    func get10sMaleRankingRes()
    
    func get20sFemaleRankingRes()
    
    func get20sMaleRankingRes()
    
    func get30sFemaleRankingRes()
    
    func get30sMaleRankingRes()
    
    func get40sFemaleRankingRes()
    
    func get40sMaleRankingRes()
    
    func get50sOverFemaleRankingRes()
    
    func get50sOverMaleRankingRes()
    
}
